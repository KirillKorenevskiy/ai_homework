import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/providers/cat_breeds_provider.dart';
import '../domain/providers/models/cat_breed.dart';
import '../generated/l10n.dart';

class BreedDetailScreen extends StatelessWidget {
  final String breedId;

  const BreedDetailScreen({
    Key? key,
    required this.breedId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<CatBreedsProvider>(
        builder: (context, provider, _) {
          final breed = provider.breeds.firstWhere(
            (b) => b.id == breedId,
            orElse: () => provider.selectedBreed!,
          );

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(breed.name),
                  background: breed.imageUrl != null
                      ? Image.network(
                          breed.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color:
                                Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.grey[200],
                            child: Icon(Icons.pets,
                                size: 80,
                                color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.grey),
                          ),
                        )
                      : Container(
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.grey[200],
                          child: Icon(Icons.pets,
                              size: 80,
                              color: Theme.of(context).brightness == Brightness.dark ? Colors.white70 : Colors.grey),
                        ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (breed.description != null)
                        _buildSection(
                          context,
                          title: AppLocalizations.of(context).description,
                          content: breed.description!,
                        ),
                      const SizedBox(height: 16),
                      _buildDivider(),
                      _buildSection(
                        context,
                        title: AppLocalizations.of(context).origin,
                        content: breed.origin ?? AppLocalizations.of(context).noDescription,
                      ),
                      const SizedBox(height: 8),
                      _buildSection(
                        context,
                        title: AppLocalizations.of(context).lifeSpan,
                        content: breed.lifeSpan ?? AppLocalizations.of(context).noDescription,
                      ),
                      const SizedBox(height: 16),
                      _buildDivider(),
                      if (breed.temperament != null)
                        _buildSection(
                          context,
                          title: AppLocalizations.of(context).temperament,
                          content: breed.temperament!,
                        ),
                      const SizedBox(height: 16),
                      _buildDivider(),
                      _buildTraitSection(context, breed),
                      if (breed.wikipediaUrl != null) ...[
                        const SizedBox(height: 16),
                        _buildDivider(),
                      ],
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(BuildContext context, {required String title, required String content}) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    
    return Card(
      elevation: 1,
      color: isDarkTheme ? Colors.grey[900] : Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? Colors.white : null,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDarkTheme ? Colors.white70 : Colors.black87,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTraitSection(BuildContext context, CatBreed breed) {
    final l10n = AppLocalizations.of(context);
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 2,
      color: isDarkTheme ? Colors.grey[900] : Colors.grey[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Traits',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? Colors.white : null,
                  ),
            ),
            const SizedBox(height: 8),
            _buildTraitItem(context, l10n.adaptability, breed.adaptability),
            _buildTraitItem(context, l10n.affectionLevel, breed.affectionLevel),
            _buildTraitItem(context, l10n.childFriendly, breed.childFriendly),
            _buildTraitItem(context, l10n.dogFriendly, breed.dogFriendly),
            _buildTraitItem(context, l10n.energyLevel, breed.energyLevel),
            _buildTraitItem(context, l10n.grooming, breed.grooming),
            _buildTraitItem(context, l10n.healthIssues, breed.healthIssues),
            _buildTraitItem(context, l10n.intelligence, breed.intelligence),
            _buildTraitItem(context, l10n.sheddingLevel, breed.sheddingLevel),
            _buildTraitItem(context, l10n.socialNeeds, breed.socialNeeds),
            _buildTraitItem(context, l10n.strangerFriendly, breed.strangerFriendly),
          ],
        ),
      ),
    );
  }

  Widget _buildTraitItem(BuildContext context, String label, int? value) {
    if (value == null) return const SizedBox.shrink();
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        decoration: BoxDecoration(
          color: isDarkTheme ? Colors.grey[800] : Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isDarkTheme ? Colors.white70 : null,
                        ),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: LinearProgressIndicator(
                    value: value / 5,
                    backgroundColor: isDarkTheme ? Colors.grey[700] : Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '$value/5',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isDarkTheme ? Colors.white : null,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return const Divider(
      height: 1,
      thickness: 1,
      color: Colors.black12,
    );
  }
}

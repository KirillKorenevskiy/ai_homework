import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/providers/cat_breeds_provider.dart';
import '../core_ui/widgets/breed_card.dart';
import '../generated/l10n.dart';
import 'breed_detail_screen.dart';

class BreedsScreen extends StatefulWidget {
  const BreedsScreen({Key? key}) : super(key: key);

  @override
  State<BreedsScreen> createState() => _BreedsScreenState();
}

class _BreedsScreenState extends State<BreedsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CatBreedsProvider>().loadBreeds(refresh: true);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isLoadingMore) return;

    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    final threshold = maxScroll * 0.8;

    if (currentScroll > threshold) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore) return;

    final provider = context.read<CatBreedsProvider>();
    if (!provider.hasMore || provider.isLoading) return;

    setState(() => _isLoadingMore = true);
    await provider.loadBreeds();
    setState(() => _isLoadingMore = false);
  }

  Future<void> _onRefresh() async {
    await context.read<CatBreedsProvider>().loadBreeds(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CatBreedsProvider>(
      builder: (context, provider, _) {
        if (provider.error.isNotEmpty && provider.breeds.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.error, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () => provider.loadBreeds(refresh: true),
                  child: Text(AppLocalizations.of(context).retry),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context).searchBreeds,
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      ),
                      onChanged: provider.setSearchQuery,
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: Icon(
                      provider.isSortedAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    ),
                    onPressed: provider.toggleSortOrder,
                    tooltip: provider.isSortedAscending
                        ? '${AppLocalizations.of(context).sort} Z-A'
                        : '${AppLocalizations.of(context).sort} A-Z',
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                      itemCount: provider.breeds.length + 1,
                      itemBuilder: (context, index) {
                        if (index < provider.breeds.length) {
                          final breed = provider.breeds[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: BreedCard(
                              breed: breed,
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BreedDetailScreen(breedId: breed.id),
                                  ),
                                );
                              },
                            ),
                          );
                        } else {
                          return _buildLoadMoreIndicator(provider);
                        }
                      },
                    ),
                  ),
                  if (provider.isLoading && provider.breeds.isEmpty) const Center(child: CircularProgressIndicator()),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoadMoreIndicator(CatBreedsProvider provider) {
    if (!provider.hasMore) return const SizedBox.shrink();

    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../domain/providers/models/cat_breed.dart';

class BreedCard extends StatelessWidget {
  final CatBreed breed;
  final VoidCallback onTap;

  const BreedCard({
    Key? key,
    required this.breed,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.grey[900] 
          : Colors.grey[200],
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (breed.imageUrl != null)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        breed.imageUrl!,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 80,
                          height: 80,
                          color: Theme.of(context).brightness == Brightness.dark 
                              ? Colors.grey[800] 
                              : Colors.grey[200],
                          child: Icon(Icons.pets, size: 40, color: Theme.of(context).brightness == Brightness.dark 
                              ? Colors.white70 
                              : Colors.black54),
                        ),
                      ),
                    )
                  else
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.grey[800] 
                            : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.pets, 
                        size: 40,
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.white70 
                            : Colors.black54,
                      ),
                    ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          breed.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (breed.origin != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Origin: ${breed.origin!}',
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                        if (breed.temperament != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Temperament: ${breed.temperament!.split(',').take(3).join(',')}...',
                            style: theme.textTheme.bodySmall,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

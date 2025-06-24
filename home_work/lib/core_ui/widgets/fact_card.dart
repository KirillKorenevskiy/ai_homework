import 'package:flutter/material.dart';

import '../../domain/providers/models/cat_fact.dart';

class FactCard extends StatelessWidget {
  final CatFact fact;

  const FactCard({
    Key? key,
    required this.fact,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Theme.of(context).brightness == Brightness.dark 
          ? Colors.grey[900] 
          : Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              fact.fact,
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Length: ${fact.length} characters',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core_ui/widgets/app_button.dart';
import '../core_ui/widgets/fact_card.dart';
import '../domain/providers/cat_facts_provider.dart';
import '../generated/l10n.dart';

class RandomFactScreen extends StatefulWidget {
  const RandomFactScreen({super.key});

  @override
  State<RandomFactScreen> createState() => _RandomFactScreenState();
}

class _RandomFactScreenState extends State<RandomFactScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<CatFactsProvider>().loadRandomFact();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CatFactsProvider>(
      builder: (context, provider, _) {
        Widget content;

        if (provider.error.isNotEmpty && provider.randomFact == null) {
          content = Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.error),
                const SizedBox(height: 16),
                AppButton(
                  text: AppLocalizations.of(context).retry,
                  onPressed: provider.loadRandomFact,
                  width: 150,
                ),
              ],
            ),
          );
        } else if (provider.randomFact != null) {
          content = Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: FactCard(fact: provider.randomFact!),
            ),
          );
        } else {
          content = Center(
            child: Text(AppLocalizations.of(context).pressForRandomFact),
          );
        }

        return Stack(
          children: [
            Column(
              children: [
                Expanded(child: content),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AppButton(
                    text: AppLocalizations.of(context).getRandomFact,
                    onPressed: () {
                      if (!provider.isLoading) {
                        provider.loadRandomFact();
                      }
                    },
                    width: 300,
                    isLoading: provider.isLoading,
                  ),
                ),
              ],
            ),
            if (provider.isLoading && provider.randomFact == null) const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }
}

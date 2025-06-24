import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core_ui/widgets/app_button.dart';
import '../core_ui/widgets/fact_card.dart';
import '../domain/providers/cat_facts_provider.dart';
import '../generated/l10n.dart';

class FactsListScreen extends StatefulWidget {
  const FactsListScreen({super.key});

  @override
  State<FactsListScreen> createState() => _FactsListScreenState();
}

class _FactsListScreenState extends State<FactsListScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CatFactsProvider>().loadFacts(refresh: true);
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

    final provider = context.read<CatFactsProvider>();
    if (!provider.hasMore || provider.isLoading) return;

    setState(() => _isLoadingMore = true);
    await provider.loadFacts();
    setState(() => _isLoadingMore = false);
  }

  Future<void> _onRefresh() async {
    await context.read<CatFactsProvider>().loadFacts(refresh: true);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    
    return Consumer<CatFactsProvider>(
      builder: (context, provider, _) {
        if (provider.error.isNotEmpty && provider.facts.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.error,
                    style: TextStyle(
                      color: isDarkTheme ? Colors.white70 : Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  AppButton(
                    text: AppLocalizations.of(context).retry,
                    onPressed: () => provider.loadFacts(refresh: true),
                    width: 120,
                  ),
                ],
              ),
            ),
          );
        }

        return Stack(
          children: [
            RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.only(bottom: 16),
                itemCount: provider.facts.length + 1, // +1 for loading indicator
                itemBuilder: (context, index) {
                  if (index < provider.facts.length) {
                    final fact = provider.facts[index];
                    return FactCard(fact: fact);
                  } else {
                    return _buildLoadMoreIndicator(provider);
                  }
                },
              ),
            ),
            if (provider.isLoading && provider.facts.isEmpty) const Center(child: CircularProgressIndicator()),
          ],
        );
      },
    );
  }

  Widget _buildLoadMoreIndicator(CatFactsProvider provider) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    
    if (!provider.hasMore) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Center(
          child: Text(
            AppLocalizations.of(context).noFactsAvailable,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDarkTheme ? Colors.white70 : Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

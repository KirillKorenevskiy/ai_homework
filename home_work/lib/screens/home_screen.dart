import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../domain/providers/settings_provider.dart';
import '../generated/l10n.dart';
import 'facts_list_screen.dart';
import 'random_fact_screen.dart';
import 'breeds_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const FactsListScreen(),
    const RandomFactScreen(),
    const BreedsScreen(),
    const SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).appTitle),
        centerTitle: true,
        elevation: 0,
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label: AppLocalizations.of(context).allFacts,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.shuffle),
            label: AppLocalizations.of(context).randomFact,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.pets),
            label: AppLocalizations.of(context).breeds,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppLocalizations.of(context).settings,
          ),
        ],
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'data/services/cat_breed_service.dart';
import 'data/services/cat_fact_service.dart';
import 'domain/providers/cat_breeds_provider.dart';
import 'domain/providers/cat_facts_provider.dart';
import 'domain/providers/settings_provider.dart';
import 'generated/l10n.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => CatFactService()),
        Provider(create: (_) => CatBreedService()),
        ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ChangeNotifierProvider(
          create: (context) => CatFactsProvider(context.read<CatFactService>()),
        ),
        ChangeNotifierProvider(
          create: (context) => CatBreedsProvider(context.read<CatBreedService>()),
        ),
      ],
      child: Consumer<SettingsProvider>(
        builder: (context, settings, _) {
          return MaterialApp(
            title: 'Cat Facts',
            theme: settings.getTheme(context),
            darkTheme: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.blue[300]!,
                secondary: Colors.blue[200]!,
              ),
            ),
            themeMode: settings.themeMode,
            locale: settings.locale,
            supportedLocales: AppLocalizations.delegate.supportedLocales,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            home: Builder(
              builder: (context) {
                return const HomeScreen();
              },
            ),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

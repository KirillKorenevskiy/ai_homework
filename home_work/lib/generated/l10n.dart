// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class AppLocalizations {
  AppLocalizations();

  static AppLocalizations? _current;

  static AppLocalizations get current {
    assert(_current != null,
        'No instance of AppLocalizations was loaded. Try to initialize the AppLocalizations delegate before accessing AppLocalizations.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<AppLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = AppLocalizations();
      AppLocalizations._current = instance;

      return instance;
    });
  }

  static AppLocalizations of(BuildContext context) {
    final instance = AppLocalizations.maybeOf(context);
    assert(instance != null,
        'No instance of AppLocalizations present in the widget tree. Did you add AppLocalizations.delegate in localizationsDelegates?');
    return instance!;
  }

  static AppLocalizations? maybeOf(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  /// `Cat Facts`
  String get appTitle {
    return Intl.message(
      'Cat Facts',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get lightTheme {
    return Intl.message(
      'Light',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get darkTheme {
    return Intl.message(
      'Dark',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `System`
  String get systemTheme {
    return Intl.message(
      'System',
      name: 'systemTheme',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get language {
    return Intl.message(
      'Language',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get english {
    return Intl.message(
      'English',
      name: 'english',
      desc: '',
      args: [],
    );
  }

  /// `Russian`
  String get russian {
    return Intl.message(
      'Russian',
      name: 'russian',
      desc: '',
      args: [],
    );
  }

  /// `All Facts`
  String get allFacts {
    return Intl.message(
      'All Facts',
      name: 'allFacts',
      desc: '',
      args: [],
    );
  }

  /// `Random Fact`
  String get randomFact {
    return Intl.message(
      'Random Fact',
      name: 'randomFact',
      desc: '',
      args: [],
    );
  }

  /// `Breeds`
  String get breeds {
    return Intl.message(
      'Breeds',
      name: 'breeds',
      desc: '',
      args: [],
    );
  }

  /// `Search breeds...`
  String get searchBreeds {
    return Intl.message(
      'Search breeds...',
      name: 'searchBreeds',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get sort {
    return Intl.message(
      'Sort',
      name: 'sort',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get weight {
    return Intl.message(
      'Weight',
      name: 'weight',
      desc: '',
      args: [],
    );
  }

  /// `kg`
  String get kg {
    return Intl.message(
      'kg',
      name: 'kg',
      desc: '',
      args: [],
    );
  }

  /// `Life Span`
  String get lifeSpan {
    return Intl.message(
      'Life Span',
      name: 'lifeSpan',
      desc: '',
      args: [],
    );
  }

  /// `years`
  String get years {
    return Intl.message(
      'years',
      name: 'years',
      desc: '',
      args: [],
    );
  }

  /// `Origin`
  String get origin {
    return Intl.message(
      'Origin',
      name: 'origin',
      desc: '',
      args: [],
    );
  }

  /// `Temperament`
  String get temperament {
    return Intl.message(
      'Temperament',
      name: 'temperament',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `No description available`
  String get noDescription {
    return Intl.message(
      'No description available',
      name: 'noDescription',
      desc: '',
      args: [],
    );
  }

  /// `Error loading breeds`
  String get errorLoadingBreeds {
    return Intl.message(
      'Error loading breeds',
      name: 'errorLoadingBreeds',
      desc: '',
      args: [],
    );
  }

  /// `Error loading facts`
  String get errorLoadingFacts {
    return Intl.message(
      'Error loading facts',
      name: 'errorLoadingFacts',
      desc: '',
      args: [],
    );
  }

  /// `Pull to refresh`
  String get pullToRefresh {
    return Intl.message(
      'Pull to refresh',
      name: 'pullToRefresh',
      desc: '',
      args: [],
    );
  }

  /// `No facts available`
  String get noFactsAvailable {
    return Intl.message(
      'No facts available',
      name: 'noFactsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `No breeds found`
  String get noBreedsFound {
    return Intl.message(
      'No breeds found',
      name: 'noBreedsFound',
      desc: '',
      args: [],
    );
  }

  /// `Get Random Fact`
  String get getRandomFact {
    return Intl.message(
      'Get Random Fact',
      name: 'getRandomFact',
      desc: '',
      args: [],
    );
  }

  /// `Press the button to get a random fact`
  String get pressForRandomFact {
    return Intl.message(
      'Press the button to get a random fact',
      name: 'pressForRandomFact',
      desc: '',
      args: [],
    );
  }

  /// `View on`
  String get viewOn {
    return Intl.message(
      'View on',
      name: 'viewOn',
      desc: '',
      args: [],
    );
  }

  /// `Adaptability`
  String get adaptability {
    return Intl.message(
      'Adaptability',
      name: 'adaptability',
      desc: '',
      args: [],
    );
  }

  /// `Affection Level`
  String get affectionLevel {
    return Intl.message(
      'Affection Level',
      name: 'affectionLevel',
      desc: '',
      args: [],
    );
  }

  /// `Child Friendly`
  String get childFriendly {
    return Intl.message(
      'Child Friendly',
      name: 'childFriendly',
      desc: '',
      args: [],
    );
  }

  /// `Dog Friendly`
  String get dogFriendly {
    return Intl.message(
      'Dog Friendly',
      name: 'dogFriendly',
      desc: '',
      args: [],
    );
  }

  /// `Energy Level`
  String get energyLevel {
    return Intl.message(
      'Energy Level',
      name: 'energyLevel',
      desc: '',
      args: [],
    );
  }

  /// `Grooming`
  String get grooming {
    return Intl.message(
      'Grooming',
      name: 'grooming',
      desc: '',
      args: [],
    );
  }

  /// `Health Issues`
  String get healthIssues {
    return Intl.message(
      'Health Issues',
      name: 'healthIssues',
      desc: '',
      args: [],
    );
  }

  /// `Intelligence`
  String get intelligence {
    return Intl.message(
      'Intelligence',
      name: 'intelligence',
      desc: '',
      args: [],
    );
  }

  /// `Shedding Level`
  String get sheddingLevel {
    return Intl.message(
      'Shedding Level',
      name: 'sheddingLevel',
      desc: '',
      args: [],
    );
  }

  /// `Social Needs`
  String get socialNeeds {
    return Intl.message(
      'Social Needs',
      name: 'socialNeeds',
      desc: '',
      args: [],
    );
  }

  /// `Stranger Friendly`
  String get strangerFriendly {
    return Intl.message(
      'Stranger Friendly',
      name: 'strangerFriendly',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<AppLocalizations> load(Locale locale) => AppLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

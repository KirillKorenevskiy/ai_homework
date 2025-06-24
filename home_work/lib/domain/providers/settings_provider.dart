import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const String _localeKey = 'locale';
  
  late SharedPreferences _prefs;
  ThemeMode _themeMode = ThemeMode.system;
  Locale _locale = const Locale('en');

  ThemeMode get themeMode => _themeMode;
  Locale get locale => _locale;
  
  SettingsProvider() {
    _loadSettings();
  }
  
  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    
    // Load theme mode
    final themeIndex = _prefs.getInt(_themeKey) ?? ThemeMode.system.index;
    _themeMode = ThemeMode.values[themeIndex];
    
    // Load locale
    final languageCode = _prefs.getString(_localeKey) ?? 'en';
    _locale = Locale(languageCode);
    
    notifyListeners();
  }

  // Supported locales
  static final List<Locale> supportedLocales = [
    const Locale('en'),
    const Locale('ru'),
  ];

  // Localizations delegates
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];

  // Toggle between light and dark theme
  void toggleTheme(bool isDark) {
    setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  // Set theme mode (system, light, dark)
  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      _prefs.setInt(_themeKey, mode.index);
      notifyListeners();
    }
  }

  // Change app language
  void setLocale(Locale locale) {
    if (!supportedLocales.any((l) => l.languageCode == locale.languageCode)) return;
    if (_locale.languageCode != locale.languageCode) {
      _locale = locale;
      _prefs.setString(_localeKey, locale.languageCode);
      notifyListeners();
    }
  }

  // Check if current theme is dark
  bool isDarkMode(BuildContext context) {
    if (_themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return _themeMode == ThemeMode.dark;
  }

  // Get current theme data
  ThemeData getTheme(BuildContext context) {
    return isDarkMode(context)
        ? ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.blue[300]!,
              secondary: Colors.blue[200]!,
            ),
          )
        : ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              secondary: Colors.blue[700]!,
            ),
          );
  }
}

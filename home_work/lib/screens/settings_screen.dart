import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/providers/settings_provider.dart';
import '../generated/l10n.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).settings,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThemeSection(context),
            const SizedBox(height: 24),
            _buildLanguageSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSection(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).appearance,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _buildThemeOption(
                  context,
                  title: AppLocalizations.of(context).lightTheme,
                  icon: Icons.light_mode,
                  value: ThemeMode.light,
                  groupValue: settings.themeMode,
                  onChanged: settings.setThemeMode,
                ),
                _buildThemeOption(
                  context,
                  title: AppLocalizations.of(context).darkTheme,
                  icon: Icons.dark_mode,
                  value: ThemeMode.dark,
                  groupValue: settings.themeMode,
                  onChanged: settings.setThemeMode,
                ),
                _buildThemeOption(
                  context,
                  title: AppLocalizations.of(context).systemTheme,
                  icon: Icons.phone_android,
                  value: ThemeMode.system,
                  groupValue: settings.themeMode,
                  onChanged: settings.setThemeMode,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildThemeOption(
    BuildContext context, {
    required String title,
    required IconData icon,
    required ThemeMode value,
    required ThemeMode groupValue,
    required ValueChanged<ThemeMode> onChanged,
  }) {
    final isSelected = value == groupValue;
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: isSelected ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary) : null,
      onTap: () => onChanged(value),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : null,
    );
  }

  Widget _buildLanguageSection(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settings, _) {
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context).language,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 16),
                _buildLanguageOption(
                  context,
                  title: AppLocalizations.of(context).english,
                  locale: const Locale('en'),
                  currentLocale: settings.locale,
                  onChanged: settings.setLocale,
                ),
                _buildLanguageOption(
                  context,
                  title: AppLocalizations.of(context).russian,
                  locale: const Locale('ru'),
                  currentLocale: settings.locale,
                  onChanged: settings.setLocale,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required String title,
    required Locale locale,
    required Locale currentLocale,
    required ValueChanged<Locale> onChanged,
  }) {
    final isSelected = locale.languageCode == currentLocale.languageCode;
    return ListTile(
      title: Text(title),
      trailing: isSelected ? Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary) : null,
      onTap: () => onChanged(locale),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      tileColor: isSelected ? Theme.of(context).colorScheme.primary.withOpacity(0.1) : null,
    );
  }
}

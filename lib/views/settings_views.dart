import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourlittlepal/l10n/app_localizations.dart';
import 'package:yourlittlepal/providers/pet_provider.dart';

/// The settings view where users can customize app preferences and pet routines.
class SettingsView extends StatefulWidget {
  /// Creates the settings interface.
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  TimeOfDay _sleepTime = const TimeOfDay(hour: 22, minute: 0);
  TimeOfDay _mealTime = const TimeOfDay(hour: 12, minute: 0);
  TimeOfDay _wakeTime = const TimeOfDay(hour: 8, minute: 0);

  static const _languages = {
    'English': Locale('en', ''),
    'Español': Locale('es', ''),
    '繁體中文': Locale('zh', 'TW'),
  };

  String _localeToDisplayName(Locale locale) {
    for (final e in _languages.entries) {
      if (e.value.languageCode == locale.languageCode) {
        return e.key;
      }
    }
    return 'English';
  }

  Future<void> _selectTime(
    BuildContext context,
    String type,
    TimeOfDay initialTime,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      setState(() {
        if (type == 'sleep') _sleepTime = picked;
        if (type == 'meal') _mealTime = picked;
        if (type == 'wake') _wakeTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PetProvider>();
    final selectedLang = _localeToDisplayName(provider.currentLocale);
    final brightness = provider.brightness;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EA),
      appBar: AppBar(
        title: Text(
          l10n.settings,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: const Color(0xFF2B2B2B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Section 1: Application Settings
            Text(
              l10n.appSettings,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2B2B2B),
              ),
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xFF2B2B2B), width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        l10n.language,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      trailing: DropdownButton<String>(
                        value: selectedLang,
                        items: _languages.keys.map((String val) {
                          return DropdownMenuItem<String>(
                            value: val,
                            child: Text(val),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) provider.setLocale(_languages[val]!);
                        },
                      ),
                    ),
                    const Divider(),

                    // Brightness Selection
                    ListTile(
                      title: Text(
                        l10n.brightness,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Slider(
                        value: brightness,
                        activeColor: const Color(0xFF2B2B2B),
                        onChanged: (val) => provider.setBrightness(val),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

           
          ],
        ),
      ),
    );
  }

}

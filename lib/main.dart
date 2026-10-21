import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:yourlittlepal/l10n/app_localizations.dart';
import 'package:yourlittlepal/providers/pet_provider.dart';
import 'package:yourlittlepal/providers/position_provider.dart';
import 'package:yourlittlepal/providers/weather_provider.dart';

import 'package:yourlittlepal/views/start_view.dart';
import 'package:yourlittlepal/views/select_view.dart';
import 'package:yourlittlepal/views/game_view.dart';
import 'package:yourlittlepal/views/settings_views.dart';
import 'package:yourlittlepal/views/outfit_view.dart';
import 'package:yourlittlepal/views/shop_view.dart';

/// Entry point of the application.
/// Initializes necessary providers and sets up the app-wide state.
void main() async {
  // Required for plugin communication before runApp.
  WidgetsFlutterBinding.ensureInitialized();

  // Instantiate providers.
  final petProvider = PetProvider();
  final weatherProvider = WeatherProvider();
  final positionProvider = PositionProvider();

  // Perform asynchronous initialization (e.g., loading SharedPreferences or database).
  await petProvider.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: petProvider),
        ChangeNotifierProvider.value(value: weatherProvider),
        ChangeNotifierProvider.value(value: positionProvider),
      ],
      child: const MainApp(),
    ),
  );
}

/// The root widget of the application.
/// Configures localization, theme settings, and navigation routes.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Listen to PetProvider for dynamic UI updates (locale, font size, etc.).
    final provider = context.watch<PetProvider>();

    return MaterialApp(
      title: 'Your Little Pal',
      debugShowCheckedModeBanner: false,

      // --- Internationalization Configuration ---
      locale: provider.currentLocale,
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
        Locale('zh', 'TW'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

        // --- Theme Configuration ---
      // Uses a retro-inspired pixel aesthetic.
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          scaffoldBackgroundColor: const Color.fromARGB(255, 248, 248, 248),
          
          ),

      // --- Navigation Routing ---
      initialRoute: '/',
      routes: {
        '/': (context) => const StartPage(),
        '/select': (context) => const SelectView(),
        '/playground': (context) => const GameView(),
        '/settings': (context) => const SettingsView(),
        '/outfit': (context) => const OutfitView(),
        '/shop': (context) => const ShopView(),
      },
    );
  }
}

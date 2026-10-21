import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yourlittlepal/l10n/app_localizations.dart';
import 'package:yourlittlepal/models/pet_state.dart';
import 'package:yourlittlepal/providers/pet_provider.dart';
import 'package:yourlittlepal/providers/position_provider.dart';
import 'package:yourlittlepal/providers/weather_provider.dart';
import 'package:yourlittlepal/views/pet_view.dart';
import 'package:yourlittlepal/weather_conditions.dart';
import 'package:yourlittlepal/widgets/dialogue.dart';
import 'package:yourlittlepal/widgets/food_sheet.dart';
import 'package:yourlittlepal/widgets/stat_bar.dart';
import 'package:yourlittlepal/widgets/bottom_bar.dart';
import 'package:yourlittlepal/widgets/action_sheet.dart';
import 'package:yourlittlepal/widgets/toy_sheet.dart';

/// The primary game screen view that displays pet metrics, status, and control actions.
class GameView extends StatelessWidget {
  /// Creates the main game view interface.
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PetProvider>();
    final positionProvider = context.watch<PositionProvider>();
    final weatherProvider = context.watch<WeatherProvider>();
    final l10n = AppLocalizations.of(context)!;

    if (positionProvider.positionKnown) {
      weatherProvider.updateLocation(
        positionProvider.latitude!,
        positionProvider.longitude!,
      );
    }

    if (!provider.isLoaded) {
      return Scaffold(
        body: Center(
          child: Text(
            'LOADING PAL...',
            style: GoogleFonts.pixelifySans(fontSize: 18),
          ),
        ),
      );
    }
    final state = provider.state;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.pushNamed(context, '/settings'),
                    icon: Image.asset(
                      'assets/icons/setting.png',
                      width: 28,
                      height: 28,
                      semanticLabel: 'Settings',
                    ),
                  ),
                  Consumer<WeatherProvider>(
                    builder: (context, weather, _) {
                      if (!weather.isValid) {
                        return const SizedBox.shrink();
                      }
                      return Row(
                        children: [
                          Image.asset(
                            weatherIcon(weather.condition),
                            semanticLabel: weather.condition.name,
                            width: 28,
                            height: 28,
                            filterQuality: FilterQuality.none,
                          ),
                          const SizedBox(width: 3),
                          Semantics(
                            label: '${weather.tempInFahrenheit} degrees Fahrenheit',
                            child: Text(
                              '${weather.tempInFahrenheit}°F',
                              style: GoogleFonts.pixelifySans(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  StatBar(
                    name: l10n.health,
                    val: state.health / 100,
                    color: Colors.redAccent,
                  ),
                  const SizedBox(height: 8),
                  StatBar(
                    name: l10n.closeness,
                    val: state.closeness / 100,
                    color: Colors.orangeAccent,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 100,
              child: Dialogue(dialogue: provider.tempDialogue ?? l10n.hello),
            ),
            const SizedBox(height: 16),
            const Expanded(child: Center(child: PetView())),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
              child: Semantics(
                label: '${state.coins} coins',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/icons/coins.png', 
                      width: 28, 
                      height: 28,
                      excludeFromSemantics: true
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '${state.coins}',
                      style: GoogleFonts.pixelifySans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.amber[100],
                border: const Border(
                  top: BorderSide(
                    color: Color.fromRGBO(255, 236, 179, 1),
                    width: 2,
                  ),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  BottomBar(
                    
                    name: l10n.feed,
                    icon: 'assets/icons/feed.png',
                    onTap: () => showFeedSheet(context, provider),
                  ),
                  BottomBar(
                    name: l10n.water,
                    icon: 'assets/icons/water.png',
                    onTap: () async {
                      provider.water();
                      provider.showDialogue(l10n.dialogueWater);
                    },
                  ),
                  BottomBar(
                    name: l10n.wash,
                    icon: 'assets/icons/wash.png',
                    onTap: () async {
                      provider.startWashing();
                      provider.showDialogue(l10n.dialogueWash);
                    },
                  ),
                  BottomBar(
                    name: l10n.play,
                    icon: 'assets/icons/play.png',
                    onTap: () async {
                      showPlaySheet(context, provider);
                    },
                  ),
                  BottomBar(
                    name: l10n.outfit,
                    icon: 'assets/icons/clothes.png',
                    onTap: () => Navigator.pushNamed(context, '/outfit'),
                  ),
                  BottomBar(
                    name: l10n.shop,
                    icon: 'assets/icons/shop.png',
                    onTap: () => Navigator.pushNamed(context, '/shop'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the display name string mapped to the specific pet variant type.
  /// Parameters:
  /// - PetType type: The pet environment category.
  /// Returns: The string name of the pet.
  String petName(PetType type) {
    switch (type) {
      case PetType.sky:
        return 'Cloudy';
      case PetType.ocean:
        return 'Bubble';
    }
  }

  /// Shows the bottom panel used for selecting and feeding food items to the pet.
  /// Parameters:
  /// - BuildContext context: The current widget tree context.
  /// - PetProvider provider: The data source provider for pet state.
  void showFeedSheet(BuildContext context, PetProvider provider) {
    final state = provider.state;
    final name = petName(state.petType);
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (_) => ActionSheet(
        text: l10n.letsFeed(name),
        icon: 'assets/icons/close.png',
        child: state.ownedFood.isEmpty
            ? Center(child: Text(l10n.noFood))
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.ownedFood.entries
                    .map(
                      (e) => FoodSheet(
                        food: e.key,
                        num: e.value,
                        onTap: e.value > 0
                            ? () async {
                                provider.feed(e.key);
                                provider.showDialogue(l10n.dialogueFed);
                                Navigator.pop(context);
                              }
                            : null,
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }

  /// Shows the bottom panel used for selecting toys to play with the pet.
  /// Parameters:
  /// - BuildContext context: The current widget tree context.
  /// - PetProvider provider: The data source provider for pet state.
  void showPlaySheet(BuildContext context, PetProvider provider) {
    final state = provider.state;
    final name = petName(state.petType);
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (_) => ActionSheet(
        text: l10n.letsPlay(name),
        icon: 'assets/icons/close.png',
        child: state.ownedToy.isEmpty
            ? Center(child: Text(l10n.noToy))
            : Wrap(
                spacing: 8,
                runSpacing: 8,
                children: state.ownedToy
                    .map(
                      (e) => ToySheet(
                        toy: e,
                        onTap: () async {
                          provider.play(e);
                          provider.showDialogue(l10n.dialoguePlayed);
                          Navigator.pop(context);
                        },
                      ),
                    )
                    .toList(),
              ),
      ),
    );
  }
}

/// Returns the asset path for the icon corresponding to the current weather condition.
/// Parameters:
/// - WeatherCondition condition: The current atmospheric state.
/// Returns: A string representing the icon file location.
String weatherIcon(WeatherCondition condition) {
  return switch (condition) {
    WeatherCondition.sunny => 'assets/icons/sunny.png',
    WeatherCondition.rainy => 'assets/icons/rainy.png',
    WeatherCondition.gloomy => 'assets/icons/gloomy.png',
    _ => 'assets/icons/unknown.png',
  };
}

import 'dart:async';
import 'dart:convert';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:yourlittlepal/models/pet_state.dart';
import 'package:yourlittlepal/providers/pet_logic.dart';

/// The state management provider that connects the pet data to the user interface.
class PetProvider extends ChangeNotifier {
  /// The core status data tracking the pet.
  late PetState _state;

  /// Whether the initial data loading sequence is finished.
  bool _isLoaded = false;

  /// The recurring background timer that decreases pet stats over time.
  Timer? _timer;

  /// The current app translation setting choice.
  Locale _currentLocale = const Locale('en', '');

  /// Whether the app theme option is set to dark mode.
  bool _isDarkMode = false;

  /// The general base text scale measurement used across layout designs.
  double _fontSize = 14.0;

  /// The physical interface luminosity slider setting.
  double _brightness = 1.0;

  /// The shared temporary notification dialogue message text.
  String? _tempDialogue;

  /// The visibility controller flag indicating active cleaning sequence frames.
  final ValueNotifier<bool> washing = ValueNotifier(false);

  /// Gives access to the underlying pet variables.
  /// Returns: The current PetState object configuration instance.
  PetState get state => _state;

  /// Gives access to the loading status flag.
  /// Returns: A boolean stating true if variables are parsed and active.
  bool get isLoaded => _isLoaded;

  /// Gives access to the onboarding sequence flag checking fresh setups.
  /// Returns: A boolean stating true if the pet structure is uninitialized.
  bool get newPet => _state.newPet;

  /// Gives access to the active translation profile setup.
  /// Returns: The localized Locale reference tag.
  Locale get currentLocale => _currentLocale;

  /// Gives access to the active user interface brightness preference.
  /// Returns: A boolean stating true if dark mode is enabled.
  bool get isDarkMode => _isDarkMode;

  /// Gives access to the global font size scale parameter.
  /// Returns: A double specifying text dimensions.
  double get fontSize => _fontSize;

  /// Gives access to the saved interface luminosity slider position value.
  /// Returns: A double setting specifying brightness levels between 0 and 1.
  double get brightness => _brightness;

  /// Checks if older clothing tracking objects exist in history data sets.
  /// Returns: A boolean stating true if undo changes are available to read.
  bool get canUndo => _state.undo.isNotEmpty;

  /// Checks if newer clothing tracking objects exist in forward history data sets.
  /// Returns: A boolean stating true if redo changes are available to read.
  bool get canRedo => _state.redo.isNotEmpty;

  /// Gives access to the file identifier name text for the active top outfit item.
  /// Returns: A nullable string containing the image asset catalog reference.
  String? get currentTopAsset => _state.currOutfit.top;

  /// Gives access to the file identifier name text for the active bottom outfit item.
  /// Returns: A nullable string containing the image asset catalog reference.
  String? get currentBottomAsset => _state.currOutfit.bottom;

  /// Gives access to the temporary display text string message if set.
  /// Returns: A nullable string holding the notice messaging dialog content.
  String? get tempDialogue => _tempDialogue;

  /// Sets a new locale language option and updates local storage settings.
  /// Parameters:
  /// - Locale locale: The specific translation country tags to enable.
  Future<void> setLocale(Locale locale) async {
    _currentLocale = locale;
    await _save();
    notifyListeners();
  }

  /// Flips the color theme flag choice and records updates inside storage parameters.
  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    await _save();
    notifyListeners();
  }

  /// Sets a new interface brightness sliding variable and adjusts the phone screen limits.
  /// Parameters:
  /// - double value: The target screen lighting intensity limit number.
  Future<void> setBrightness(double value) async {
    _brightness = value;
    await ScreenBrightness().setApplicationScreenBrightness(_brightness);
    await _save();
    notifyListeners();
  }

  /// Sets a new font size scaling base factor for standard text objects.
  /// Parameters:
  /// - double size: The raw sizing number matching text dimension rules.
  Future<void> setFontSize(double size) async {
    _fontSize = size;
    await _save();
    notifyListeners();
  }

  /// Loads configuration logs from phone memory, runs initial math updates, and triggers background tracking.
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('pet_state');
    final languageCode = prefs.getString('locale') ?? 'en';
    final countryCode = prefs.getString('locale_country') ?? '';

    if (saved != null) {
      _state = PetState.fromJson(jsonDecode(saved));
    } else {
      _state = PetState.newPet(PetType.sky);
    }
    _currentLocale = Locale(languageCode, countryCode);
    _isDarkMode = prefs.getBool('dark_mode') ?? false;
    _fontSize = prefs.getDouble('font_size') ?? 14;
    _brightness = prefs.getDouble('brightness') ?? 1;

    try {
      await ScreenBrightness().setApplicationScreenBrightness(_brightness);
    } catch (e) {
      debugPrint(e.toString());
      throw 'Failed to set application brightness';
    }

    PetLogic.hourlyDec(_state);
    await _save();
    _isLoaded = true;
    notifyListeners();

    _timer = Timer.periodic(const Duration(minutes: 10), (_) async {
      PetLogic.hourlyDec(_state);
      await _save();
      notifyListeners();
    });
  }

  /// Serializes tracking structures into text files placed directly inside local phone storage.
  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pet_state', jsonEncode(_state.toJson()));
    await prefs.setString('locale', _currentLocale.languageCode);
    await prefs.setString('locale_country', _currentLocale.countryCode ?? '');
    await prefs.setBool('dark_mode', _isDarkMode);
  }

  /// Triggers food consumption systems to adjust health counters and saves data entries.
  /// Parameters:
  /// - String food: The inventory name identifier key representing the food choice.
  Future<void> feed(String food) async {
    PetLogic.feed(_state, food);
    await _save();
    notifyListeners();
  }

  /// Triggers hydration processes to adjust health counters and records configurations.
  Future<void> water() async {
    PetLogic.water(_state);
    await _save();
    notifyListeners();
  }

  /// Triggers sanitation updates to adjust hygiene flags and commits variables.
  Future<void> wash() async {
    PetLogic.wash(_state);
    await _save();
    notifyListeners();
  }

  /// Triggers recreation routines to adjust closeness variables and commits variables.
  /// Parameters:
  /// - String toy: The inventory name identifier key representing the toy choice.
  Future<void> play(String toy) async {
    PetLogic.play(_state, toy);
    await _save();
    notifyListeners();
  }

  /// Modifies active wardrobe layers across tracking datasets and updates records.
  /// Parameters:
  /// - String? top: The text name asset code mapping to the selected shirt choice.
  /// - String? bottom: The text name asset code mapping to the selected pants choice.
  Future<void> changeOutfit({String? top, String? bottom}) async {
    PetLogic.changeOutfit(_state, top: top, bottom: bottom);
    await _save();
    notifyListeners();
  }

  /// Restores historical wardrobe layouts out of past sequence history trackers.
  Future<void> undo() async {
    PetLogic.undo(_state);
    await _save();
    notifyListeners();
  }

  /// Re-applies next wardrobe layouts out of cleared forward tracking data sets.
  Future<void> redo() async {
    PetLogic.redo(_state);
    await _save();
    notifyListeners();
  }

  /// Processes transactional financial balances to attempt buying a food item.
  /// Parameters:
  /// - String food: The name text identifying the specific consumable item.
  /// - int price: Referring to the price of the given food name
  /// Returns: A boolean stating true if the coin balance check passes successfully.
  Future<bool> buyFood(String food, int price) async {
    final buyed = PetLogic.buyFood(_state, food, price);
    await _save();
    notifyListeners();
    return buyed;
  }

  /// Processes transactional wallet parameters to attempt purchasing an equipment item.
  /// Parameters:
  /// - String toy: The name text identifying the specific toy item.
  /// - int price: Referring to the price of the given toy name
  /// Returns: A boolean stating true if transaction deductions executed completely.
  Future<bool> buyToy(String toy, int price) async {
    final buyed = PetLogic.buyToy(_state, toy, price);
    await _save();
    notifyListeners();
    return buyed;
  }

  /// Establishes initial conditions and sets pet configurations during first runtime generation.
  /// Parameters:
  /// - PetType type: The explicit pet taxonomy category grouping choice.
  Future<void> selectPet(PetType type) async {
    PetLogic.selectPet(_state, type);
    await _save();
    notifyListeners();
  }

  /// Changes the state of the visibility tracker flag to show the clean sequence frames.
  Future<void> startWashing() async {
    washing.value = true;
    notifyListeners();
  }

  /// Overlays a temporary text phrase message string that disappears automatically over time.
  /// Parameters:
  /// - String text: The notice announcement string messaging data to display.
  /// - int seconds: The duration constraint deciding how long text frames remain visible.
  Future<void> showDialogue(String text, {int seconds = 5}) async {
    _tempDialogue = text;
    notifyListeners();
    await Future.delayed(Duration(seconds: seconds));
    _tempDialogue = null;
    notifyListeners();
  }

  /// Cancels backing timers and resets screen settings back to device default balances during shutdown.
  @override
  void dispose() {
    ScreenBrightness().resetApplicationScreenBrightness();
    _timer?.cancel();
    super.dispose();
  }

  /// Handles undoing an outfit adjustment sequence step
  Future<void> undoOutfitChange() async {
    await undo();
  }

  /// Handles redoing an outfit adjustment sequence step
  Future<void> redoOutfitChange() async {
    await redo();
  }

  /// Toggles clothing item paths dynamically inside your core business rules
  Future<void> equipClothingItem(String itemId, bool viewingTops) async {
    if (viewingTops) {
      final nextTop = _state.currOutfit.top == itemId ? '' : itemId;
      await changeOutfit(top: nextTop, bottom: _state.currOutfit.bottom);
    } else {
      final nextBottom = _state.currOutfit.bottom == itemId ? '' : itemId;
      await changeOutfit(top: _state.currOutfit.top, bottom: nextBottom);
    }
  }

  /// Automatically persists configurations when confirming wardrobe modifications
  Future<void> saveCurrentOutfitState() async {
    await _save();
    notifyListeners();
  }
  ///deduct a given amount of coins from the pet's current amount of coins
  ///Parameters:
  /// - int amount: The  number of coions to be deducted
  Future<void> spendCoins(int amount) async {
    _state.coins -= amount;
    await _save();
    notifyListeners();
  }
  /// Wipes active pet storage profiles to instantiate clean fallback models.
  /// Parameters:
  /// - PetType selectedPetType: The targeted baseline variant group configuration.
  Future<void> resetPet(PetType type) async {
    _state =PetState.newPet(type);
    _state.newPet = false;
    await _save();
    notifyListeners();
  }


}



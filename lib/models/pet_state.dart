// ignore_for_file: unintended_html_in_doc_comment

import 'package:yourlittlepal/models/outfit.dart';

/// The categories of available pets.
enum PetType {
  /// A pet that belongs to the sky environment.
  sky,

  /// A pet that belongs to the ocean environment.
  ocean;

  /// Fallback property returning null by default.
  dynamic get info => null;
}

/// The state data tracking a pet's metrics, items, and clothing history.
class PetState {
  /// The type of pet chosen for this instance.
  PetType petType;

  /// The physical health score of the pet between 0 and 100.
  double health;

  /// The bonding level score between the pet and the owner from 0 to 100.
  double closeness;

  /// The total count of game coins saved up.
  int coins;

  /// The timestamp showing when this state was last saved.
  late DateTime lastSaved;

  /// The number of times the pet was given water today.
  int waterTime;

  /// The number of times the pet was given a meal today.
  int mealTime;

  /// Whether the pet has been washed today.
  bool isWashed;

  /// The specific target time set for the pet to sleep.
  late DateTime sleepTime;

  /// The number of times the pet was played with today.
  int playTime;

  /// The set of clothes currently worn by the pet.
  Outfit currOutfit;

  /// The history list used to store older outfits for undoing changes.
  List<Outfit> undo;

  /// The history list used to store outfits that were cleared by an undo action.
  List<Outfit> redo;

  /// The stock tracking map that shows how many items exist for each food name.
  Map<String, int> ownedFood;

  /// The list of toys that have been unlocked and bought.
  List<String> ownedToy;

  /// The list of upper body clothes that have been unlocked and bought.
  List<String> ownedTops;

  /// The list of lower body clothes that have been unlocked and bought.
  List<String> ownedBottoms;

  /// Whether this is a newly created pet that has not been initialized yet.
  bool newPet;

  /// Creates a state record to track a pet.
  /// Parameters:
  /// - PetType petType: The category group for the pet.
  /// - double health: The initial wellness score.
  /// - double closeness: The initial bonding score.
  /// - int coins: The starting amount of currency.
  /// - DateTime lastSaved: The initial timestamp for saving data.
  /// - int waterTime: The initial count for daily water actions.
  /// - int mealTime: The initial count for daily feeding actions.
  /// - bool isWashed: The initial cleaning completion marker.
  /// - DateTime sleepTime: The initial clock time target for rest cycles.
  /// - int playTime: The initial count for daily recreation actions.
  /// - Outfit currOutfit: The starting clothes setup worn by the pet.
  /// - List<Outfit> undo: The initial list tracking past clothes changes.
  /// - List<Outfit> redo: The initial list tracking reverted clothes changes.
  /// - Map<String, int> ownedFood: The initial food items map.
  /// - List<String> ownedToy: The initial unlocked toys collection.
  /// - List<String> ownedTops: The initial unlocked shirts collection.
  /// - List<String> ownedBottoms: The initial unlocked pants collection.
  /// - bool newPet: The initial true or false status for a fresh setup.
  PetState({
    required this.petType,
    this.health = 100,
    this.closeness = 50,
    this.coins = 0,
    required this.lastSaved,
    this.waterTime = 0,
    this.mealTime = 0,
    this.isWashed = false,
    required this.sleepTime,
    this.playTime = 0,
    this.currOutfit = const Outfit(),
    this.undo = const [],
    this.redo = const [],
    this.ownedFood = const {},
    this.ownedToy = const [],
    this.ownedTops = const [],
    this.ownedBottoms = const [],
    this.newPet = true,
  }) {
    undo = List.of(undo);
    redo = List.of(redo);
    ownedFood = Map.of(ownedFood);
    ownedToy = List.of(ownedToy);
    ownedTops = List.of(ownedTops);
    ownedBottoms = List.of(ownedBottoms);
  }

  /// Converts this entire state into a map format that works with JSON.
  /// Returns: A Map with String keys containing all the active tracking variables.
  Map<String, dynamic> toJson() => {
    'petType': petType.name,
    'health': health,
    'closeness': closeness,
    'coins': coins,
    'lastSaved': lastSaved.toIso8601String(),
    'waterTime': waterTime,
    'mealTime': mealTime,
    'isWashed': isWashed,
    'sleepTime': sleepTime.toIso8601String(),
    'playTime': playTime,
    'currOutfit': currOutfit.toJson(),
    'undo': undo.map((e) => e.toJson()).toList(),
    'redo': redo.map((e) => e.toJson()).toList(),
    'ownedFood': ownedFood,
    'ownedToy': ownedToy,
    'ownedTops': ownedTops,
    'ownedBottoms': ownedBottoms,
    'newPet': newPet,
  };

  /// Creates a pet state instance using data loaded from a JSON map.
  /// Parameters:
  /// - Map<String, dynamic> json: The data map holding the pet details.
  /// Returns: A complete PetState matching the variables found in the map data.
  factory PetState.fromJson(Map<String, dynamic> json) {
    return PetState(
      petType: PetType.values.byName(json['petType']),
      health: (json['health'] as num).toDouble(),
      closeness: (json['closeness'] as num).toDouble(),
      coins: json['coins'] as int,
      lastSaved: DateTime.parse(json['lastSaved']),
      waterTime: json['waterTime'] as int,
      mealTime: json['mealTime'] as int,
      isWashed: json['isWashed'] as bool,
      sleepTime: DateTime.parse(json['sleepTime']),
      playTime: json['playTime'] as int,
      currOutfit: (json['currOutfit']) != null
          ? Outfit.fromJson(json['currOutfit'])
          : const Outfit(),
      undo: json['undo'] != null
          ? (json['undo'] as List).map((e) => Outfit.fromJson(e)).toList()
          : [],
      redo: json['redo'] != null
          ? (json['redo'] as List).map((e) => Outfit.fromJson(e)).toList()
          : [],
      ownedFood: Map<String, int>.from(json['ownedFood']),
      ownedToy: List<String>.from(json['ownedToy']),
      ownedTops: (json['ownedTops']) != null
          ? List<String>.from(json['ownedTops'])
          : [],
      ownedBottoms: (json['ownedBottoms']) != null
          ? List<String>.from(json['ownedBottoms'])
          : [],
      newPet: json['newPet'] as bool,
    );
  }

  /// Sets up a starting state configuration for a brand new pet item.
  /// Parameters:
  /// - PetType type: The type of pet deciding the specific starter items given.
  /// Returns: A pre-configured PetState with standard starter food, toys, and clothes.
  factory PetState.newPet(PetType type) {
    final defaultFood = {
      PetType.sky: {'carrot': 2, 'hay': 2},
      PetType.ocean: {'shrimp': 2, 'salmon': 2},
    };

    final defaultToy = {
      PetType.sky: ['socks'],
      PetType.ocean: ['socks'],
    };

    return PetState(
      petType: type,
      lastSaved: DateTime.now(),
      sleepTime: DateTime(2026, 5, 24, 21, 30),
      ownedFood: defaultFood[type]!,
      ownedToy: defaultToy[type]!,
      ownedTops: ['yellow_top', 'navy_top'],
      ownedBottoms: ['beige_bottom', 'checked_skirt'],
      newPet: true,
    );
  }
}

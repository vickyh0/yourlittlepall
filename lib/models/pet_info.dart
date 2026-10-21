import 'package:yourlittlepal/models/pet_state.dart';

/// The fixed information for each type of pet.
/// Contains the name, description, image path, and item preferences.
class PetStaticInfo {
  /// The name of this pet type.
  final String name;

  /// The description explaining what this pet looks like.
  final String description;

  /// The file path pointing to the picture asset for this pet.
  final String assetPath;

  /// The list of foods that give the highest satisfaction to this pet.
  final List<String> favoriteFoods;

  /// The list of toys that give the highest satisfaction to this pet.
  final List<String> favoriteToys;

  /// The list of regular foods this pet can eat.
  final List<String> normalFoods;

  /// The list of regular toys this pet can play with.
  final List<String> normalToys;

  /// Creates a set of fixed information for a pet.
  /// Parameters:
  /// - String name: The text name of the pet.
  /// - String description: The text description of the pet.
  /// - String assetPath: The file path to the pet image.
  /// - List <String> favoriteFoods: The names of favorite foods.
  /// - List <String> favoriteToys: The names of favorite toys.
  /// - List <String> normalFoods: The names of regular foods.
  /// - List <String> normalToys: The names of regular toys.
  const PetStaticInfo({
    required this.name,
    required this.description,
    required this.assetPath,
    required this.favoriteFoods,
    required this.favoriteToys,
    required this.normalFoods,
    required this.normalToys,
  });
}

/// A list that holds the information for all available pet types.
class PetRegistry {
  /// The main map that connects each [PetType] to its fixed information.
  static final Map<PetType, PetStaticInfo> allPets = <PetType, PetStaticInfo>{
    PetType.sky: const PetStaticInfo(
      name: 'Cloudy',
      description:
          'A delicate rabbit with functional wings and a hovering halo.',
      favoriteFoods: <String>['carrot'],
      favoriteToys: <String>['hay balls'],
      normalFoods: <String>['steak', 'grass', 'salmon'],
      normalToys: <String>['socks', 'feather'],
      assetPath: '',
    ),
    PetType.ocean: const PetStaticInfo(
      name: 'Bubble',
      description:
          'An uncommon, gentle creature: half goat, half whale hybrid.',
      favoriteFoods: <String>['shrimp'],
      favoriteToys: <String>['pebbles'],
      normalFoods: <String>['salmon', 'steak', 'grass'],
      normalToys: <String>['socks', 'feather'],
      assetPath: '',
    ),
  };

  /// Finds the information for a specific pet type.
  /// Parameters:
  /// - PetType type: The category key used to find the pet info.
  /// Returns: The PetStaticInfo matching the requested pet type.
  static PetStaticInfo getInfo(PetType type) => allPets[type]!;
}

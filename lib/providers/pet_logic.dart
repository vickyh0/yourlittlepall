import 'package:yourlittlepal/models/pet_state.dart';

/// The game logic and math formulas for managing a pet.
class PetLogic {
  /// Lowers health and closeness over time based on the hours passed.
  /// Resets daily counts to zero if a new calendar day has started.
  /// Parameters:
  /// - PetState state: The pet data model to modify.
  static void hourlyDec(PetState state) {
    const int healthDec = 3;
    const int closenessDec = 2;
    final now = DateTime.now();
    final diff = (now.difference(state.lastSaved).inMinutes / 60).clamp(0, 24);

    if (now.day != state.lastSaved.day) {
      state.waterTime = 0;
      state.mealTime = 0;
      state.isWashed = false;
      state.playTime = 0;
    }

    state.health = (state.health - healthDec * diff).clamp(0, 100);
    state.closeness = (state.closeness - closenessDec * diff).clamp(0, 100);
    state.lastSaved = now;
  }

  /// Feeds the pet an item to increase its health and decrease food inventory.
  /// Gives bonus health points if the food matches the pet type's favorite food.
  /// Parameters:
  /// - PetState state: The pet data model to modify.
  /// - String food: The text name of the food item being fed.
  static void feed(PetState state, String food) {
    const favorites = {
      PetType.sky: ['carrot'],
      PetType.ocean: ['shrimp'],
    };
    final isFavorite = (favorites[state.petType] ?? []).contains(food.toLowerCase());
    if (state.mealTime < 3 && (state.ownedFood[food.toLowerCase()] ?? 0) > 0) {
      if (isFavorite) {
        state.health = (state.health + 15).clamp(0, 100);
      } else {
        state.health = (state.health + 10).clamp(0, 100);
      }
      state.coins += 20;
      state.mealTime++;
      state.ownedFood[food.toLowerCase()] = state.ownedFood[food.toLowerCase()]! - 1;
    }
  }

  /// Gives water to the pet to increase health up to a maximum safety limit.
  /// Parameters:
  /// - PetState state: The pet data model to modify.
  static void water(PetState state) {
    if (state.waterTime < 15) {
      state.health = (state.health + 2).clamp(0, 100);
      state.coins += 5;
      state.waterTime++;
    }
  }

  /// Cleans the pet to increase its health points if it has not been washed today.
  /// Parameters:
  /// - PetState state: The pet data model to modify.
  static void wash(PetState state) {
    if (!state.isWashed) {
      state.health = (state.health + 10).clamp(0, 100);
      state.coins += 10;
      state.isWashed = true;
    }
  }

  /// Plays with the pet using a toy to increase its closeness bonding level.
  /// Gives extra bonding points if the toy matches the pet type's favorite toy.
  /// Parameters:
  /// - PetState state: The pet data model to modify.
  /// - String toy: The text name of the toy item being used.
  static void play(PetState state, String toy) {
    const favorites = {
      PetType.sky: ['hay balls'],
      PetType.ocean: ['pebbles'],
    };
    final isFavorite = (favorites[state.petType] ?? []).contains(toy);
    if (state.playTime < 2) {
      if (isFavorite) {
        state.closeness = (state.closeness + 20).clamp(0, 100);
      } else {
        state.closeness = (state.closeness + 15).clamp(0, 100);
      }
      state.coins += 15;
      state.playTime++;
    }
  }

  /// Changes the current clothes on the pet and saves the old outfit to history.
  /// Parameters:
  /// - PetState state: The pet data model to modify.
  /// - String? top: The optional text name of the new shirt item.
  /// - String? bottom: The optional text name of the new pants item.
  static void changeOutfit(PetState state, {String? top, String? bottom}) {
    state.undo.add(state.currOutfit);
    state.redo.clear();

    state.currOutfit = state.currOutfit.update(top: top, bottom: bottom);
  }

  /// Reverts the clothes back to the previous outfit found in the undo history list.
  /// Parameters:
  /// - PetState state: The pet data model to modify.
  static void undo(PetState state) {
    if (state.undo.isNotEmpty) {
      state.redo.add(state.currOutfit);
      state.currOutfit = state.undo.last;
      state.undo.removeLast();
    }
  }

  /// Moves the clothes forward to an outfit cleared by an undo action.
  /// Parameters:
  /// - PetState state: The pet data model to modify.
  static void redo(PetState state) {
    if (state.redo.isNotEmpty) {
      state.undo.add(state.currOutfit);
      state.currOutfit = state.redo.last;
      state.redo.removeLast();
    }
  }

  /// Spends coins to buy a food item and increases its stock count.
  /// Parameters:
  /// - PetState state: The pet data model to modify.
  /// - String food: The text name of the food item to purchase.
  /// - int price: Price of the given toy
  /// Returns: A boolean stating true if there were enough coins to finish the purchase.
  static bool buyFood(PetState state, String food, int price) {
    if (state.coins < price) {
      return false;
    } else {
      state.coins -= price;
      state.ownedFood[food.toLowerCase()] = (state.ownedFood[food.toLowerCase()] ?? 0) + 1;
      return true;
    }
  }

  /// Spends coins to buy a toy item and adds it to the unlocked items list.
  /// Parameters:
  /// - PetState state: The pet data model to modify.
  /// - String toy: The text name of the toy item to purchase.
  /// - int price: Price of the given toy
  /// Returns: A boolean stating true if there were enough coins to finish the purchase.
  static bool buyToy(PetState state, String toy, int price){
    if (state.coins < price || state.ownedToy.contains(toy.toLowerCase())) {
      return false;
    } else {
      state.coins -= price;
      state.ownedToy.add(toy.toLowerCase());
      return true;
    }
  }

  /// Changes configuration variables to select a type and mark the pet as initialized.
  /// Parameters:
  /// - PetState state: The pet data model to modify.
  /// - PetType type: The pet environment category to select.
  static void selectPet(PetState state, PetType type) {
    state.petType = type;
    state.newPet = false;
  }
}

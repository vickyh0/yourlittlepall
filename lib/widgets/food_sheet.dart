import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A display component for an individual food item in the inventory.
/// It shows the food name and the quantity available, and is interactive
/// via the [onTap] callback.
class FoodSheet extends StatelessWidget {
  /// The name of the food item.
  final String food;

  /// The quantity of the food item currently in inventory.
  final int num;

  /// Optional callback executed when the item is tapped.
  final VoidCallback? onTap;

  const FoodSheet({
    super.key,
    required this.food,
    required this.num,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Food item label
            Text(
              food,
              style: GoogleFonts.pixelifySans(
                fontSize: 12, // Adjusted font size for readability
              ),
            ),
            // Item quantity display
            Text(
              'x$num',
              style: GoogleFonts.pixelifySans(
                fontSize: 12, // Adjusted font size for readability
              ),
            ),
          ],
        ),
      ),
    );
  }
}

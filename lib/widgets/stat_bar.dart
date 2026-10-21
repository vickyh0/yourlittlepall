import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A display component for showing pet status bars (e.g., Hunger, Happiness).
/// It visualizes a fractional value [val] as a progress bar with a numerical label.
class StatBar extends StatelessWidget {
  /// The label for the statistic (e.g., "Hunger").
  final String name;

  /// The current value of the statistic (expected range: 0.0 to 1.0).
  final double val;

  /// The color used for the filled portion of the bar.
  final Color color;

  const StatBar({
    super.key,
    required this.name,
    required this.val,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Convert the fractional value to a 0-100 percentage integer for display.
    final int percent = (val * 100).toInt();

    return Semantics(
      label: '$name: $percent percent',
      child: Row(
        children: [
          // Name label container
          SizedBox(
            width: 90,
            child: Text(
              name,
              style: GoogleFonts.pixelifySans(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
      
          // Progress bar container
          Expanded(
            child: Container(
              height: 16,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                // Ensures the width does not exceed 100% or drop below 0%.
                widthFactor: val.clamp(0.0, 1.0),
                child: Container(color: color),
              ),
            ),
          ),
      
          const SizedBox(width: 8),
      
          // Numeric percentage display
          SizedBox(
            width: 36,
            child: Text(
              '$percent',
              style: GoogleFonts.pixelifySans(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}

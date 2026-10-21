import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A reusable navigation button component for the bottom bar.
/// It displays an icon and a label, triggering the provided [onTap] callback when pressed.
class BottomBar extends StatelessWidget {
  /// The label text displayed below the icon.
  final String name;

  /// The asset path for the icon image.
  final String icon;

  /// The action to perform when the button is tapped.
  final VoidCallback onTap;

  const BottomBar({
    super.key,
    required this.name,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: name,
      button: true,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon display with pixel-art settings
            Image.asset(
              icon,
              excludeFromSemantics: true,
              width: 64,
              height: 64,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.none, // Ensures crisp pixel edges
            ),
            const SizedBox(height: 8),
      
            // Label text
            Text(
              name,
              style: GoogleFonts.pixelifySans(
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

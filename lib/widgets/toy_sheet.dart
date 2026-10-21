import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A display component for an individual toy item.
/// It renders the toy name within a white container and is interactive
/// via the [onTap] callback.
class ToySheet extends StatelessWidget {
  /// The name of the toy item.
  final String toy;

  /// Callback executed when the toy item is tapped.
  final VoidCallback onTap;

  const ToySheet({super.key, required this.toy, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Colors.white),
        child: Text(
          toy,
          style: GoogleFonts.pixelifySans(
            fontSize: 12, // Standardized font size for consistency
          ),
        ),
      ),
    );
  }
}

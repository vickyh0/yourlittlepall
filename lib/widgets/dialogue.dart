import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A display widget that presents a speech bubble containing the pet's dialogue.
/// It uses a background image asset with overlaying text.
class Dialogue extends StatelessWidget {
  /// The string message to be displayed within the speech bubble.
  final String dialogue;

  const Dialogue({super.key, required this.dialogue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: 200,
        height: 134,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background speech bubble graphic
            Image.asset(
              'assets/icons/dialogue.png',
              width: 256,
              height: 150,
              fit: BoxFit.fill,
              filterQuality: FilterQuality.none, // Retains pixel-art style
            ),

            // Dialogue text overlay
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                dialogue,
                textAlign: TextAlign.center,
                style: GoogleFonts.pixelifySans(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

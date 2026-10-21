import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourlittlepal/l10n/app_localizations.dart';
import 'package:yourlittlepal/providers/pet_provider.dart';

/// The [StartPage] serves as the initial entry point of the application.
/// It detects if a saved pet profile exists and provides options to either
/// continue an existing game or start a new one.
class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the provider to check for existing save data.
    final petProvider = Provider.of<PetProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: [
          // 1. BACKGROUND IMAGE LAYER
          Positioned.fill(
            child: Image.asset(
              'assets/backgrounds/background.png',
              fit: BoxFit
                  .cover, // Ensures the background fills the device screen.
              filterQuality:
                  FilterQuality.none, // Maintains pixel-art sharpness.
            ),
          ),

          // 2. INTERACTIVE FOREGROUND LAYOUT LAYER
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Title container: Provides a high-contrast backdrop for the title.
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F1EA).withValues(alpha: 0.9),
                      border: Border.all(
                        color: const Color(0xFF2B2B2B),
                        width: 3,
                      ),
                    ),
                    child: const Text(
                      'YOUR LITTLE PAL 🐾',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PixelFont',
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2.0,
                        color: Color(0xFF2B2B2B),
                      ),
                    ),
                  ),
                  const SizedBox(height: 80),

                  // --- OPTION A: Resume Game ---
                  // Only rendered if petProvider confirms a save profile exists.
                  if (petProvider.isLoaded) ...[
                    ElevatedButton(
                      style: _pixelButtonStyle(),
                      onPressed: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed('/playground');
                      },
                      child: Text(
                        l10n.continueGame,
                        style: const TextStyle(
                          fontFamily: 'PixelFont',
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // --- OPTION B: Start New Game ---
                  // Always available to allow users to reset or initiate a new pet selection.
                  ElevatedButton(
                    style: _pixelButtonStyle(
                      invertColors: !petProvider.isLoaded,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/select');
                    },
                    child: Text(
                      l10n.start,
                      style: const TextStyle(
                        fontFamily: 'PixelFont',
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Helper method to generate consistent, retro-themed button styling.
  /// [invertColors] toggles the button visual scheme for primary/secondary buttons.
  ButtonStyle _pixelButtonStyle({bool invertColors = false}) {
    return ElevatedButton.styleFrom(
      backgroundColor: invertColors ? const Color(0xFF2B2B2B) : Colors.white,
      foregroundColor: invertColors ? Colors.white : const Color(0xFF2B2B2B),
      elevation: 0,
      side: const BorderSide(color: Color(0xFF2B2B2B), width: 3),
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yourlittlepal/l10n/app_localizations.dart';
import 'package:yourlittlepal/models/pet_state.dart';
import 'package:yourlittlepal/providers/pet_provider.dart';

/// The view where users select their initial pet type.
class SelectView extends StatefulWidget {
  /// Creates the pet selection interface.
  const SelectView({super.key});

  @override
  State<SelectView> createState() => _SelectViewState();
}

class _SelectViewState extends State<SelectView> {
  /// Tracks the index of the currently selected pet.
  int? _selectedIndex;

  /// Defines the available pet options.
  final List<Map<String, dynamic>> totalPets = [
    {'name': 'CLOUDY', 'type': PetType.sky, 'image': 'assets/pets/sky.png'},
    {'name': 'BUBBLE', 'type': PetType.ocean, 'image': 'assets/pets/ocean.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final petProvider = Provider.of<PetProvider>(context, listen: false);
    final isAnyPetSelected = _selectedIndex != null;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EA),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          l10n.chooseYourPal,
          style: GoogleFonts.pixelifySans(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2B2B2B),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/background.png'),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.none,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(totalPets.length, (index) {
                        final pet = totalPets[index];
                        final isSelected = _selectedIndex == index;

                        return Semantics(
                          label: 'Select ${pet['name']} ',
                          button: true,
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedIndex = index),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 18.0,
                              ),
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xFF2B2B2B)
                                      : Colors.transparent,
                                  width: 3,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: isSelected
                                    ? [
                                        const BoxShadow(
                                          color: Color.fromARGB(
                                            103,
                                            255,
                                            255,
                                            255,
                                          ),
                                          offset: Offset(4, 4),
                                          blurRadius: 0,
                                        ),
                                      ]
                                    : null,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Image.asset(
                                        pet['image']!,
                                        semanticLabel: pet['name']!,
                                        fit: BoxFit.contain,
                                        filterQuality: FilterQuality.none,
                                        errorBuilder:
                                            (context, error, stackTrace) =>
                                                const Icon(
                                                  Icons.pets,
                                                  size: 100,
                                                  color: Color(0xFF2B2B2B),
                                                ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    pet['name']!,
                                    style: GoogleFonts.pixelifySans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(88, 43, 43, 43),
                                      shadows: const [
                                        Shadow(
                                          color: Colors.white,
                                          offset: Offset(1.5, 1.5),
                                          blurRadius: 2.0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAnyPetSelected
                          ? const Color.fromARGB(255, 255, 166, 49)
                          : const Color(0xFFD6D1C4),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      side: const BorderSide(
                        color: Color(0xFF2B2B2B),
                        width: 3,
                      ),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    onPressed: !isAnyPetSelected
                        ? null
                        : () async {
                            final selectedPetType =
                                totalPets[_selectedIndex!]['type'] as PetType;
                            await petProvider.resetPet(selectedPetType);
                            if (mounted) {
                              Navigator.of(
                                context,
                              ).pushReplacementNamed('/playground');
                            }
                          },
                    child: Text(
                      l10n.confirmPal,
                      style: GoogleFonts.pixelifySans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 244, 215),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

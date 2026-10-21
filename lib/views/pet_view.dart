import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yourlittlepal/l10n/app_localizations.dart';
import 'package:yourlittlepal/models/pet_state.dart';
import 'package:yourlittlepal/providers/pet_provider.dart';

/// A view that renders the pet, its equipped clothing, and an interactive washing minigame.
class PetView extends StatefulWidget {
  /// Creates the pet display area.
  const PetView({super.key});

  @override
  State<PetView> createState() => _PetViewState();
}

class _PetViewState extends State<PetView> {
  /// Stores the coordinates for active bubbles during the washing minigame.
  List<Offset> bubbleScrubPoints = [];

  @override
  Widget build(BuildContext context) {
    final petProvider = Provider.of<PetProvider>(context);
    final state = petProvider.state;
    final top = state.currOutfit.top;
    final bottom = state.currOutfit.bottom;
    final l10n = AppLocalizations.of(context)!;

    /// Pops a bubble at the given location if the pet is not already clean.
    void popBubble(Offset globalPosition) {
      if (!state.isWashed) {
        final renderBox = context.findRenderObject() as RenderBox;
        final localPosition = renderBox.globalToLocal(globalPosition);
        setState(() {
          bubbleScrubPoints.removeWhere(
            (bubblePos) => (bubblePos - localPosition).distance < 25.0,
          );
        });
      }
    }

    return GestureDetector(
      onPanDown: (DragDownDetails details) {
        popBubble(details.globalPosition);
      },
      onPanUpdate: (DragUpdateDetails details) {
        if (state.isWashed) return;

        final renderBox = context.findRenderObject() as RenderBox;
        final localPosition = renderBox.globalToLocal(details.globalPosition);

        setState(() {
          // Pops a bubble if your finger drags within 25 pixels of it
          bubbleScrubPoints.removeWhere(
            (bubblePos) => (bubblePos - localPosition).distance < 25.0,
          );
        });

        // Trigger wash completion if all bubbles are cleared
        if (bubbleScrubPoints.isEmpty &&
            !state.isWashed &&
            petProvider.washing.value) {
          petProvider.wash();
          petProvider.washing.value = false;
          petProvider.showDialogue(l10n.dialogueClean);
        }
      },
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final size = constraints.maxWidth < constraints.maxHeight
              ? constraints.maxWidth
              : constraints.maxHeight;

          return Stack(
            alignment: Alignment.center,
            children: [
              // Base Pet Layer
              Image.asset(
                'assets/pets/${state.petType.name}.png',
                semanticLabel: state.petType == PetType.sky ? 
                'Cloudy the rabbit with wings' : 'Bubble the half goat half whale creature',
                width: size,
                height: size,
                fit: BoxFit.contain,
                filterQuality: FilterQuality.none,
              ),
              // Clothing Layer: Bottoms
              if (bottom.isNotEmpty)
                Image.asset(
                  'assets/outfits/bottoms/$bottom.png',
                  excludeFromSemantics: true,
                  width: size,
                  height: size,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.none,
                ),
              // Clothing Layer: Tops
              if (top.isNotEmpty)
                Image.asset(
                  'assets/outfits/tops/$top.png',
                  width: size,
                  height: size,
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.none,
                ),
              // Bubble Effect Layer
              for (var bubblePos in bubbleScrubPoints)
                Positioned(
                  left: bubblePos.dx - 15,
                  top: bubblePos.dy - 15,
                  child: Image.asset(
                    'assets/effects/bubble.png',
                    excludeFromSemantics: true,
                    width: 50,
                    height: 50,
                    filterQuality: FilterQuality.none,
                  ),
                ),
              // State Listener for initiating the wash session
              ValueListenableBuilder<bool>(
                valueListenable: petProvider.washing,
                builder: (context, washing, _) {
                  if (washing && bubbleScrubPoints.isEmpty) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (mounted) setState(() => reset(size));
                    });
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          );
        },
      ),
    );
  }

  /// Regenerates the bubble positions for a new washing session.
  /// Parameter: size - The bounding box size of the pet area.
  void reset(double size) {
    final random = Random();
    final min = size * 0.2;
    final max = size * 0.8;
    bubbleScrubPoints = List.generate(
      20,
      (_) => Offset(
        min + random.nextDouble() * (max - min),
        min + random.nextDouble() * (max - min),
      ),
    );
  }
}

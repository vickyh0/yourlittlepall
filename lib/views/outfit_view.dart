// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yourlittlepal/l10n/app_localizations.dart';
import 'package:yourlittlepal/providers/pet_provider.dart';
import 'package:yourlittlepal/models/pet_state.dart';

/// The view where users manage their pet's appearance by dragging and dropping clothing items.
class OutfitView extends StatefulWidget {
  /// Creates the outfit management interface.
  const OutfitView({super.key});

  @override
  State<OutfitView> createState() => _OutfitPageState();
}

class _OutfitPageState extends State<OutfitView> {
  /// Controls whether the user is currently browsing tops or bottoms.
  bool viewingTops = true;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PetProvider>(context);
    final petState = provider.state;
    final l10n = AppLocalizations.of(context)!;

    // Retrieve owned inventory lists based on category
    final availableTops = petState.ownedTops;
    final availableBottoms = petState.ownedBottoms;
    final activeInventory = viewingTops ? availableTops : availableBottoms;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EA),
      appBar: AppBar(
        title: Text(
          l10n.outfit,
          style: GoogleFonts.pixelifySans(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Semantics(
                label: 'Coins: ${petState.coins}',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/icons/coins.png',
                      width: 22,
                      height: 22,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.none,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.monetization_on,
                        color: Colors.amber,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Coins: ${petState.coins}',
                      style: GoogleFonts.pixelifySans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2B2B2B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // 1. CHARACTER DRAG TARGET AREA
          Expanded(
            flex: 5,
            child: DragTarget<Map<String, dynamic>>(
              onWillAcceptWithDetails: (details) => true,
              onAcceptWithDetails: (details) {
                final data = details.data;
                final String itemId = data['id'];
                final bool isTop = data['isTop'];

                // Equips the item onto the character when dropped
                if (isTop) {
                  provider.changeOutfit(top: itemId);
                } else {
                  provider.changeOutfit(bottom: itemId);
                }
              },
              builder: (context, candidateData, rejectedData) {
                // Highlight background when hovering an item over the character
                final bool isHovering = candidateData.isNotEmpty;

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: isHovering
                        ? const Color(0xFFE5E0D3)
                        : const Color(0xFFEFECE4),
                    border: Border.all(
                      color: isHovering
                          ? const Color(0xFF76A584)
                          : const Color(0xFF2B2B2B),
                      width: 3,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Base Pet Layer
                      Positioned.fill(
                        child: Image.asset(
                          'assets/pets/${petState.petType == PetType.sky ? 'sky' : 'ocean'}.png',
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.none,
                        ),
                      ),
                      // Tops Layer
                      if (petState.currOutfit.top.isNotEmpty)
                        Positioned.fill(
                          child: Image.asset(
                            'assets/outfits/tops/${petState.currOutfit.top}.png',
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.none,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox.shrink(),
                          ),
                        ),
                      // Bottoms Layer
                      if (petState.currOutfit.bottom.isNotEmpty)
                        Positioned.fill(
                          child: Image.asset(
                            'assets/outfits/bottoms/${petState.currOutfit.bottom}.png',
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.none,
                            errorBuilder: (context, error, stackTrace) =>
                                const SizedBox.shrink(),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
          // 2. INTERMEDIATE CONTROLS TOOLBAR
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 4.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.undo,
                        color: Color(0xFF2B2B2B),
                        size: 28,
                      ),
                      onPressed: petState.undo.isEmpty
                          ? null
                          : () => provider.undo(),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.redo,
                        color: Color(0xFF2B2B2B),
                        size: 28,
                      ),
                      onPressed: petState.redo.isEmpty
                          ? null
                          : () => provider.redo(),
                    ),
                  ],
                ),
                Row(
                  children: [
                    _buildSubCategoryTab(
                      l10n.top,
                      viewingTops,
                      () => setState(() => viewingTops = true),
                    ),
                    const SizedBox(width: 6),
                    _buildSubCategoryTab(
                      l10n.bottom,
                      !viewingTops,
                      () => setState(() => viewingTops = false),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(
            color: Color(0xFF2B2B2B),
            thickness: 2,
            indent: 24,
            endIndent: 24,
          ),
          // 3. DRAGGABLE CLOTHING SELECTION GRID
          Expanded(
            flex: 4,
            child: GridView.builder(
              key: ValueKey(viewingTops),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: activeInventory.length + 1,
              itemBuilder: (context, index) {
                // "None" Button (Clears active outfit layer)
                if (index == 0) {
                  return Semantics(
                    label: viewingTops ? 'Remove top': 'Remove bottom',
                    child: GestureDetector(
                      onTap: () {
                        if (viewingTops) {
                          provider.changeOutfit(top: '');
                        } else {
                          provider.changeOutfit(bottom: '');
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFECE4),
                          border: Border.all(
                            color: const Color(0xFF2B2B2B),
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            l10n.none,
                            style: GoogleFonts.pixelifySans(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2B2B2B),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                // Inventory Items
                final itemId = activeInventory[index - 1];
                final String exactAssetPath = viewingTops
                    ? 'assets/outfits/tops/$itemId.png'
                    : 'assets/outfits/bottoms/$itemId.png';

                final String displayName = itemId
                    .replaceAll('_', ' ')
                    .split(' ')
                    .map(
                      (str) => str.isNotEmpty
                          ? '${str[0].toUpperCase()}${str.substring(1)}'
                          : '',
                    )
                    .join(' ');

                Widget cardContent(bool isFeedback) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFEFECE4,
                      ).withOpacity(isFeedback ? 0.7 : 1.0),
                      border: Border.all(
                        color: const Color(0xFF2B2B2B),
                        width: 2,
                      ),
                    ),
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Image.asset(
                            exactAssetPath,
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.none,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.checkroom, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          displayName,
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.pixelifySans(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2B2B2B),
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Semantics(
                  label: 'Equip $displayName',
                  button: true,
                  child: Draggable<Map<String, dynamic>>(
                    data: {'id': itemId, 'isTop': viewingTops},
                    feedback: SizedBox(
                      width: 90,
                      height: 105,
                      child: cardContent(true),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: cardContent(false),
                    ),
                    child: cardContent(false),
                  ),
                );
              },
            ),
          ),
          // 4. ACTION SUBMIT PERSISTENCE FOOTER
          Padding(
            padding: const EdgeInsets.only(
              left: 24,
              right: 24,
              bottom: 24,
              top: 8,
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF76A584),
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Color(0xFF2B2B2B), width: 2.5),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  l10n.saveClose,
                  style: GoogleFonts.pixelifySans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a tab button for switching between top and bottom inventory categories.
  Widget _buildSubCategoryTab(
    String text,
    bool isSelected,
    VoidCallback action,
  ) {
    return InkWell(
      onTap: action,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF2B2B2B) : const Color(0xFFEFECE4),
          border: Border.all(color: const Color(0xFF2B2B2B), width: 2),
        ),
        child: Text(
          text,
          style: GoogleFonts.pixelifySans(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.white : const Color(0xFF2B2B2B),
          ),
        ),
      ),
    );
  }
}

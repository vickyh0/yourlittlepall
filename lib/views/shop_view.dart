import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:yourlittlepal/l10n/app_localizations.dart';
import 'package:yourlittlepal/providers/pet_provider.dart';

/// The shop view where users can purchase food and toys for their pet.
class ShopView extends StatefulWidget {
  /// Creates the shop interface.
  const ShopView({super.key});

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  /// Currently active category tab: 'food' or 'toy'.
  String activeTab = 'food';

  /// Track the currently selected item and its cost.
  String? selectedItem;
  int? selectedPrice;

  final Map<String, Map<String, dynamic>> foodItems = {
    'Carrot': {'price': 5, 'asset': 'assets/icons/carrot.png'},
    'Salmon': {'price': 15, 'asset': 'assets/icons/salmon.png'},
    'Shrimp': {'price': 12, 'asset': 'assets/icons/shrimp.png'},
    'Steak': {'price': 25, 'asset': 'assets/icons/steak.png'},
  };

  final Map<String, Map<String, dynamic>> toyItems = {
    'Hay Ball': {'price': 10, 'asset': 'assets/icons/hay_ball.png'},
    'Feather': {'price': 8, 'asset': 'assets/icons/feather.png'},
    'Pebble': {'price': 3, 'asset': 'assets/icons/pebble.png'},
    'Socks': {'price': 6, 'asset': 'assets/icons/socks.png'},
  };

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PetProvider>();
    final state = provider.state;
    final l10n = AppLocalizations.of(context)!;
    final currentItems = activeTab == 'food' ? foodItems : toyItems;

    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF2B2B2B)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          l10n.shop,
          style: GoogleFonts.pixelifySans(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF2B2B2B),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Semantics(
              label: '${state.coins} coins',
              child: Row(
                children: [
                  Image.asset('assets/icons/coins.png', width: 24, height: 24),
                  const SizedBox(width: 4),
                  Text(
                    '${state.coins}',
                    style: GoogleFonts.pixelifySans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2B2B2B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tab Selection Bar
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  _buildTabButton(l10n.food, 'food'),
                  const SizedBox(width: 12),
                  _buildTabButton(l10n.toy, 'toy'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Items Grid Layout
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.85,
                  ),
                  itemCount: currentItems.length,
                  itemBuilder: (context, index) {
                    final itemName = currentItems.keys.elementAt(index);
                    final itemData = currentItems[itemName]!;
                    final bool isSelected = selectedItem == itemName;
                    final isSold = activeTab == 'toy' && state.ownedToy.contains(itemName.toLowerCase());
                    
                    return Semantics(
                      label: isSold ? 
                      '$itemName already owned' : '$itemName costs ${itemData['price']} ',
                      child: GestureDetector(
                        onTap: isSold ? null :() => setState(() {
                          selectedItem = itemName;
                          selectedPrice = itemData['price'];
                        }),
                        child: Opacity(
                          opacity: isSold? 0.4 : 1.0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.cyan
                                    : const Color(0xFF33250E),
                                width: isSelected ? 3 : 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.asset(
                                      itemData['asset'],
                                      filterQuality: FilterQuality.none,
                                    ),
                                  ),
                                ),
                                Text(
                                  itemName,
                                  style: GoogleFonts.pixelifySans(fontSize: 12),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  isSold ? 'SOLD' : '\$${itemData['price']}',
                                  style: GoogleFonts.pixelifySans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Action Buy Button
            if (selectedItem != null)
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber[100],
                    side: const BorderSide(color: Color(0xFF33250E), width: 2),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (selectedPrice != null &&
                        state.coins >= selectedPrice!) {
                      if (activeTab == 'food') {
                        provider.buyFood(selectedItem!, selectedPrice!);
                      } else {
                        provider.buyToy(selectedItem!, selectedPrice!);
                      }
                      provider.showDialogue(l10n.dialogueBought(selectedItem!));
                      setState(() {
                        selectedItem = null;
                        selectedPrice = null;
                      });
                    } else {
                      provider.showDialogue(l10n.dialogueNoCoins);
                    }
                  },
                  child: Text(
                    l10n.buyButton,
                    style: GoogleFonts.pixelifySans(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF33250E),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Custom helper to render stylized pixel design tabs.
  Widget _buildTabButton(String label, String tabKey) {
    final bool isActive = activeTab == tabKey;
    return GestureDetector(
      onTap: () => setState(() {
        activeTab = tabKey;
        selectedItem = null;
        selectedPrice = null;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? Colors.amber[100] : Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xFF33250E), width: 2),
        ),
        child: Text(
          label,
          style: GoogleFonts.pixelifySans(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

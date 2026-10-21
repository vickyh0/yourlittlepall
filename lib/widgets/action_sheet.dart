import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A reusable bottom action sheet component that displays a header with text,
/// an icon-based close button, and a customizable body content area.
class ActionSheet extends StatelessWidget {
  /// The title text to display in the header.
  final String text;

  /// The main content widget to display within the action sheet.
  final Widget child;

  /// The asset path for the close icon button.
  final String icon;

  const ActionSheet({
    super.key,
    required this.text,
    required this.child,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.amber[50],
        // Additional decoration properties (like borders) can be added here.
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Wrap content height.
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: GoogleFonts.pixelifySans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Image.asset(icon),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Main Content
          child,

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

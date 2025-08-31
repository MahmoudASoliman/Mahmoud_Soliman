import 'package:flutter/material.dart';
import 'package:my_portfolio/core/widgets/glass_card.dart';

/// A padded, glassy section container to keep a consistent layout across the app.
class SectionContainer extends StatelessWidget {
  const SectionContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GlassCard(
      padding: const EdgeInsets.all(16),
      borderRadius: 20,
      backgroundColor: cs.surfaceContainerHighest.withValues(alpha: .18),
      borderColor: cs.outline.withValues(alpha: .18),
      child: child,
    );
  }
}

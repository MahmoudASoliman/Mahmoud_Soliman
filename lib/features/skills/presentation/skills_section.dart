import 'package:flutter/material.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    const chips = [
      'Dart', 'C++', 'Java', 'Python', 'Flutter', 'Material 3', 'Adaptive UI', 'Animations', 'Bloc/Cubit', 'GetX', 'MVC',
      'MVVM', 'REST', 'Firebase', 'Node.js', 'Google Maps API', 'AI/OCR APIs', 'Firestore', 'Hive', 'SQLite', 'Git/GitHub',
      'VS Code', 'Android Studio', 'Postman', 'Responsive Design', 'Accessibility', 'Problem Solving',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Skills', style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Wrap(spacing: 10, runSpacing: 10, children: [for (final s in chips) _SkillChip(label: s)]),
      ],
    );
  }
}

class _SkillChip extends StatefulWidget {
  const _SkillChip({required this.label});
  final String label;

  @override
  State<_SkillChip> createState() => _SkillChipState();
}

class _SkillChipState extends State<_SkillChip> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bg = cs.primary.withValues(alpha: 0.10);
    final bgHover = cs.primary.withValues(alpha: 0.16);

    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: _hover ? bgHover : bg,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: cs.outline.withValues(alpha: 0.25)),
        ),
        child: Text(widget.label, style: TextStyle(color: cs.onSurface)),
      ),
    );
  }
}

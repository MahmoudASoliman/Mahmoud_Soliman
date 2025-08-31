import 'package:flutter/material.dart';

class AboutExperienceSection extends StatelessWidget {
  const AboutExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final cs = t.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('About & Experience', style: t.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        Text(
          'Junior Flutter Developer with a strong foundation in building cross-platform apps, focusing on state '
          'management (Bloc/Cubit, MVC/MVVM), API/Firebase integrations, and responsive/adaptive UI.',
          style: t.textTheme.bodyMedium?.copyWith(color: cs.onSurfaceVariant, height: 1.5),
          maxLines: 6,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 16),
        const _Subheader('Experience'),
        const _Bullet('Freelance Flutter Developer (Remote) — 01/2023–Present: Enhanced/debugged apps, implemented features, Firebase & REST integrations, UI/UX updates, performance tuning.'),
        const SizedBox(height: 12),
        const _Subheader('Training'),
        const _Bullet('Digital Egypt Pioneers Initiative (DEPI) – Flutter Track (06/2025–Present).'),
        const _Bullet('ITI Summer Training – Mobile App Development (07/2023–08/2023).'),
        const SizedBox(height: 16),
        const _Subheader('Education'),
        const _Bullet('B.Sc. Computer Science & Artificial Intelligence — Beni Suef University (2020–2024), Very Good.'),
        const SizedBox(height: 8),
        const _Subheader('Languages'),
        const Wrap(spacing: 10, runSpacing: 10, children: [_Badge('Arabic: Native'), _Badge('English: Very Good')]),
      ],
    );
  }
}

class _Subheader extends StatelessWidget {
  const _Subheader(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(text, style: Theme.of(context).textTheme.titleMedium),
      );
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.only(top: 4), child: Icon(Icons.check_circle_rounded, size: 18)),
            const SizedBox(width: 8),
            Expanded(child: Text(text)),
          ],
        ),
      );
}

class _Badge extends StatelessWidget {
  const _Badge(this.text);
  final String text;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: cs.outline.withValues(alpha: 0.25)),
      ),
      child: Text(text, style: TextStyle(color: cs.onSurface)),
    );
  }
}

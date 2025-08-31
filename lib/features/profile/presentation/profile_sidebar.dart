import 'package:flutter/material.dart';

class ProfileSidebar extends StatelessWidget {
  const ProfileSidebar({
    super.key,
    required this.onEmail,
    required this.onCall,
    required this.onGitHub,
    required this.onLinkedIn,
  });

  final VoidCallback onEmail;
  final VoidCallback onCall;
  final VoidCallback onGitHub;
  final VoidCallback onLinkedIn;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final cs = t.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [cs.primary, cs.tertiary]),
              boxShadow: [
                BoxShadow(color: cs.primary.withValues(alpha: 0.35), blurRadius: 24, spreadRadius: 2),
              ],
            ),
            child: const CircleAvatar(
              radius: 44,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage('assets/images/profile_pic.jpg'),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: Text('Mahmoud Ahmed', style: t.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        ),
        const SizedBox(height: 4),
        Center(
          child: Text('Flutter Developer • CS & AI Graduate', style: t.textTheme.bodySmall?.copyWith(color: cs.onSurfaceVariant), textAlign: TextAlign.center),
        ),
        const SizedBox(height: 12),
        const Divider(height: 1),
        const SizedBox(height: 12),
        _ContactRow(label: 'Contact', child: _LinkText('+20 128 692 7788', onTap: onCall)),
        _ContactRow(label: 'Email', child: _LinkText('mahmoudahmed8692@gmail.com', onTap: onEmail)),
        _ContactRow(label: 'LinkedIn', child: _LinkText('@Mahmoud A. Soliman', onTap: onLinkedIn)),
        _ContactRow(label: 'GitHub', child: _LinkText('@MahmoudASoliman', onTap: onGitHub)),
        const SizedBox(height: 16),
        Text('Skills', style: t.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        const SkillMeter(name: 'Flutter', value: 0.9),
        const SkillMeter(name: 'Dart', value: 0.85),
        const SkillMeter(name: 'Firebase', value: 0.7),
        const SkillMeter(name: 'SQLite', value: 0.85),
        const SkillMeter(name: 'Responsive', value: 0.8),
        const SkillMeter(name: 'Bloc', value: 0.65),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          SizedBox(width: 84, child: Text(label, style: TextStyle(color: cs.onSurface.withValues(alpha: 0.9)))),
          const SizedBox(width: 8),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _LinkText extends StatelessWidget {
  const _LinkText(this.text, {required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: cs.primary, decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}

class SkillMeter extends StatelessWidget {
  const SkillMeter({super.key, required this.name, required this.value});
  final String name;
  final double value;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(name)),
              Text('${(value * 100).round()}%', style: TextStyle(color: cs.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              minHeight: 8,
              value: value,
              backgroundColor: cs.surfaceContainerHighest.withValues(alpha: 0.5),
              valueColor: AlwaysStoppedAnimation<Color>(cs.primary),
            ),
          ),
        ],
      ),
    );
  }
}

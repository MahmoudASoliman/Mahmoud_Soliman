import 'package:flutter/material.dart';

class AmbientNeonAccent extends StatefulWidget {
  const AmbientNeonAccent({super.key});
  @override
  State<AmbientNeonAccent> createState() => _AmbientNeonAccentState();
}

class _AmbientNeonAccentState extends State<AmbientNeonAccent>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 6),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: _c,
        builder: (context, _) {
          final t = CurvedAnimation(parent: _c, curve: Curves.easeInOut).value;
          final dx = (t - .5) * 24, dy = (.5 - t) * 18;
          return Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Transform.translate(
                  offset: Offset(dx, dy),
                  child: _NeonCardGlow(
                    size: const Size(180, 240),
                    colors: [cs.primary, cs.tertiary],
                    icon: Icons.flutter_dash_rounded,
                    opacity: .18,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Transform.translate(
                  offset: Offset(-dx, -dy),
                  child: _NeonCardGlow(
                    size: const Size(140, 180),
                    colors: [cs.secondary, cs.primary],
                    icon: Icons.auto_awesome_rounded,
                    opacity: .14,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _NeonCardGlow extends StatelessWidget {
  const _NeonCardGlow({
    required this.size,
    required this.colors,
    required this.icon,
    required this.opacity,
  });
  final Size size;
  final List<Color> colors;
  final IconData icon;
  final double opacity;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final br = BorderRadius.circular(24);
    return Container(
      width: size.width,
      height: size.height,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: br,
        gradient: LinearGradient(
          colors: [
            colors.first.withValues(alpha: opacity),
            colors.last.withValues(alpha: opacity),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: colors.first.withValues(alpha: opacity * 1.6),
            blurRadius: 32,
            spreadRadius: 4,
          ),
          BoxShadow(
            color: colors.last.withValues(alpha: opacity * 1.2),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: br,
          color: cs.surface.withValues(alpha: .06),
        ),
        child: Center(
          child: Icon(icon, size: 42, color: cs.primary.withValues(alpha: .75)),
        ),
      ),
    );
  }
}

import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_portfolio/core/widgets/letterboxed_preview.dart';

const String MY_PHOTO_URL = "assets/images/profile_pic.jpg";

class HeroSection extends StatelessWidget {
  const HeroSection({
    super.key,
    required this.onContactTap,
    required this.onProjectsTap,
  });

  final VoidCallback onContactTap;
  final VoidCallback onProjectsTap;

  @override
  Widget build(BuildContext context) {
    final t = Theme.of(context);
    final w = MediaQuery.of(context).size.width;
    final isSmall = w < 900;

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Flutter Engineer',
          style: t.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'I build fast, adaptive Flutter apps with clean architecture (Cubit/Bloc, MVVM) and production-grade tooling.',
          style: t.textTheme.titleMedium?.copyWith(
            color: t.colorScheme.onSurfaceVariant,
            height: 1.5,
          ),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            FilledButton.icon(
              onPressed: onProjectsTap,
              icon: const Icon(Icons.rocket_launch_rounded),
              label: const Text('View Work'),
            ),
            OutlinedButton.icon(
              onPressed: onContactTap,
              icon: const Icon(Icons.handshake_rounded),
              label: const Text('Hire Me'),
            ),
            const _MiniBadge(label: '3+ yrs'),
            const _MiniBadge(label: 'Flutter • Firebase'),
          ],
        ),
      ],
    );

    final right = CreativeAvatarShowcase(
      imageUrl: MY_PHOTO_URL,
      size: isSmall ? 260 : 340,
      orbitBadges: const [
        OrbitBadge(icon: Icons.flutter_dash_rounded, text: 'Flutter'),
        OrbitBadge(icon: Icons.bolt_rounded, text: 'Cubit/Bloc'),
        OrbitBadge(icon: Icons.auto_awesome_rounded, text: 'Animations'),
      ],
    );

    if (isSmall) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: right),
          const SizedBox(height: 16),
          left,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 11, child: left),
        const SizedBox(width: 24),
        Expanded(
          flex: 10,
          child: Align(alignment: Alignment.centerRight, child: right),
        ),
      ],
    );
  }
}

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({required this.label});
  final String label;
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
      child: Text(label, style: TextStyle(color: cs.onSurface)),
    );
  }
}

/// ------------- Creative Avatar (full image, no crop) -------------
class CreativeAvatarShowcase extends StatefulWidget {
  const CreativeAvatarShowcase({
    super.key,
    required this.imageUrl,
    required this.size,
    this.orbitBadges = const [],
  });

  final String imageUrl;
  final double size;
  final List<OrbitBadge> orbitBadges;

  @override
  State<CreativeAvatarShowcase> createState() => _CreativeAvatarShowcaseState();
}

class _CreativeAvatarShowcaseState extends State<CreativeAvatarShowcase>
    with TickerProviderStateMixin {
  late final AnimationController _ring = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
  )..repeat();
  late final AnimationController _hoverCtrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 220),
  );
  late final AnimationController _orbit = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 12),
  )..repeat();

  double _tiltX = 0, _tiltY = 0;
  Offset _spot = const Offset(.5, .5);

  @override
  void dispose() {
    _ring.dispose();
    _hoverCtrl.dispose();
    _orbit.dispose();
    super.dispose();
  }

  void _onHover(PointerHoverEvent e, Size s) {
    final dx = (e.localPosition.dx / s.width).clamp(0.0, 1.0);
    final dy = (e.localPosition.dy / s.height).clamp(0.0, 1.0);
    setState(() {
      _spot = Offset(dx, dy);
      _tiltX = (dy - 0.5) * -6;
      _tiltY = (dx - 0.5) * 6;
    });
    if (!_hoverCtrl.isCompleted) _hoverCtrl.forward();
  }

  void _onExit(_) {
    setState(() {
      _spot = const Offset(.5, .5);
      _tiltX = 0;
      _tiltY = 0;
    });
    _hoverCtrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = widget.size;
    const double br = 22;

    final badges = AnimatedBuilder(
      animation: _orbit,
      builder: (_, __) {
        final t = _orbit.value;
        final r = size * 0.62;
        final items = <Widget>[];
        for (int i = 0; i < widget.orbitBadges.length; i++) {
          final angle =
              (t * 2 * math.pi) + (i * 2 * math.pi / widget.orbitBadges.length);
          final x = math.cos(angle) * r / 2;
          final y = math.sin(angle) * r / 3;
          items.add(
            Transform.translate(
              offset: Offset(x, y),
              child: OrbitBadgeBubble(badge: widget.orbitBadges[i]),
            ),
          );
        }
        return Stack(children: items);
      },
    );

    return MouseRegion(
      onHover: (ev) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) _onHover(ev, box.size);
      },
      onExit: _onExit,
      child: GestureDetector(
        onTapDown: (_) => _hoverCtrl.forward(from: 0),
        onTapUp: (_) => _hoverCtrl.reverse(),
        onTapCancel: () => _hoverCtrl.reverse(),
        child: AnimatedBuilder(
          animation: Listenable.merge([_ring, _hoverCtrl]),
          builder: (_, __) {
            final hoverT = CurvedAnimation(
              parent: _hoverCtrl,
              curve: Curves.easeOut,
            ).value;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateX(_tiltX * 0.01745)
                ..rotateY(_tiltY * 0.01745)
                ..scale(1.0 + hoverT * 0.02),
              child: SizedBox(
                width: size,
                height: size,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    IgnorePointer(
                      child: CustomPaint(
                        size: Size.square(size * 1.06),
                        painter: RoundedAuraPainter(
                          t: _ring.value,
                          intensity: .30 + .35 * hoverT,
                          colors: [cs.primary, cs.tertiary],
                          radius: br,
                          inset: 6,
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(br),
                      child: LetterboxedPreview(
                        url: widget.imageUrl,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(br - 2),
                        ),
                      ),
                    ),
                    IgnorePointer(
                      child: CustomPaint(
                        size: Size.square(size),
                        painter: SpotlightPainter(spot: _spot, t: hoverT),
                      ),
                    ),
                    IgnorePointer(
                      child: CustomPaint(
                        size: Size.square(size * 1.08),
                        painter: SparklePainter(
                          t: _ring.value,
                          opacity: .10 + .75 * hoverT,
                          color: cs.primary,
                          count: 14,
                        ),
                      ),
                    ),
                    badges,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class RoundedAuraPainter extends CustomPainter {
  RoundedAuraPainter({
    required this.t,
    required this.intensity,
    required this.colors,
    required this.radius,
    this.inset = 0,
  });
  final double t;
  final double intensity;
  final List<Color> colors;
  final double radius;
  final double inset;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(
      inset,
      inset,
      size.width - inset * 2,
      size.height - inset * 2,
    );
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(radius));

    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..color = colors.first.withValues(alpha: .20 * intensity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 16);

    final ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..shader = SweepGradient(
        colors: [
          colors.first.withValues(alpha: .95),
          colors.last.withValues(alpha: .40),
          colors.first.withValues(alpha: .95),
        ],
        stops: const [0.0, .5, 1.0],
        transform: GradientRotation(t * 2 * math.pi),
      ).createShader(rect);

    canvas.drawRRect(rrect, glow);
    canvas.drawRRect(rrect, ring);
  }

  @override
  bool shouldRepaint(covariant RoundedAuraPainter old) =>
      old.t != t ||
      old.intensity != intensity ||
      old.colors != colors ||
      old.radius != radius ||
      old.inset != inset;
}

class SparklePainter extends CustomPainter {
  SparklePainter({
    required this.t,
    required this.opacity,
    required this.color,
    this.count = 12,
  });
  final double t;
  final double opacity;
  final Color color;
  final int count;

  @override
  void paint(Canvas canvas, Size size) {
    if (opacity <= 0) return;
    final r = math.min(size.width, size.height) / 2.15;
    final c = size.center(Offset.zero);
    final paint = Paint()..color = color.withValues(alpha: .75 * opacity);
    final glow = Paint()
      ..color = color.withValues(alpha: .35 * opacity)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    for (var i = 0; i < count; i++) {
      final a = (t * 2 * math.pi) + (i * 2 * math.pi / count);
      final jitter = math.sin((t + i) * 6) * 1.5;
      final p = Offset(
        c.dx + math.cos(a) * (r + jitter),
        c.dy + math.sin(a) * (r + jitter),
      );
      final radius = 2.0 + (math.sin(t * 8 + i) + 1) * 0.8;
      canvas.drawCircle(p, radius + 0.5, glow);
      canvas.drawCircle(p, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant SparklePainter old) =>
      old.t != t ||
      old.opacity != opacity ||
      old.color != color ||
      old.count != count;
}

class SpotlightPainter extends CustomPainter {
  SpotlightPainter({required this.spot, required this.t});
  final Offset spot; // 0..1
  final double t; // 0..1

  @override
  void paint(Canvas canvas, Size size) {
    if (t <= 0) return;
    final rect = Offset.zero & size;
    final shader = RadialGradient(
      center: Alignment((spot.dx - .5) * 2, (spot.dy - .5) * 2),
      radius: .55,
      colors: [
        Colors.white.withValues(alpha: .18 * t),
        Colors.transparent,
      ],
      stops: const [0.0, 1.0],
    ).createShader(rect);
    final paint = Paint()
      ..shader = shader
      ..blendMode = BlendMode.plus;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant SpotlightPainter old) =>
      old.spot != spot || old.t != t;
}

class OrbitBadge {
  final IconData icon;
  final String text;
  const OrbitBadge({required this.icon, required this.text});
}

class OrbitBadgeBubble extends StatelessWidget {
  const OrbitBadgeBubble({super.key, required this.badge});
  final OrbitBadge badge;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cs.surfaceContainerHighest.withValues(alpha: .28),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: cs.outline.withValues(alpha: .22)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(badge.icon, size: 14),
          const SizedBox(width: 6),
          Text(badge.text, style: TextStyle(fontSize: 12, color: cs.onSurface)),
        ],
      ),
    );
  }
}

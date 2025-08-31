import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  const AppBackground({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            cs.primary.withValues(alpha: .08),
            cs.surface.withValues(alpha: .02),
            cs.secondary.withValues(alpha: .06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Stack(
        children: [
          Positioned(
            top: -100,
            left: -80,
            child: _Blob(colorOpacity: .18, which: _BlobWhich.primary, size: 240),
          ),
          Positioned(
            bottom: -120,
            right: -60,
            child: _Blob(colorOpacity: .16, which: _BlobWhich.tertiary, size: 260),
          ),
          Positioned(
            top: 200,
            right: -90,
            child: _Blob(colorOpacity: .12, which: _BlobWhich.secondary, size: 220),
          ),
        ],
      ),
    );
  }
}

enum _BlobWhich { primary, secondary, tertiary }

class _Blob extends StatelessWidget {
  const _Blob({required this.colorOpacity, required this.which, required this.size});
  final double colorOpacity;
  final _BlobWhich which;
  final double size;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final base = switch (which) {
      _BlobWhich.primary => cs.primary,
      _BlobWhich.secondary => cs.secondary,
      _BlobWhich.tertiary => cs.tertiary,
    };
    final color = base.withValues(alpha: colorOpacity);
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: .6),
              blurRadius: 60,
              spreadRadius: 10,
            ),
          ],
        ),
      ),
    );
  }
}

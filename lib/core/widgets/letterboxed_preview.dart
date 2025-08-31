import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';

bool isNetwork(String path) => path.startsWith('http');

/// Background blur + full contain image without crop
class LetterboxedPreview extends StatelessWidget {
  const LetterboxedPreview({
    super.key,
    required this.url,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  });

  final String url;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // blurry background
          Positioned.fill(
            child: isNetwork(url)
                ? ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.black26,
                        BlendMode.darken,
                      ),
                      child: Image.network(url, fit: BoxFit.cover),
                    ),
                  )
                : ImageFiltered(
                    imageFilter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.black26,
                        BlendMode.darken,
                      ),
                      child: Image.asset(url, fit: BoxFit.cover),
                    ),
                  ),
          ),
          // subtle border
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                border: Border.all(color: Colors.white.withValues(alpha: .06)),
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: .55),
                borderRadius: BorderRadius.circular(14),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 18,
                    spreadRadius: 0,
                    offset: Offset(0, 6),
                  ),
                ],
                border: Border.all(color: Colors.white.withValues(alpha: .08)),
              ),
              clipBehavior: Clip.antiAlias,
              child: isNetwork(url)
                  ? Image.network(url, fit: BoxFit.contain)
                  : Image.asset(url, fit: BoxFit.contain),
            ),
          ),
          const Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Color(0x22000000), Color(0x00000000)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

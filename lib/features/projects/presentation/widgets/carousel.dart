import 'package:flutter/material.dart';
import 'package:my_portfolio/core/widgets/letterboxed_preview.dart';

class ProjectCarousel extends StatefulWidget {
  const ProjectCarousel({
    super.key,
    required this.urls,
    this.aspectRatio = 16 / 9,
    this.borderRadius,
    this.onTapImage,
  });

  final List<String> urls;
  final double aspectRatio;
  final BorderRadius? borderRadius;
  final VoidCallback? onTapImage;

  @override
  State<ProjectCarousel> createState() => _ProjectCarouselState();
}

class _ProjectCarouselState extends State<ProjectCarousel> {
  late final PageController _pc = PageController();
  int _page = 0;

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final br = widget.borderRadius ?? BorderRadius.circular(16);

    final child = AspectRatio(
      aspectRatio: widget.aspectRatio,
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _pc,
            itemCount: widget.urls.length,
            onPageChanged: (i) => setState(() => _page = i),
            itemBuilder: (_, i) => GestureDetector(
              onTap: widget.onTapImage,
              child: LetterboxedPreview(url: widget.urls[i], borderRadius: br),
            ),
          ),
          Positioned(
            bottom: 8,
            left: 0,
            right: 0,
            child: Center(
              child: _Dots(count: widget.urls.length, index: _page),
            ),
          ),
        ],
      ),
    );

    return ClipRRect(borderRadius: br, child: child);
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.index});
  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Wrap(
      spacing: 6,
      children: List.generate(
        count,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: i == index ? 18 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: (i == index ? cs.primary : cs.onSurfaceVariant).withValues(
              alpha: i == index ? .9 : .5,
            ),
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}

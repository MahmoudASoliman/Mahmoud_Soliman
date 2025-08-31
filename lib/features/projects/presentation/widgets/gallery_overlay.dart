import 'package:flutter/material.dart';
import 'package:my_portfolio/core/widgets/glass_card.dart';
import 'package:my_portfolio/core/widgets/letterboxed_preview.dart';

Future<void> showGalleryOverlay(
  BuildContext context, {
  required List<String> urls,
  int initialIndex = 0,
}) {
  return showGeneralDialog(
    context: context,
    barrierLabel: 'Gallery',
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: .45),
    transitionDuration: const Duration(milliseconds: 220),
    pageBuilder: (ctx, anim, __) => _GalleryOverlay(urls: urls, initialIndex: initialIndex),
    transitionBuilder: (ctx, anim, __, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOut);
      return FadeTransition(opacity: curved, child: child);
    },
  );
}

class _GalleryOverlay extends StatefulWidget {
  const _GalleryOverlay({required this.urls, required this.initialIndex});
  final List<String> urls;
  final int initialIndex;

  @override
  State<_GalleryOverlay> createState() => _GalleryOverlayState();
}

class _GalleryOverlayState extends State<_GalleryOverlay> {
  late final PageController _pc = PageController(initialPage: widget.initialIndex);
  late int _page = widget.initialIndex;

  @override
  void dispose() {
    _pc.dispose();
    super.dispose();
  }

  void _go(int delta) {
    final next = (_page + delta).clamp(0, widget.urls.length - 1);
    if (next != _page) {
      _pc.animateToPage(next, duration: const Duration(milliseconds: 220), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    final maxW = size.width * .94;
    final maxH = size.height * .9;

    return SafeArea(
      child: Center(
        child: GlassCard(
          borderRadius: 24,
          blurSigma: 18,
          backgroundColor: cs.surfaceContainerHighest.withValues(alpha: .30),
          borderColor: cs.outline.withValues(alpha: .20),
          padding: const EdgeInsets.all(12),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 980, maxHeight: maxH, minWidth: maxW.clamp(280, 980)),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: PageView.builder(
                    controller: _pc,
                    onPageChanged: (i) => setState(() => _page = i),
                    itemCount: widget.urls.length,
                    itemBuilder: (_, i) => InteractiveViewer(
                      minScale: 1,
                      maxScale: 5,
                      child: Center(
                        child: LetterboxedPreview(url: widget.urls[i], borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 6,
                  left: 6,
                  child: IconButton.filled(
                    style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black.withValues(alpha: .35))),
                    icon: const Icon(Icons.close_rounded, color: Colors.white),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(color: Colors.black.withValues(alpha: .35), borderRadius: BorderRadius.circular(999)),
                    child: Text('${_page + 1}/${widget.urls.length}', style: const TextStyle(color: Colors.white)),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Wrap(
                      spacing: 6,
                      children: List.generate(
                        widget.urls.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          width: i == _page ? 18 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: (i == _page ? cs.primary : cs.onSurfaceVariant).withValues(alpha: i == _page ? .9 : .5),
                            borderRadius: BorderRadius.circular(999),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (size.width >= 800)
                  Positioned.fill(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton.filled(
                          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black.withValues(alpha: .30))),
                          onPressed: () => _go(-1),
                          icon: const Icon(Icons.chevron_left_rounded, color: Colors.white),
                        ),
                        IconButton.filled(
                          style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(Colors.black.withValues(alpha: .30))),
                          onPressed: () => _go(1),
                          icon: const Icon(Icons.chevron_right_rounded, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_portfolio/core/widgets/glass_card.dart';
import 'package:my_portfolio/features/projects/model/project.dart';
import 'package:my_portfolio/features/projects/presentation/widgets/carousel.dart';
import 'package:my_portfolio/features/projects/presentation/widgets/gallery_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

class ProProjectCard extends StatefulWidget {
  const ProProjectCard({super.key, required this.project});
  final Project project;
  @override
  State<ProProjectCard> createState() => _ProProjectCardState();
}

class _ProProjectCardState extends State<ProProjectCard> {
  double _tiltX = 0, _tiltY = 0;

  void _onHover(PointerHoverEvent e, Size s) {
    final dx = (e.localPosition.dx / s.width) - 0.5;
    final dy = (e.localPosition.dy / s.height) - 0.5;
    setState(() {
      _tiltX = dy * -4;
      _tiltY = dx * 4;
    });
  }

  void _openGallery(int initial) {
    showGalleryOverlay(
      context,
      urls: widget.project.imageUrls,
      initialIndex: initial,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final p = widget.project;
    final br = BorderRadius.circular(18);

    return MouseRegion(
      onHover: (ev) {
        final box = context.findRenderObject() as RenderBox?;
        if (box != null && box.hasSize) _onHover(ev, box.size);
      },
      onExit: (_) => setState(() {
        _tiltX = 0;
        _tiltY = 0;
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(_tiltX * 0.01745)
          ..rotateY(_tiltY * 0.01745),
        child: GlassCard(
          padding: EdgeInsets.zero,
          borderRadius: 18,
          backgroundColor: cs.surfaceContainerHighest.withValues(alpha: 0.22),
          borderColor: cs.outline.withValues(alpha: 0.22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: br.topLeft,
                  topRight: br.topRight,
                ),
                child: Stack(
                  children: [
                    ProjectCarousel(
                      urls: p.imageUrls,
                      aspectRatio: 16 / 9,
                      onTapImage: () => _openGallery(0),
                    ),
                    Positioned(
                      right: 10,
                      top: 10,
                      child: _LiveBadge(isLive: p.demoUrl.isNotEmpty),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 10,
                      child: Wrap(
                        spacing: 6,
                        children: p.tags
                            .take(3)
                            .map((t) => _TagChip(t))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      p.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Wrap(
                      spacing: 10,
                      runSpacing: 6,
                      children: [
                        _ValueDot(text: 'Clean Arch'),
                        _ValueDot(text: 'Cubit/Bloc'),
                        _ValueDot(text: 'Perf+'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (p.repoUrl.isNotEmpty)
                          _LinkButton(
                            icon: Icons.code_rounded,
                            label: 'Repo',
                            url: p.repoUrl,
                          ),
                        if (p.demoUrl.isNotEmpty)
                          _LinkButton(
                            icon: Icons.play_arrow_rounded,
                            label: 'Demo',
                            url: p.demoUrl,
                          ),
                        OutlinedButton.icon(
                          icon: const Icon(Icons.article_rounded),
                          label: const Text('Case Study'),
                          onPressed: () => _showCaseStudy(context, p),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCaseStudy(BuildContext context, Project p) {
    showDialog(
      context: context,
      builder: (_) {
        final t = Theme.of(context);
        return Dialog(
          insetPadding: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p.title,
                    style: t.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Problem → Solution → Tech → Impact',
                    style: t.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: ProjectCarousel(
                      urls: p.imageUrls,
                      aspectRatio: 16 / 9,
                      onTapImage: () {},
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Problem', style: t.textTheme.titleMedium),
                  const Text(
                    'Explain the challenge: performance, UX, data sync, etc.',
                  ),
                  const SizedBox(height: 8),
                  Text('Solution', style: t.textTheme.titleMedium),
                  const Text(
                    'Architecture (Cubit/MVVM), caching, error handling, accessibility.',
                  ),
                  const SizedBox(height: 8),
                  Text('Impact', style: t.textTheme.titleMedium),
                  const Text('Numbers or before/after GIFs.'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      if (p.repoUrl.isNotEmpty)
                        _LinkButton(
                          icon: Icons.code_rounded,
                          label: 'Repo',
                          url: p.repoUrl,
                        ),
                      if (p.demoUrl.isNotEmpty)
                        _LinkButton(
                          icon: Icons.play_arrow_rounded,
                          label: 'Demo',
                          url: p.demoUrl,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip(this.t);
  final String t;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: cs.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: cs.outline.withValues(alpha: 0.25)),
      ),
      child: Text(t, style: TextStyle(color: cs.onSurface)),
    );
  }
}

class _LiveBadge extends StatelessWidget {
  const _LiveBadge({required this.isLive});
  final bool isLive;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: (isLive ? cs.tertiary : cs.secondary).withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: cs.outline.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(
            isLive ? Icons.podcasts_rounded : Icons.bolt_rounded,
            size: 16,
            color: cs.onSurface,
          ),
          const SizedBox(width: 6),
          Text(
            isLive ? 'Live' : 'Prototype',
            style: TextStyle(color: cs.onSurface),
          ),
        ],
      ),
    );
  }
}

class _ValueDot extends StatelessWidget {
  const _ValueDot({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(text, style: TextStyle(color: cs.onSurfaceVariant)),
      ],
    );
  }
}

class _LinkButton extends StatelessWidget {
  const _LinkButton({
    required this.icon,
    required this.label,
    required this.url,
    super.key,
  });
  final IconData icon;
  final String label;
  final String url;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Icon(icon),
      label: Text(label),
      onPressed: () {
        final uri = Uri.tryParse(url);
        if (uri != null) launchUrl(uri, mode: LaunchMode.externalApplication);
      },
    );
  }
}

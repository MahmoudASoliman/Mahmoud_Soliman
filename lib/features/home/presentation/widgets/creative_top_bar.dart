import 'dart:ui' show ImageFilter;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CreativeTopBar extends StatefulWidget {
  const CreativeTopBar({
    super.key,
    required this.showInlineNav,
    required this.onMenu,
    required this.onNavigate,
    required this.onProfile,
    required this.themeMode,
    required this.onToggleTheme,
  });

  final bool showInlineNav;
  final VoidCallback onMenu;
  final void Function(int index) onNavigate;
  final VoidCallback onProfile;
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  @override
  State<CreativeTopBar> createState() => _CreativeTopBarState();
}

class _CreativeTopBarState extends State<CreativeTopBar>
    with SingleTickerProviderStateMixin {
  bool _hoverName = false;
  late final AnimationController _shine = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat();

  final _wa = Uri.parse(
    'https://wa.me/201286927788?text=Hi%20Mahmoud%2C%20I%20saw%20your%20portfolio',
  );
  final _cv = Uri.parse(
    'https://drive.google.com/file/d/1EqP_d66jT4NR2jP3KEYCA03cOL7MIkpb/view?usp=drive_link',
  );

  @override
  void dispose() {
    _shine.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final w = MediaQuery.of(context).size.width;
    final bool compact = w < 980;
    final bool ultraCompact = w < 360;

    final pill = ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: compact ? 8 : 12,
            vertical: compact ? 6 : 8,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(
              colors: [
                cs.surface.withValues(alpha: .50),
                cs.surface.withValues(alpha: .22),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(
              color: cs.outlineVariant.withValues(alpha: .6),
              width: 0.7,
            ),
            boxShadow: [
              BoxShadow(
                color: cs.primary.withValues(alpha: .18),
                blurRadius: 24,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(compact ? 6 : 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(colors: [cs.primary, cs.tertiary]),
                ),
                child: const Icon(
                  Icons.flutter_dash_rounded,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              const SizedBox(width: 8),

              if (!ultraCompact)
                Expanded(
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => setState(() => _hoverName = true),
                    onExit: (_) => setState(() => _hoverName = false),
                    child: GestureDetector(
                      onTap: widget.onProfile,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          'Mahmoud Ahmed',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            color: _hoverName ? cs.primary : cs.onSurface,
                            decoration: _hoverName
                                ? TextDecoration.underline
                                : TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              if (widget.showInlineNav) ...[
                _NavChip(label: 'Home', onTap: () => widget.onNavigate(0)),
                _NavChip(label: 'Projects', onTap: () => widget.onNavigate(2)),
                _NavChip(label: 'Skills', onTap: () => widget.onNavigate(1)),
                _NavChip(label: 'About', onTap: () => widget.onNavigate(3)),
                _NavChip(label: 'Contact', onTap: () => widget.onNavigate(4)),
                const SizedBox(width: 6),
              ] else ...[
                IconButton(
                  tooltip: 'Menu',
                  onPressed: widget.onMenu,
                  icon: const Icon(Icons.menu_rounded),
                ),
              ],
              if (!compact) ...[
                ContactPill(
                  label: 'Whatsapp',
                  icon: FontAwesomeIcons.whatsapp,
                  url: _wa.toString(),
                  height: 38,
                ),
                const SizedBox(width: 8),
                ContactPill(
                  label: 'View CV',
                  icon: FontAwesomeIcons.filePdf,
                  url: _cv.toString(),
                  height: 38,
                ),
                const SizedBox(width: 6),
              ] else ...[
                ContactPill.iconOnly(
                  icon: FontAwesomeIcons.whatsapp,
                  url: _wa.toString(),
                  diameter: 36,
                  tooltip: 'Whatsapp',
                ),
                const SizedBox(width: 6),
                ContactPill.iconOnly(
                  icon: FontAwesomeIcons.filePdf,
                  url: _cv.toString(),
                  diameter: 36,
                  tooltip: 'View CV',
                ),
                const SizedBox(width: 4),
              ],
              IconButton(
                tooltip: 'Profile',
                onPressed: widget.onProfile,
                icon: const Icon(Icons.person_rounded),
              ),
              compact
                  ? _ThemeIconButton(
                      isDark: widget.themeMode == ThemeMode.dark,
                      onToggle: widget.onToggleTheme,
                    )
                  : _ThemeSegment(
                      isDark: widget.themeMode == ThemeMode.dark,
                      onToggle: widget.onToggleTheme,
                    ),
            ],
          ),
        ),
      ),
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        pill,
        Positioned.fill(
          child: IgnorePointer(
            child: AnimatedBuilder(
              animation: _shine,
              builder: (_, __) {
                final t = _shine.value;
                return CustomPaint(
                  painter: ShinePainter(
                    color: cs.primary.withValues(alpha: .12),
                    t: t,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _ThemeIconButton extends StatelessWidget {
  const _ThemeIconButton({required this.isDark, required this.onToggle});
  final bool isDark;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: isDark ? 'Light mode' : 'Dark mode',
      onPressed: onToggle,
      icon: Icon(isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded),
    );
  }
}

class _NavChip extends StatelessWidget {
  const _NavChip({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }
}

class _ThemeSegment extends StatelessWidget {
  const _ThemeSegment({required this.isDark, required this.onToggle});
  final bool isDark;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onToggle,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        height: 34,
        width: 78,
        margin: const EdgeInsets.only(left: 6),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: cs.outlineVariant.withValues(alpha: .6),
            width: .8,
          ),
          color: cs.surface.withValues(alpha: .28),
        ),
        child: AnimatedAlign(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            width: 34,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: LinearGradient(
                colors: [
                  isDark ? cs.primary : cs.tertiary,
                  (isDark ? cs.primary : cs.tertiary).withValues(alpha: .7),
                ],
              ),
            ),
            child: Icon(
              isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
              size: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class ShinePainter extends CustomPainter {
  ShinePainter({required this.color, required this.t});
  final Color color;
  final double t;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment(-1 + 2 * t, -1),
        end: Alignment(0 + 2 * t, 1),
        colors: [
          color.withValues(alpha: 0.0),
          color,
          color.withValues(alpha: 0.0),
        ],
      ).createShader(Offset.zero & size);
    final r = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(28),
    );
    canvas.clipRRect(r);
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant ShinePainter old) =>
      old.t != t || old.color != color;
}

/// -------------- ContactPill (shared button) --------------
class ContactPill extends StatefulWidget {
  const ContactPill({
    super.key,
    required this.label,
    required this.icon,
    required this.url,
    this.height = 44,
  }) : _iconOnly = false,
       diameter = 0,
       tooltip = null;

  const ContactPill.iconOnly({
    super.key,
    required this.icon,
    required this.url,
    this.diameter = 40,
    this.tooltip,
  }) : label = '',
       height = 0,
       _iconOnly = true;

  final String label;
  final IconData icon;
  final String url;
  final double height;

  // icon-only
  final bool _iconOnly;
  final double diameter;
  final String? tooltip;

  @override
  State<ContactPill> createState() => _ContactPillState();
}

class _ContactPillState extends State<ContactPill>
    with TickerProviderStateMixin {
  late final AnimationController _loop = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 5),
  )..repeat();
  late final AnimationController _press = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 140),
  );

  double _tiltX = 0, _tiltY = 0;

  @override
  void dispose() {
    _loop.dispose();
    _press.dispose();
    super.dispose();
  }

  void _launch() {
    final uri = Uri.tryParse(widget.url);
    if (uri != null) launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  void _onTapDown(TapDownDetails _) {
    _press.forward();
    // ignore: deprecated_member_use
    Feedback.forTap(context);
  }

  void _onTapEnd([_]) => _press.reverse();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    final c1 = cs.tertiaryContainer.withValues(alpha: .95);
    final c2 = cs.primaryContainer.withValues(alpha: .95);
    final c3 = Colors.white.withValues(alpha: .96);

    final content = AnimatedBuilder(
      animation: Listenable.merge([_loop, _press]),
      builder: (_, __) {
        final pressed = _press.value;
        final scale = 1.0 - pressed * 0.04;
        final glow = .26 + pressed * .30;

        return Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_tiltX * 0.01745)
            ..rotateY(_tiltY * 0.01745)
            ..scale(scale),
          child: Container(
            height: widget._iconOnly ? widget.diameter : widget.height,
            constraints: widget._iconOnly
                ? BoxConstraints.tight(Size.square(widget.diameter))
                : const BoxConstraints(minWidth: 110),
            padding: widget._iconOnly
                ? EdgeInsets.zero
                : const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(999),
              gradient: LinearGradient(
                colors: [c1, c2, c3],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: cs.primary.withValues(alpha: glow),
                  blurRadius: 24,
                  spreadRadius: 1,
                ),
                BoxShadow(
                  color: cs.tertiary.withValues(alpha: glow * .8),
                  blurRadius: 18,
                  spreadRadius: 1,
                ),
              ],
              border: Border.all(color: Colors.white.withValues(alpha: .18)),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: const SizedBox.expand(),
                    ),
                  ),
                ),
                if (widget._iconOnly)
                  Center(
                    child: FaIcon(widget.icon, color: Colors.white, size: 18),
                  )
                else
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(widget.icon, color: Colors.white, size: 18),
                      const SizedBox(width: 8),
                      const Text(
                        '',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        widget.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );

    final gesture = GestureDetector(
      onTap: _launch,
      onTapDown: _onTapDown,
      onTapCancel: _onTapEnd,
      onTapUp: _onTapEnd,
      child: MouseRegion(
        onHover: (e) {
          final box = context.findRenderObject() as RenderBox?;
          if (box != null && box.hasSize) {
            final dx = (e.localPosition.dx / box.size.width) - 0.5;
            final dy = (e.localPosition.dy / box.size.height) - 0.5;
            setState(() {
              _tiltX = dy * -3;
              _tiltY = dx * 3;
            });
          }
        },
        onExit: (_) => setState(() {
          _tiltX = 0;
          _tiltY = 0;
        }),
        child: content,
      ),
    );

    return widget.tooltip == null
        ? gesture
        : Tooltip(message: widget.tooltip!, child: gesture);
  }
}

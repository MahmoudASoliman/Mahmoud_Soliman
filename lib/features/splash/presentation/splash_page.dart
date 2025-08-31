import 'package:flutter/material.dart';
import 'package:my_portfolio/core/widgets/background.dart';
import 'package:my_portfolio/core/widgets/glass_card.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key, required this.nextPageBuilder});
  final WidgetBuilder nextPageBuilder;

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 650), // أسرع
  );

  // منحنيات خفيفة وسلسة
  late final Animation<double> _fade = CurvedAnimation(
    parent: _ctrl,
    curve: const Interval(0.0, 0.85, curve: Curves.easeOutCubic),
  );

  late final Animation<double> _scale = Tween(
    begin: .94,
    end: 1.0,
  ).chain(CurveTween(curve: Curves.easeOutCubic)).animate(_ctrl);

  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    await _ctrl.forward(); // من غير Delays إضافية
    if (!mounted || _navigated) return;
    _goNext();
  }

  void _goNext() {
    if (_navigated) return;
    _navigated = true;

    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 220), // انتقال سريع
        pageBuilder: (r, __, ___) => widget.nextPageBuilder(r),
        transitionsBuilder: (_, anim, __, child) {
          final curved = CurvedAnimation(
            parent: anim,
            curve: Curves.easeOutCubic,
          );
          return FadeTransition(
            opacity: curved,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, .02),
                end: Offset.zero,
              ).animate(curved),
              child: child,
            ),
          );
        },
      ),
    );
  }

  // تخطي سريع بالضغط (اختياري)
  void _skip() {
    if (!_navigated) {
      _ctrl.stop();
      _goNext();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AppBackground(),
          Center(
            child: GestureDetector(
              onTap: _skip, // اضغط لتعدّي بسرعة
              child: RepaintBoundary(
                child: FadeTransition(
                  opacity: _fade,
                  child: ScaleTransition(
                    scale: _scale,
                    child: GlassCard(
                      padding: const EdgeInsets.all(28),
                      borderRadius: 96,
                      backgroundColor: cs.surfaceContainerHighest.withValues(
                        alpha: .28,
                      ),
                      borderColor: cs.outline.withValues(alpha: .22),
                      blurSigma: 12, // كان 18 → أخف وأسرع
                      child: const SizedBox(
                        width: 144,
                        height: 144,
                        child: Icon(Icons.flutter_dash_rounded, size: 64),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

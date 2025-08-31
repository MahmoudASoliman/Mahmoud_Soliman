import 'package:flutter/material.dart';
import 'package:my_portfolio/core/widgets/glass_card.dart';
import 'package:my_portfolio/features/profile/presentation/profile_sidebar.dart';
import 'package:my_portfolio/core/constants/app_breakpoints.dart';

Future<void> showProfileSideSheet(
  BuildContext context, {
  required VoidCallback onEmail,
  required VoidCallback onCall,
  required VoidCallback onGitHub,
  required VoidCallback onLinkedIn,
}) {
  final size = MediaQuery.of(context).size;
  final isSmall = AppBreakpoints.isSmall(size.width);
  final panelWidth = isSmall ? size.width : (size.width >= 1400 ? 480.0 : 420.0);

  return showGeneralDialog(
    context: context,
    barrierLabel: 'Profile',
    barrierDismissible: true,
    barrierColor: Colors.black.withValues(alpha: 0.35),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (ctx, anim, secondary) {
      final panel = SafeArea(
        child: Align(
          alignment: isSmall ? Alignment.bottomCenter : Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: isSmall ? 8 : 16, left: 8, bottom: isSmall ? 8 : 16, top: isSmall ? 8 : 16),
            child: SizedBox(
              width: isSmall ? (panelWidth * 0.98) : panelWidth,
              child: _SideSheetFrame(
                title: 'Profile',
                child: ProfileSidebar(
                  onEmail: onEmail,
                  onCall: onCall,
                  onGitHub: onGitHub,
                  onLinkedIn: onLinkedIn,
                ),
              ),
            ),
          ),
        ),
      );
      return panel;
    },
    transitionBuilder: (ctx, anim, secondary, child) {
      final curved = CurvedAnimation(parent: anim, curve: Curves.easeOutCubic);
      final slide = Tween<Offset>(begin: isSmall ? const Offset(0, 1) : const Offset(1, 0), end: Offset.zero).animate(curved);
      return FadeTransition(opacity: curved, child: SlideTransition(position: slide, child: child));
    },
  );
}

class _SideSheetFrame extends StatelessWidget {
  const _SideSheetFrame({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GlassCard(
      borderRadius: 24,
      blurSigma: 18,
      backgroundColor: cs.surfaceContainerHighest.withValues(alpha: .32),
      borderColor: cs.outline.withValues(alpha: .22),
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Material(
        type: MaterialType.transparency,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text('Profile', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
                const Spacer(),
                IconButton(tooltip: 'Close', onPressed: () => Navigator.of(context).maybePop(), icon: const Icon(Icons.close_rounded)),
              ],
            ),
            const Divider(height: 8),
            Flexible(child: SingleChildScrollView(child: child)),
          ],
        ),
      ),
    );
  }
}

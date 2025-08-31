import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/app/state/theme_cubit.dart';
import 'package:my_portfolio/core/constants/app_breakpoints.dart';
import 'package:my_portfolio/core/navigation/no_glow_behavior.dart';
import 'package:my_portfolio/core/widgets/ambient_neon_accent.dart';
import 'package:my_portfolio/core/widgets/background.dart';
import 'package:my_portfolio/core/widgets/section_container.dart';
import 'package:my_portfolio/features/home/presentation/widgets/creative_top_bar.dart';
import 'package:my_portfolio/features/home/presentation/widgets/side_nav_drawer.dart';
import 'package:my_portfolio/features/home/presentation/sections/hero_section.dart';
import 'package:my_portfolio/features/projects/presentation/projects_section.dart';
import 'package:my_portfolio/features/skills/presentation/skills_section.dart';
import 'package:my_portfolio/features/about/presentation/about_experience_section.dart';
import 'package:my_portfolio/features/contact/presentation/contact_section.dart';
import 'package:my_portfolio/features/profile/presentation/side_sheet.dart';

class PortfolioHome extends StatefulWidget {
  const PortfolioHome({super.key});

  @override
  State<PortfolioHome> createState() => _PortfolioHomeState();
}

class _PortfolioHomeState extends State<PortfolioHome> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();

  final _heroKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _contactKey = GlobalKey();

  int _drawerSelection = 0;

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
        alignment: 0.1,
      );
    }
  }

  void _navigateTo(int index) {
    switch (index) {
      case 0:
        _scrollTo(_heroKey);
        break;
      case 1:
        _scrollTo(_skillsKey);
        break;
      case 2:
        _scrollTo(_projectsKey);
        break;
      case 3:
        _scrollTo(_aboutKey);
        break;
      case 4:
        _scrollTo(_contactKey);
        break;
      default:
        break;
    }
  }

  void _openProfilePanel() {
    showProfileSideSheet(
      context,
      onEmail: () {},
      onCall: () {},
      onGitHub: () {},
      onLinkedIn: () {},
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final w = MediaQuery.of(context).size.width;
    final isLarge = AppBreakpoints.isLarge(w);

    return Scaffold(
      key: _scaffoldKey,
      drawer: isLarge
          ? null
          : SideNavDrawer(
              selectedIndex: _drawerSelection,
              onSelect: (i) {
                setState(() => _drawerSelection = i);
                Navigator.pop(context);
                _navigateTo(i);
              },
            ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          const AppBackground(),
          const Positioned.fill(child: AmbientNeonAccent()),
          SafeArea(
            child: FocusTraversalGroup(
              child: ScrollConfiguration(
                behavior: const NoGlowBehavior(),
                child: SingleChildScrollView(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(0, 92, 0, 24),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: Builder(
                        builder: (context) {
                          final width = MediaQuery.of(context).size.width;
                          final horizontal = AppBreakpoints.isSmall(width)
                              ? 16.0
                              : AppBreakpoints.isMedium(width)
                                  ? 24.0
                                  : 32.0;
                          final vSpacing =
                              AppBreakpoints.isSmall(width) ? 16.0 : 24.0;

                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: horizontal),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SectionContainer(
                                  key: _heroKey,
                                  child: HeroSection(
                                    onContactTap: () => _scrollTo(_contactKey),
                                    onProjectsTap: () => _scrollTo(_projectsKey),
                                  ),
                                ),
                                SizedBox(height: vSpacing),
                                const SectionContainer(
                                  key: Key('projects-section'),
                                  child: ProjectsSection(),
                                ),
                                SizedBox(height: vSpacing),
                                const SectionContainer(
                                  child: SkillsSection(),
                                ),
                                SizedBox(height: vSpacing),
                                const SectionContainer(
                                  child: AboutExperienceSection(),
                                ),
                                SizedBox(height: vSpacing),
                                const SectionContainer(
                                  child: ContactSection(),
                                ),
                                SizedBox(height: vSpacing + 8),
                                Center(
                                  child: Text(
                                    '© ${DateTime.now().year} Mahmoud Ahmed. All rights reserved.',
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                          color: cs.onSurface.withValues(alpha: 0.7),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Top Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: CreativeTopBar(
                  showInlineNav: isLarge,
                  onMenu: () => _scaffoldKey.currentState?.openDrawer(),
                  onNavigate: _navigateTo,
                  onProfile: _openProfilePanel,
                  themeMode: context.watch<ThemeCubit>().state,
                  onToggleTheme: context.read<ThemeCubit>().toggle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

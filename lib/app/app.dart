import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/app/state/theme_cubit.dart';
import 'package:my_portfolio/app/theme/app_theme.dart';
import 'package:my_portfolio/features/splash/presentation/splash_page.dart';
import 'package:my_portfolio/features/home/presentation/pages/portfolio_home.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, mode) {
        final theme = buildAppTheme(Brightness.light);
        final darkTheme = buildAppTheme(Brightness.dark);

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Mahmoud Ahmed | Flutter Portfolio',
          themeMode: mode,
          theme: theme,
          darkTheme: darkTheme,
          builder: (context, child) {
            final clamped = MediaQuery.textScalerOf(context)
                .clamp(minScaleFactor: 0.85, maxScaleFactor: 1.15);
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaler: clamped),
              child: child!,
            );
          },
          home: SplashPage(
            nextPageBuilder: (context) => const PortfolioHome(),
          ),
        );
      },
    );
  }
}

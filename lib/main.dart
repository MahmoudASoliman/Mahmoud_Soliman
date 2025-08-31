library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/app/app.dart';
import 'package:my_portfolio/app/state/theme_cubit.dart';
import 'package:my_portfolio/features/projects/state/projects_cubit.dart';

void main() {
  runApp(const AppBootstrap());
}

/// Root widget that wires Cubits and the App.
class AppBootstrap extends StatelessWidget {
  const AppBootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => ProjectsCubit()..loadInitial()),
      ],
      child: const AppRoot(),
    );
  }
}

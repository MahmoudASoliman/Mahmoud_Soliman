import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData buildAppTheme(Brightness brightness) {
  const seed = Color(0xFF294C9B);
  final scheme = ColorScheme.fromSeed(seedColor: seed, brightness: brightness);

  final base = GoogleFonts.cairoTextTheme();
  final textTheme = base.apply(
    bodyColor: scheme.onSurface,
    displayColor: scheme.onSurface,
  );

  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    textTheme: textTheme,
  );
}

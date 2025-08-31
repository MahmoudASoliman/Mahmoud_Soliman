# Flutter Portfolio (MVVM + Cubit) — drop-in lib/

This is a modular reorganization of your portfolio into **MVVM + Cubit** with the smallest practical files for maintainability while preserving your animations & interactivity.

## Structure

```
lib/
  app/
    app.dart                  # MaterialApp + Splash → Home
    theme/app_theme.dart      # ColorScheme + Cairo font
    state/theme_cubit.dart    # App-wide ThemeMode
  core/
    constants/app_breakpoints.dart
    navigation/no_glow_behavior.dart
    widgets/
      background.dart
      ambient_neon_accent.dart
      glass_card.dart
      letterboxed_preview.dart
      section_container.dart
  features/
    splash/presentation/splash_page.dart
    home/presentation/pages/portfolio_home.dart
    home/presentation/widgets/creative_top_bar.dart
    home/presentation/widgets/side_nav_drawer.dart
    home/presentation/sections/hero_section.dart
    profile/presentation/profile_sidebar.dart
    profile/presentation/side_sheet.dart
    projects/
      data/assets_data.dart         # demo assets list
      model/project.dart
      state/projects_cubit.dart     # MVVM ViewModel (Cubit)
      presentation/
        projects_section.dart
        widgets/carousel.dart
        widgets/gallery_overlay.dart
        widgets/project_card.dart
    skills/presentation/skills_section.dart
    about/presentation/about_experience_section.dart
    contact/presentation/contact_section.dart
  main.dart
```

## Packages (add to `pubspec.yaml`)

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  google_fonts: ^6.2.1
  url_launcher: ^6.3.0
  font_awesome_flutter: ^10.7.0
```

> **Assets**: keep your existing images in `assets/images/` (same names used in your original code).

## Notes

- `ProjectsCubit` acts as the **ViewModel** for the Projects MVVM slice (list + filter). You can add more cubits for other sections if needed.
- `ThemeCubit` replaces your manual theme toggle.
- All interactive painters/animations were kept and split cleanly.
- Colors use `.withValues(alpha: x)` to match your Flutter channel; if your SDK doesn’t support it, replace with `.withOpacity(x)`.

## Where to start editing?

- **UI**: open `features/home/presentation/pages/portfolio_home.dart`
- **Top Bar**: `features/home/presentation/widgets/creative_top_bar.dart`
- **Projects**: `features/projects/*`
- **Avatar/Hero**: `features/home/presentation/sections/hero_section.dart`
```


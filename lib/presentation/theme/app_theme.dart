import 'package:crud_app/presentation/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData build() {
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppPalette.seed,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        scrolledUnderElevation: 0,
      ),
    );
  }
}

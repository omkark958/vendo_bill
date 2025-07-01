// lib/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'package:vendo_bill/core/theme/colors/app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.lightPrimary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    cardColor: AppColors.lightSurface,
    dividerColor: AppColors.lightDivider,
    disabledColor: AppColors.lightDisabled,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.lightOnBackground),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.lightPrimary,
      secondary: AppColors.lightSecondary,
      background: AppColors.lightBackground,
      surface: AppColors.lightSurface,
      error: AppColors.lightError,
      onPrimary: AppColors.lightOnPrimary,
      onSecondary: AppColors.lightOnSecondary,
      onBackground: AppColors.lightOnBackground,
      onSurface: AppColors.lightOnSurface,
      onError: Colors.white,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.darkPrimary,
    scaffoldBackgroundColor: AppColors.darkBackground,
    cardColor: AppColors.darkSurface,
    dividerColor: AppColors.darkDivider,
    disabledColor: AppColors.darkDisabled,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.darkOnBackground),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.darkPrimary,
      secondary: AppColors.darkSecondary,
      background: AppColors.darkBackground,
      surface: AppColors.darkSurface,
      error: AppColors.darkError,
      onPrimary: AppColors.darkOnPrimary,
      onSecondary: AppColors.darkOnSecondary,
      onBackground: AppColors.darkOnBackground,
      onSurface: AppColors.darkOnSurface,
      onError: Colors.black,
    ),
  );
}

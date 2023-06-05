import 'package:flutter/material.dart';
import 'package:movies_app/src/style/colors.dart';

final darkTheme = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: darkScaffoldBackground,
    colorScheme: darkColorScheme,
    appBarTheme: const AppBarTheme(backgroundColor: darkAppBarBackground),
    iconTheme: const IconThemeData(color: darkTextColor),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
          color: darkTextColor, fontSize: 14, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          color: darkTextColor, fontSize: 16, fontWeight: FontWeight.bold),
      headlineLarge: TextStyle(
          color: darkTextColor, fontSize: 18, fontWeight: FontWeight.bold),
      bodySmall: TextStyle(
          color: darkTextColor, fontSize: 8, fontWeight: FontWeight.w500),
      bodyMedium: TextStyle(
          color: darkTextColor, fontSize: 12, fontWeight: FontWeight.w500),
      bodyLarge: TextStyle(
          color: darkTextColor, fontSize: 14, fontWeight: FontWeight.w500),
    ));

final lightTheme = ThemeData(
  primaryColor: primaryColor,
  brightness: Brightness.light,
  scaffoldBackgroundColor: scaffoldBackground,
  colorScheme: lightColorScheme,
  appBarTheme: const AppBarTheme(backgroundColor: lightAppBarBackground),
  iconTheme: const IconThemeData(color: lightTextColor),
  textTheme: const TextTheme(
    headlineSmall: TextStyle(
        color: lightTextColor, fontSize: 14, fontWeight: FontWeight.bold),
    headlineMedium: TextStyle(
        color: lightTextColor, fontSize: 16, fontWeight: FontWeight.bold),
    headlineLarge: TextStyle(
        color: lightTextColor, fontSize: 18, fontWeight: FontWeight.bold),
    bodySmall: TextStyle(
        color: lightTextColor, fontSize: 8, fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(
        color: lightTextColor, fontSize: 12, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(
        color: lightTextColor, fontSize: 14, fontWeight: FontWeight.w500),
  ),
);

ColorScheme get darkColorScheme {
  return const ColorScheme(
    brightness: Brightness.dark,
    primary: primaryColor,
    onPrimary: Color(0xFFFFFFFF),
    secondary: darkSecondary,
    onSecondary: darkOnSecondary,
    error: Color(0xFFF32424),
    onError: Color(0xFFF32424),
    background: darkScaffoldBackground,
    onBackground: Color(0xFF505050),
    surface: primaryColor,
    onSurface: primaryColor,
  );
}

ColorScheme get lightColorScheme {
  return const ColorScheme(
    brightness: Brightness.light,
    primary: primaryColor,
    onPrimary: Color(0xFFFFFFFF),
    secondary: lightSecondary,
    onSecondary: lightOnSecondary,
    error: Color(0xFFF32424),
    onError: Color(0xFFF32424),
    background: scaffoldBackground,
    onBackground: Color(0xFF505050),
    surface: primaryColor,
    onSurface: primaryColor,
  );
}

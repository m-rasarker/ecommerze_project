import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static ThemeData get lightThemeData => ThemeData(
      colorSchemeSeed: AppColors.themeColor,
      scaffoldBackgroundColor: Colors.white,
      filledButtonTheme: _filledButtonThemeData,
      elevatedButtonTheme: _elevateddButtonThemeData,
      inputDecorationTheme: _inputDecorationTheme,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold
        ),
        titleMedium: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold
        ),
      ),
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w500
          )
      )
  );

  static ThemeData get darkThemeData => ThemeData(
    colorSchemeSeed: AppColors.themeColor,
    brightness: Brightness.dark,
    filledButtonTheme: _filledButtonThemeData,
    elevatedButtonTheme: _elevateddButtonThemeData,
    inputDecorationTheme: _inputDecorationTheme,
  );

  static FilledButtonThemeData get _filledButtonThemeData =>
      FilledButtonThemeData(
        style: FilledButton.styleFrom(
          fixedSize: Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.symmetric(vertical: 12),
          textStyle: TextStyle(fontSize: 16, color: Colors.white),
          backgroundColor: AppColors.themeColor,
        ),
      );
  static ElevatedButtonThemeData get _elevateddButtonThemeData =>
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12),
          textStyle: const TextStyle(fontSize: 16, color: Colors.white),
          backgroundColor: AppColors.themeColor,
        ),
      );

  static InputDecorationTheme get _inputDecorationTheme => InputDecorationTheme(
    contentPadding: EdgeInsets.symmetric(horizontal: 16),
    hintStyle: const TextStyle(
        fontWeight: FontWeight.w300
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.themeColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.themeColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.themeColor),
    ),
  );
}





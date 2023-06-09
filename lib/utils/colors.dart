import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0XFF1F2229);
  static const Color background2 = Color(0XFF2E303C);
  static const Color backgroundButton = Color(0XFF373945);
  static const Color backgroundButton2 = Color(0XFF4B4D59);
  static const Color yellow = Color(0XFFFAE800);
  static const Color gray = Color(0XFFBEC2C6);
  static const Color white = Color(0XFFFBFBFB);

  static final theme = ThemeData(
    colorScheme: ColorScheme.fromSwatch(
      primarySwatch: Colors.deepPurple,
      backgroundColor: AppColors.background,
      cardColor: AppColors.background2,
      errorColor: Colors.red,
    ).copyWith(
      primary: Colors.deepPurple,
    ),
    appBarTheme: const AppBarTheme(
      color: AppColors.background2,
      foregroundColor: AppColors.yellow,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: AppColors.yellow,
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: AppColors.background,
    ),
  );
}

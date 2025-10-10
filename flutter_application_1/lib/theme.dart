import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF7F5539);
  static const Color brownMain = Color(0xFF7F5539);
  static const Color brownDark = Color(0xFF4E342E);
  static const Color brownSoft = Color(0xFFDDB892);
  static const Color cream = Color(0xFFFAF3E0);
  static const Color whiteSoft = Color(0xFFFDFBF7);
  static const Color linkBlue = Color(0xFF1565C0);
  static const Color lightGrey = Color(0xFFE6E3DA);
}

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.brownMain,
    scaffoldBackgroundColor: AppColors.cream,
    brightness: Brightness.light,
    splashColor: AppColors.brownSoft.withOpacity(0.12),
    highlightColor: AppColors.brownSoft.withOpacity(0.08),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primary,
      secondary: AppColors.brownSoft,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.whiteSoft,
      elevation: 1,
      centerTitle: true,
      iconTheme: IconThemeData(color: AppColors.brownDark),
      titleTextStyle: TextStyle(
        color: AppColors.brownDark,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteSoft,
      selectedItemColor: AppColors.brownDark,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
    ),

    // ✅ FIXED - gunakan TabBarThemeData, bukan TabBarTheme
    tabBarTheme: const TabBarThemeData(
      labelColor: AppColors.brownDark,
      unselectedLabelColor: Colors.grey,
      indicatorColor: AppColors.brownSoft,
      labelStyle: TextStyle(fontWeight: FontWeight.bold),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brownMain,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 18),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        elevation: 0,
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.cream,
        foregroundColor: AppColors.linkBlue,
        side: BorderSide(color: AppColors.brownSoft.withOpacity(0.75)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.whiteSoft,
      contentPadding:
          const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      hintStyle: const TextStyle(color: Colors.grey),
      labelStyle: const TextStyle(color: AppColors.brownDark),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.lightGrey),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
        borderSide: BorderSide(
          color: AppColors.brownSoft,
          width: 1.6,
        ),
      ),
    ),

    // ✅ FIXED - gunakan CardThemeData, bukan CardTheme
    cardTheme: const CardThemeData(
      color: AppColors.whiteSoft,
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
        color: AppColors.brownDark,
      ),
      titleLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.brownDark,
      ),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.brownMain,
      foregroundColor: Colors.white,
    ),

    dividerColor: AppColors.lightGrey,
    iconTheme: const IconThemeData(color: AppColors.brownDark),

    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.brownMain.withOpacity(0.95),
      contentTextStyle: const TextStyle(color: AppColors.whiteSoft),
    ),
  );
}

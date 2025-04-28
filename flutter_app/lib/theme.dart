import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeChanger extends ChangeNotifier {
  ThemeMode _thememode = ThemeMode.light;
  ThemeMode get themeMode => _thememode;
  ThemeData _data = ThemeData.light();
  ThemeData get data => _data;

  ThemeData check() {
    Brightness brightness = PlatformDispatcher.instance.platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    _thememode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    _data = isDarkMode ? ThemeData.dark() : ThemeData.light();
    // notifyListeners();
    return _data;
  }

  void toggle(bool isDark) {
    _thememode = isDark ? ThemeMode.dark : ThemeMode.light;
    _data = isDark ? ThemeData.dark() : ThemeData.light();

    notifyListeners();
  }
}

final allThemeData = ThemeData(
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.grey,
    selectedItemColor: Colors.white,
    unselectedItemColor: Colors.black,
    selectedLabelStyle: TextStyle(color: Colors.white),
    unselectedLabelStyle: TextStyle(color: Colors.black),
    selectedIconTheme: IconThemeData(color: Colors.white),
    unselectedIconTheme: IconThemeData(color: Colors.black),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white12,
    hintStyle: TextStyle(color: Colors.grey),
    labelStyle: TextStyle(color: Colors.white70),
    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
    ),
    errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: Colors.grey),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.grey,
      foregroundColor: Colors.white,
      side: const BorderSide(color: Colors.grey),
    ),
  ),
  fontFamily: GoogleFonts.montserrat().fontFamily,
  useMaterial3: true,

  primarySwatch: Colors.grey,
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    displayMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    bodySmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w800),
    titleSmall: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    labelMedium: TextStyle(color: Colors.white),
    labelSmall: TextStyle(color: Colors.white),
  ),
);
final appbartheme = AppBarTheme(
  backgroundColor: Colors.white12,

  foregroundColor: Colors.white12,
  titleTextStyle: TextStyle(color: Colors.white),
);

final elevationtheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.grey,
    foregroundColor: Colors.white,
  ),
);

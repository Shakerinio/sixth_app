import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;

  bool get isDarkMode => themeMode == ThemeMode.dark;
}

class MyThemes {
  static final darkTheme = ThemeData(
    primaryColor: Colors.black,
    primarySwatch: Colors.grey,
    backgroundColor: Colors.grey.shade900,
    accentColor: Colors.black,
    accentColorBrightness: Brightness.dark,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.white, opacity: 0.8),
  );

  static final lightTheme = ThemeData(
    primaryColor: Colors.white,
    primarySwatch: Colors.pink,
    backgroundColor: Colors.pink,
    accentColor: Colors.deepPurple,
    accentColorBrightness: Brightness.light,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.black, opacity: 0.8),
  );
}

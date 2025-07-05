import 'package:flutter/material.dart';
import 'package:path_finder/util/shared_pref_helper.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get currentTheme => _themeMode;

  ThemeProvider() {
    _loadTheme();
  }

  void _loadTheme() async {
    bool isDark = await SharedPrefHelper.getThemeMode();
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void toggleTheme() async {
    bool isCurrentlyDark = _themeMode == ThemeMode.dark;
    _themeMode = isCurrentlyDark ? ThemeMode.light : ThemeMode.dark;
    await SharedPrefHelper.saveThemeMode(!isCurrentlyDark);
    notifyListeners();
  }
}

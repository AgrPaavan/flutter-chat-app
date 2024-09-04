import 'package:chat_app/themes/dark_mode.dart';
import 'package:chat_app/themes/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  late ThemeData _themeData;
  late bool isDefaultDarkMode;

  ThemeProvider() {
    var brightness =
        SchedulerBinding.instance.platformDispatcher.platformBrightness;
    isDefaultDarkMode = brightness == Brightness.dark;
    _themeData = isDefaultDarkMode ? darkMode : lightMode;
  }

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}

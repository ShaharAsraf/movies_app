import 'package:flutter/material.dart';
import 'package:movies_app/src/style/themes.dart';
import 'package:movies_app/src/utils/prefs.dart';

UIBloc uiBloc = UIBloc.instance;

class UIBloc {
  static UIBloc? _instance;

  static UIBloc get instance {
    _instance ??= UIBloc._();
    _instance?.init();
    return _instance!;
  }

  UIBloc._();

  final ValueNotifier<ThemeData?> _theme = ValueNotifier<ThemeData?>(null);
  final ValueNotifier<bool> _isDarkMode = ValueNotifier<bool>(true);

  ValueNotifier<ThemeData?> get theme => _theme;
  ValueNotifier<bool> get isDarkMode => _isDarkMode;

  void init() {
    switch (Prefs.themeMode) {
      case 'dark':
        setDarkMode();
        break;
      case 'light':
        setLightMode();
        break;
    }
  }

  void setDarkMode() {
    _theme.value = darkTheme;
    _isDarkMode.value = true;
    Prefs.setThemeMode(ThemeMode.dark.name);
  }

  void setLightMode() async {
    _theme.value = lightTheme;
    _isDarkMode.value = false;
    Prefs.setThemeMode(ThemeMode.light.name);
  }

  void onModeChange(bool isDark) {
    if (isDark) {
      setDarkMode();
    } else {
      setLightMode();
    }
  }
}

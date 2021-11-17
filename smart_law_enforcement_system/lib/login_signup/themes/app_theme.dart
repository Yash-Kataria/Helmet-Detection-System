import 'package:flutter/material.dart';

import 'login_signup_design_theme.dart';

enum ThemeKeys { LOGIN_DESIGN }

class ThemeModel {
  static ThemeData getThemeFromKey(ThemeKeys themeKey) {
    switch (themeKey) {
      case ThemeKeys.LOGIN_DESIGN:
        return LoginSignUpDesignTheme.lightThemeData;
      default:
        return LoginSignUpDesignTheme.lightThemeData;
    }
  }
}

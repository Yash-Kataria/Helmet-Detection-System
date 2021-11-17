import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:smart_law_enforcement_system/login_signup/themes/login_signup_design_theme.dart';

class CurrentTheme {
  final String name;
  final ThemeData data;

  const CurrentTheme(this.name, this.data);
}

class ThemeBloc {
  final Stream<ThemeData> themeDataStream;
  final Sink<CurrentTheme> selectedTheme;

  factory ThemeBloc() {
    final selectedTheme = PublishSubject<CurrentTheme>();
    final themeDataStream = selectedTheme.distinct().map((theme) => theme.data);
    return ThemeBloc._(themeDataStream, selectedTheme);
  }

  const ThemeBloc._(this.themeDataStream, this.selectedTheme);

  CurrentTheme initialTheme()
  {
    return CurrentTheme('initial', LoginSignUpDesignTheme.lightThemeData);
  }
}

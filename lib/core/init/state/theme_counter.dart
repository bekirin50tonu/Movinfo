import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:movinfo/core/init/cache/locale_manager.dart';

part 'theme_counter.g.dart';

class Counter = _Counter with _$Counter;

abstract class _Counter with Store {
  static bool isDarkMode = LocaleManager.getBool('darkTheme') ?? false;
  static ThemeMode themeMode =
      isDarkMode == true ? ThemeMode.dark : ThemeMode.light;

  @computed
  ThemeMode get getTheme =>
      isDarkMode == true ? ThemeMode.dark : ThemeMode.light;

  @observable
  ThemeMode mode = themeMode;

  @observable
  bool isDark = isDarkMode;
}

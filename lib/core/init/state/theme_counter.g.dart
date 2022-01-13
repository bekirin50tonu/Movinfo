// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_counter.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Counter on _Counter, Store {
  Computed<ThemeMode>? _$getThemeComputed;

  @override
  ThemeMode get getTheme => (_$getThemeComputed ??=
          Computed<ThemeMode>(() => super.getTheme, name: '_Counter.getTheme'))
      .value;

  final _$modeAtom = Atom(name: '_Counter.mode');

  @override
  ThemeMode get mode {
    _$modeAtom.reportRead();
    return super.mode;
  }

  @override
  set mode(ThemeMode value) {
    _$modeAtom.reportWrite(value, super.mode, () {
      super.mode = value;
    });
  }

  final _$isDarkAtom = Atom(name: '_Counter.isDark');

  @override
  bool get isDark {
    _$isDarkAtom.reportRead();
    return super.isDark;
  }

  @override
  set isDark(bool value) {
    _$isDarkAtom.reportWrite(value, super.isDark, () {
      super.isDark = value;
    });
  }

  @override
  String toString() {
    return '''
mode: ${mode},
isDark: ${isDark},
getTheme: ${getTheme}
    ''';
  }
}

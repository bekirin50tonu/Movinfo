import 'package:flutter/widgets.dart';
import 'package:movinfo/core/constants/app_constants.dart';
import 'package:movinfo/core/init/cache/locale_manager.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  String? getLangKey(String value) =>
      AppConstants.DATA_LANGUAGES
          .where((element) => element.containsValue(value))
          .first['shotcut'] ??
      "tr";
  String? getCountryKey(String value) =>
      AppConstants.DATA_COUNTRIES
          .where((element) => element.containsValue(value))
          .first['shotcut'] ??
      "TR";
}

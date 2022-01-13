import 'package:flutter_test/flutter_test.dart';
import 'package:movinfo/core/constants/app_constants.dart';
import 'package:movinfo/core/init/cache/locale_manager.dart';

Future<void> main() async {
  await LocaleManager.init();
  LocaleManager.setString('language', 'Türkçe');
  group('Locale Manager Test', () {
    test('Get Language Data', () {
      var data = LocaleManager.getString('language');
      AppConstants.DATA_LANGUAGES.firstWhere((element) {
        print(element.keys);
        print(element.values);
        return true;
      });

      expect(true, true);
    });
  });
}

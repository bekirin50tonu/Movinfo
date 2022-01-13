import 'package:flutter_test/flutter_test.dart';
import 'package:movinfo/core/constants/app_constants.dart';

void main() {
  group('Sorting Test', () {
    test('Alphabetical Sort', () async {
      var sortField = 'english_name';
      var data = AppConstants.DATA_COUNTRIES;
      data.forEach((element) {
        print(element);
      });

      expect(data, isNotEmpty);
    });
  });
}

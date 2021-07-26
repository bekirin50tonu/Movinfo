import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movinfo/core/init/network/network_manager.dart';
import 'package:movinfo/core/view/movie/model/movie_model.dart';
import 'package:movinfo/core/view/search/model/keyword_model.dart';
import 'package:movinfo/core/view/tv/model/tv_model.dart';

import 'package:movinfo/main.dart';

void main() {
  group('Network Tests', () {
    test('Get Seatch Data', () async {
      final response = await NetworkManager.instance.getData<KeywordModel>(
          '/search/keyword', KeywordModel(), {'query': 'mortal', 'page': 1});

      expect(response, true);
    });

    test('Get Movie Detail Data', () async {
      final response = await NetworkManager.instance
          .getData<MovieModel>('/movie/now_playing', MovieModel(), {});

      expect(response, true);
    });
    test('Get Movie Data', () async {
      final response = await NetworkManager.instance
          .getData<MovieModel>('/movie/now_playing', MovieModel(), {});

      expect(response, true);
    });
    test('Get Tv Data', () async {
      final response = await NetworkManager.instance
          .getData<TVModel>('/tv/now_playing', TVModel(), {});

      expect(response, true);
    });
  });
}

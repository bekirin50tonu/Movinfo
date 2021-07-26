import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:movinfo/core/base/base_model.dart';
import 'package:movinfo/core/constants/network_constants.dart';

class NetworkManager {
  static NetworkManager _instance = NetworkManager._init();
  static NetworkManager get instance => _instance;
  late Dio _dio;
  NetworkManager._init() {
    final baseOption = BaseOptions(baseUrl: NetworkConstants.BASE_URL);
    _dio = Dio(baseOption);
  }

  Future getData<T extends BaseModel>(
      String path, T model, Map<String, dynamic> query) async {
    Map<String, dynamic> queryParameters = Map();
    queryParameters.addAll(NetworkConstants.QUERY_PARAMETERS);
    queryParameters.addAll(query);
    Response response;
    try {
      response = await _dio.get(path, queryParameters: queryParameters);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    switch (response.statusCode) {
      case HttpStatus.ok:
        final data = response.data;
        if (data is List) {
          return data.map((e) => model.fromJson(e)).toList();
        } else if (data is Map<String, dynamic>) {
          return model.fromJson(data);
        }
        return data;
      default:
        print("hata");
    }
  }

  Future postData<T extends BaseModel>(
      String path, T model, Map<String, dynamic>? headers, String body) async {
    _dio.options.headers = headers;
    String url = NetworkConstants.BASE_URL + path;
    /* final response = await _dio.get(path); */
    Response response;
    try {
      response = await _dio.post(url, data: body);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    switch (response.statusCode) {
      case HttpStatus.ok:
        final data = response.data;
        if (data is List) {
          return data.map((e) => model.fromJson(e)).toList();
        } else if (data is Map<String, Object>) {
          return model.fromJson(data);
        }
        return data;
      default:
        print("hata");
    }
  }
}

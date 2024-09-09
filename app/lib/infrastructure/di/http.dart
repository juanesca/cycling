import 'package:app/core/utils/preferences.constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CHttp {
  CHttp._internal();

  static final CHttp _instance = CHttp._internal();

  factory CHttp() => _instance;

  static CHttp get instance => _instance;

  late Dio _dio;

  init() async {
    _createDio();
  }

  _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(Prefs.token);
  }

  Dio get client => _dio;

  _createDio() async {
    final token = await _getToken();
    _dio = Dio(BaseOptions(baseUrl: dotenv.env['SERVER']!))
      ..interceptors.addAll([
        InterceptorsWrapper(
          onRequest: (options, handler) {
            if (token != null) {
              options.headers.addAll({'x-auth-token': token});
            }
          },
        ),
        LogInterceptor(
          logPrint: (object) => debugPrint(object.toString()),
        )
      ]);
  }
}

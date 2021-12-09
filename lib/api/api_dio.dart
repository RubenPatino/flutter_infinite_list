import 'dart:io';

import 'package:aflore_flutter/api/custom_interceptors.dart';
import 'package:aflore_flutter/api/path_dio.dart';
import 'package:aflore_flutter/api/url_constant.dart';
import 'package:aflore_flutter/db/shared_preferences/preference_connector.dart';
import 'package:aflore_flutter/models/network/model_movie_popular.dart';
import 'package:aflore_flutter/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiDio {
  ApiDio() {
    _dio = Dio();
    _dio.interceptors.add(CustomInterceptors());
  }

  late Dio _dio;

  Future<ModelMoviePopular?> getMoviePopular(int page) async {
    try {
      final _parameters = {
        'api_key': '0d677b16a44d2b5a79edf325bc1ee9b7',
        'language': 'es-ES',
        'page': '$page'
      };

      final _url = PathDio.getUrl(
          path: UrlConstant.pathPopular, parameters: _parameters);

      final checkConnectivity = await Helper.checkConnectivity();

      if (checkConnectivity) {
        final resp = await _dio.getUri(_url);

        if (resp.statusCode == HttpStatus.ok) {
          final data = resp.data;

          if (data != null) {
            return ModelMoviePopular.fromJson(resp.data);
          } else {
            return null;
          }
        } else {
          return null;
        }
      } else {
        final model = await SharedPreferencesConnector().getModelMovie();

        if (model != null) {
          if(page==1) {
            return model;
          }else{
            return null;
          }
        } else {
          return null;
        }
      }
    } catch (e) {
      Logger().d(e);
      return null;
    }
  }
}

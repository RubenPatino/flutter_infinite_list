import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class CustomInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('REQUEST ${jsonEncode(options.method)} => '
        'PATH: ${options.path}');
    log('HEADERS ${jsonEncode(options.headers)}');
    log('REQUEST ${jsonEncode(options.data)}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('RESPONSE ${response.statusCode} => '
        'PATH: ${response.requestOptions.path}');
    log('RESPONSE ${jsonEncode(response.data)}');
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log('ERROR ${err.response?.statusCode} => '
        'PATH: ${err.requestOptions.path}');
    return super.onError(err, handler);
  }
}

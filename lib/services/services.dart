library services;

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../src/models/models.dart';

part 'api/gpt_api.dart';
part 'servicesg.dart';

class Api {
  String? strng;
  Api({this.strng = ""}) {
    _Strng = strng!;
  }
  static const _baseUrl = 'https://api.openai.com/v1';
  static String _Strng =
      'sk-5it3z53J57YFWWKP2Bv1T3BlbkFJEH3UMUR5I0Mtsu0fJex'; //0
  static const _timeOut = Duration(milliseconds: 50000);

  final client = Dio(BaseOptions(
    baseUrl: _baseUrl,
    headers: {"Content-Type": "application/json"},
    connectTimeout: _timeOut,
    receiveTimeout: _timeOut,
  ))
    ..interceptors.add(AuthInterceptor());
}

class AuthInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(options, handler) {
    options.headers['Authorization'] = 'Bearer ${Api._Strng}';
    return handler.next(options);
  }
}

 // static const _apiKey = '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';
  // static const _apiKey = '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';
  // static const _apiKey = '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';
  // static const _apiKey = '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';
      // "sk-EO07XgN5UMMbsxVbUsejT3BlbkFJKgALJTl757EsJPAlfWk"; // r
  // "sk-5Y4e08x3RihDWJuV4nRET3BlbkFJllgyJkVV6Jg6frbNcBz"; // k
  // static const _apiKey =
  //     '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'; // paid api from ipa app
  // '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'; // free api key from viral shorts
  // var _apiKey = GetKey().apiKey; ///// remaining to attach firebase only
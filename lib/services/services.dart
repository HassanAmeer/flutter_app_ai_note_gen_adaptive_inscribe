library services;

// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
import 'package:retrofit/retrofit.dart';

import '../src/models/models.dart';
import '../vm/getkeyVm.dart';

part 'api/gpt_api.dart';
part 'servicesg.dart';

class Api {
  static const _baseUrl = 'https://api.openai.com/v1';
  // static const _apiKey = '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';
  // static const _apiKey = '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';
  // static const _apiKey = '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';
  // static const _apiKey = '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';
  static const _apiKey =
      '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'; // free api key from viral shorts
  // var _apiKey = GetKey().apiKey; ///// remaining to attach firebase only

  static const _timeOut = Duration(seconds: 150);

  static final client = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      headers: {"Content-Type": "application/json"},
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
    ),
  )..interceptors.add(AuthInterceptor());
}

class AuthInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(options, handler) {
    options.headers['Authorization'] = 'Bearer ${Api._apiKey}';
    return handler.next(options);
  }
}

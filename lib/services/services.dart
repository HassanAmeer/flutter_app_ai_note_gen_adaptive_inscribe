library services;

// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:device_info_plus/device_info_plus.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
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
  // static const _apiKey =
  //     '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'; // paid api from ipa app
  // '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'; // free api key from viral shorts
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
  var _apiKey = GetKey().apiKey ??
      "sk-EO07XgN5UMMbsxVbUsejT3BlbkFJKgALJTl757EsJPAlfWk"; // r
  // "sk-5Y4e08x3RihDWJuV4nRET3BlbkFJllgyJkVV6Jg6frbNcBz"; // k
  @override
  void onRequest(options, handler) {
    log("👉 _apiKey $_apiKey");
    log("👉 GetKey().apiKey  ${GetKey().apiKey}");

    // options.headers['Authorization'] = 'Bearer ${_apiKey}';
    // return handler.next(options);
  }
}

class AiC {
  Future<String?> getResponceF(String promptText, context) async {
    // var apiK = await GetKey().apiKey;
    var apiK = await Provider.of<GetKey>(context, listen: false).apiKey;
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiK',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": "$promptText"},
          ],
        }),
      );

      // if (response.statusCode == 200) {
      var resp = json.decode(response.body);
      debugPrint("👉 resp: $resp");

      return resp["choices"][0]["message"]['content'];
      // } else {
      //   throw Exception('Failed to get response');
      // }
    } catch (e) {
      print("when get AIC Response $e ");
      return null;
    }
  }
}

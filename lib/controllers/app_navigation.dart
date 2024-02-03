import 'package:flutter/material.dart';

abstract class AppNavigation {
  static Future<dynamic> to(
    BuildContext context,
    Widget page,
  ) async {
    return await Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
  }

  static dynamic pop(BuildContext context, [dynamic data]) =>
      Navigator.of(context).pop(data);

  static Future<dynamic> ofAll(
    BuildContext context,
    Widget page,
  ) async {
    return await Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }
}

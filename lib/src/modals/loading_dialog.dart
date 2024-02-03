import 'package:flutter/material.dart';

$showLoadingDialog(BuildContext context, String title) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return AlertDialog(
        content: Column(mainAxisSize: MainAxisSize.min, children: [
          // const CircularProgressIndicator(color: ),
          const CircularProgressIndicator(),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ]),
      );
    },
  );
}

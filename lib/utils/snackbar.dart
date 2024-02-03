import 'package:flutter/material.dart';

void showSnackbarF(
    {required String? msg, int time = 3, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg!.toString()),
      duration: Duration(seconds: time),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    ),
  );
}

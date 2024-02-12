import 'package:flutter/material.dart';

class NotesVmC with ChangeNotifier {
  String selectedTemplateName = "Choose";
  changeTemplateNameVMF(value) {
    selectedTemplateName = value;
    notifyListeners();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetKey extends ChangeNotifier {
  String _key = "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";

  String get apiKey => _key;

  Future<void> getKeyVmF() async {
    try {
      QuerySnapshot<Map<String, dynamic>> keysSnapshot =
          await FirebaseFirestore.instance.collection("keys").get();

      if (keysSnapshot.docs.isNotEmpty) {
        var keyData = keysSnapshot.docs.first.data();
        _key = keyData['apikey'];
      } else {
        _key = "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";
      }
      notifyListeners();
    } catch (error) {
      debugPrint("💥 Error retrieving key: $error");
      _key = "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";
      notifyListeners();
    }
    debugPrint("👉 apiKey: $_key");
  }
}

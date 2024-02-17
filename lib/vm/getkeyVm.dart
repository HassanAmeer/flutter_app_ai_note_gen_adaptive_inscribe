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

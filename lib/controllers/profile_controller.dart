import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  TextEditingController userName = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController imagePath = TextEditingController();
  TextEditingController email = TextEditingController();

  File? image;
  pickImage(ImageSource source) async {
    // ignore: invalid_use_of_visible_for_testing_member
    await ImagePicker.platform.pickImage(source: source).then(
      (value) {
        if (value != null) {
          image = File(value.path);
          imagePath.text = value.path;
          box.put(
            "profilePic",
            imagePath.text,
          );
          update();
        }
      },
    );
  }

  deleteImage() {
    if (box.isNotEmpty) {
      if (box.get("profilePic") != null) {
        box.delete("profilePic");
        update();
      }
    }
  }

  selectCountry(context) {
    showCountryPicker(
      context: context,
      onSelect: (value) {
        country.text = value.name;
      },
    );
  }

  selectDOB(context) {
    showDatePicker(
      context: context,
      initialDate: DateTime(1950),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    ).then(
      (value) {
        dob.text = "${value!.day}/${value.month}/${value.year}";
      },
    );
  }

  Box box = Hive.box("userData");
  initiaLizeProfileData() {
    if (box.isNotEmpty) {
      userName.text = box.get("userName") ?? "";
      country.text = box.get("countryName") ?? "";
      dob.text = box.get("dob") ?? "";
      imagePath.text = box.get("profilePic") ?? "";
      email.text = box.get("email") ?? "";
    } else {}
  }

  @override
  void onInit() {
    initiaLizeProfileData();
    super.onInit();
  }
}

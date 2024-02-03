import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:adaptive_inscribe/home_screen.dart';
import '../controllers/app_navigation.dart';
import '../controllers/profile_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final Box _box = Hive.box("userData");

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF00BCE3),
          centerTitle: true,
          title: const Text("Edit Profile"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GetBuilder<ProfileController>(
                    init: ProfileController(),
                    builder: (controller) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 110,
                            width: 110,
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Color(0xFF00BCE3),
                                  backgroundImage: _box.get("profilePic") ==
                                          null
                                      ? const AssetImage("assets/profile.png")
                                      : FileImage(
                                          File(
                                            _box.get("profilePic"),
                                          ),
                                        ) as ImageProvider,
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    child: IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return Container(
                                              height: 150,
                                              color: const Color(0xFF00BCE3),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 60,
                                                    width: double.maxFinite,
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                          child: ListTile(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                              controller.pickImage(
                                                                  ImageSource
                                                                      .camera);
                                                            },
                                                            leading: const Icon(
                                                              Icons.camera,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            title: const Text(
                                                              "Camera",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: ListTile(
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                              controller
                                                                  .deleteImage();
                                                            },
                                                            leading: const Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                            title: const Text(
                                                              "Delete Image",
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  ListTile(
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                      controller.pickImage(
                                                          ImageSource.gallery);
                                                    },
                                                    leading: const Icon(
                                                      Icons
                                                          .photo_album_outlined,
                                                      color: Colors.white,
                                                    ),
                                                    title: const Text(
                                                      "Gallery",
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt_outlined,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: controller.userName,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              fillColor: Colors.grey.withOpacity(0.6),
                              filled: true,
                              hintText: "UserName",
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: controller.country,
                            readOnly: true,
                            onTap: () => controller.selectCountry(context),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              fillColor: Colors.grey.withOpacity(0.6),
                              filled: true,
                              hintText: "Country",
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            readOnly: true,
                            controller: controller.dob,
                            onTap: () => controller.selectDOB(context),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.transparent,
                                ),
                              ),
                              fillColor: Colors.grey.withOpacity(0.6),
                              filled: true,
                              hintText: "Date of Birth (Optional)",
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Container(
                            width: 250,
                            height: 45,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith(
                                  (states) => const Color(0xFF00BCE3),
                                ),
                              ),
                              onPressed: () async {
                                _box.put(
                                  "userName",
                                  controller.userName.text,
                                );
                                _box.put(
                                  "countryName",
                                  controller.country.text,
                                );
                                _box.put(
                                  "dob",
                                  controller.dob.text,
                                );
                                _box.put(
                                  "email",
                                  controller.email.text,
                                );
                                AppNavigation.ofAll(
                                  context,
                                  HomeScreen(),
                                );
                              },
                              child: const Text(
                                "Update",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

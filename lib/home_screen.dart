import 'dart:convert';
import 'dart:math';
import 'package:adaptive_inscribe/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adaptive_inscribe/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_inscribe/models/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clipboard/clipboard.dart';

import 'package:http/http.dart' as http;
import 'auth/login.dart';
import 'auth/profile_view.dart';
import 'boxes/boxes.dart';
import 'controllers/app_navigation.dart';
import 'services/services.dart';
import 'src/modals/loading_dialog.dart';
import 'src/models/models.dart';
import 'templates.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController generatedNoteTitleContr = TextEditingController();
  TextEditingController generatedDetailsController = TextEditingController();
  /////////////
  TextEditingController notetitleController = TextEditingController();
  TextEditingController sampleController = TextEditingController(text: " ");
  TextEditingController clientNameController = TextEditingController(text: " ");
  TextEditingController dateController = TextEditingController(text: " ");
  TextEditingController locationController = TextEditingController(text: " ");
  TextEditingController reportController = TextEditingController(text: " ");
  TextEditingController othersController = TextEditingController(text: " ");

  FocusNode _titleController = FocusNode();
  FocusNode _descriptionController = FocusNode();

  List<Color> colors = [
    Colors.purple,
    Colors.black38,
    Colors.green,
    Colors.orangeAccent,
    Colors.blue,
    Colors.red,
    Colors.cyanAccent,
  ];

  Random random = Random(6);

  Box box = Hive.box("userData");
  @override
  void initState() {
    getTemplateDataF();
    if (box.isEmpty) {
      box.put("profileData", {
        "userName": "Any",
        "countryName": "United Kingdom",
        "dob": "12/2023",
        "email": "abc@gmail.com",
      });
    }
    super.initState();
  }

  String dropdownvalue = 'Template';

  // List of items in our dropdown menu
  // var items = [
  //   'Template',
  //   'Shop Template',
  //   'Template 2',
  //   'Template 3',
  //   'Template 4',
  //   'Template 5',
  // ];
  List templates = [];

  getTemplateDataF() async {
    // await Hive.openBox("templates");
    var box = Hive.box('templates');
    var data = box.get('templateskey') ?? [];
    // box.clear();
    if (data != null) {
      setState(() {
        templates = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF00BCE3),
        leading: IconButton(
          onPressed: () {
            showMenu(
              color: Color(0xFF00BCE3),
              context: context,
              position: RelativeRect.fromLTRB(0, 88, 0, 0),
              items: [
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    shape: Border(
                      bottom: BorderSide(),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      AppNavigation.to(
                        context,
                        ProfileView(),
                      );
                    },
                    leading: Icon(
                      Icons.person,
                    ),
                    title: Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    shape: Border(
                      bottom: BorderSide(),
                    ),
                    leading: Icon(Icons.last_page),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TemplatesPage(),
                        ),
                      );
                    },
                    title: Text('Templates'),
                    // leading:
                    //     IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    // title: DropdownButton(
                    //   // Initial Value
                    //   value: dropdownvalue,

                    //   // Down Arrow Icon
                    //   icon: const Icon(Icons.keyboard_arrow_down),

                    //   // Array list of items
                    //   // items: items.map((String items) {
                    //   //   return DropdownMenuItem(
                    //   //     value: items,
                    //   //     child: Text(items),
                    //   //   );
                    //   // }).toList(),
                    //   // After selecting the desired option,it will
                    //   // change button value to selected value
                    //   onChanged: (String? newValue) {
                    //     setState(() {
                    //       dropdownvalue = newValue!;
                    //     });
                    //   },
                    // ),
                  ),
                ),
                PopupMenuItem(
                  padding: EdgeInsets.zero,
                  child: ListTile(
                    onTap: () {
                      auth.signOut().then((value) {
                        Navigator.pushAndRemoveUntil(
                            (context),
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                            (route) => false);
                      }).onError((error, stackTrace) {});
                    },
                    leading: Icon(
                      Icons.power_settings_new_rounded,
                    ),
                    title: Text(
                      "LogOut",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
          icon: Icon(
            Icons.menu,
          ),
        ),
        title: Text(
          'AI Notepad',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<NotesModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          var data = box.values.toList().cast<NotesModel>();
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
                itemCount: box.length,
                reverse: true,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      color: colors[random.nextInt(6)],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      FlutterClipboard.copy(
                                              data[index].title.toString() +
                                                  "\n" +
                                                  ": " +
                                                  data[index]
                                                      .description
                                                      .toString())
                                          .then((value) {
                                        showSnackbarF(
                                            msg: "Copied!", context: context);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.copy_all_outlined,
                                      color: Colors.white,
                                    )),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Share.share(
                                              data[index].title.toString() +
                                                  "\n" +
                                                  data[index]
                                                      .description
                                                      .toString());
                                        },
                                        child: Icon(
                                          Icons.share,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          showCupertinoDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return CupertinoAlertDialog(
                                                  title: const Text(
                                                      'Want to Delete'),
                                                  actions: [
                                                    CupertinoButton(
                                                        onPressed: () {
                                                          delete(data[index]);

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text('Yes',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red))),
                                                    CupertinoButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'No',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .blueGrey
                                                                  .shade300),
                                                        )),
                                                  ],
                                                  insetAnimationCurve:
                                                      Curves.slowMiddle,
                                                  insetAnimationDuration:
                                                      const Duration(
                                                          seconds: 2),
                                                );
                                              });
                                        },
                                        child: Icon(
                                          Icons.delete,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        _editDialog(
                                            data[index],
                                            data[index].title.toString(),
                                            data[index].description.toString());
                                      },
                                      child: Icon(
                                        Icons.edit,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ExpansionTile(
                              title: Text(
                                data[index].title.toString(),
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              subtitle: Text(
                                data[index]
                                            .description
                                            .trim()
                                            .toString()
                                            .length >=
                                        35
                                    ? data[index]
                                            .description
                                            .trim()
                                            .toString()
                                            .substring(0, 34) +
                                        ".."
                                    : data[index].description.toString(),
                                style: TextStyle(color: Colors.white),
                              ),
                              children: [
                                Text(
                                  data[index].description.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getTemplateDataF();
          _showMyDialog();
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  void delete(NotesModel notesModel) async {
    await notesModel.delete();
  }

  Future<void> _editDialog(
      NotesModel notesModel, String title, String description) async {
    generatedNoteTitleContr.text = title;
    generatedDetailsController.text = description;
    showSnackbarF(msg: "$description", context: context);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit NOTES'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: generatedNoteTitleContr,
                    decoration: const InputDecoration(
                        hintText: 'Enter title', border: OutlineInputBorder()),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: generatedDetailsController,
                    minLines: 1,
                    maxLines: 5,
                    decoration: const InputDecoration(
                        hintText: 'Enter description',
                        border: OutlineInputBorder()),
                  )
                ],
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    notesModel.title = generatedNoteTitleContr.text.toString();
                    notesModel.description =
                        generatedDetailsController.text.toString();

                    notesModel.save();
                    generatedDetailsController.clear();
                    generatedNoteTitleContr.clear();

                    // box.

                    Navigator.pop(context);
                  },
                  child: Text('Edit')),
            ],
          );
        });
  }

  var templateValueName = 'Select a template';
  updateSelectTemlateHintF(value) {
    templateValueName = value;
    setState(() {});
  }

  TextEditingController hintController = TextEditingController();
  Future<void> _showMyDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Create New Note'),
            content: SingleChildScrollView(
                child: Column(children: [
              TextFormField(
                  controller: notetitleController,
                  decoration: const InputDecoration(
                      hintText: 'Note title', border: OutlineInputBorder())),
              const SizedBox(height: 5),
              DropdownButton(
                  // value: selectTemplate ?? "Select Template",
                  items: templates
                      .map<DropdownMenuItem<dynamic>>((dynamic template) {
                    return DropdownMenuItem<dynamic>(
                        value: template,
                        child: Text(template['name'] ?? 'Template'));
                  }).toList(),
                  onChanged: (dynamic selectedTemplate) {
                    // print('Selected template: $selectedTemplate');
                    // notetitleController.text =
                    //     selectedTemplate['name'] ?? '';
                    // selectTemplate = selectedTemplate ?? 'Select Template';
                    hintController.text = selectedTemplate['name'] ?? '';
                    sampleController.text = selectedTemplate['sample'] ?? '';
                    templateValueName = selectedTemplate['name'] ?? '';
                    clientNameController.text =
                        selectedTemplate['clientName'] ?? '';
                    dateController.text = selectedTemplate['date'] ?? '';
                    locationController.text =
                        selectedTemplate['location'] ?? '';
                    reportController.text = selectedTemplate['report'] ?? '';
                    othersController.text = selectedTemplate['others'] ?? '';
                    updateSelectTemlateHintF(
                        selectedTemplate['name'] ?? 'Select Template');
                    // report
                    setState(() {});
                  },
                  hint: Text(templateValueName.toString())),
              // hint: SizedBox(
              //   height: 20,
              //   child: Expanded(
              //     child: TextField(
              //       enabled: false,
              //       controller: hintController,
              //       decoration: InputDecoration(border: InputBorder.none),
              //     ),
              //   ),
              // )),
              const SizedBox(height: 10),
              // Text(
              //   templateValueName,
              //   style: Theme.of(context)
              //       .textTheme
              //       .titleMedium!
              //       .copyWith(color: Colors.blueAccent),
              // ),
              Text("Details",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              TextFormField(
                  controller: sampleController,
                  decoration: const InputDecoration(
                      hintText: 'Sample', border: OutlineInputBorder())),
              const SizedBox(height: 5),
              TextFormField(
                  controller: clientNameController,
                  decoration: const InputDecoration(
                      hintText: 'Name', border: OutlineInputBorder())),
              const SizedBox(height: 5),
              TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(
                      hintText: 'Date', border: OutlineInputBorder())),
              const SizedBox(height: 5),
              TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(
                      hintText: 'Location', border: OutlineInputBorder())),
              const SizedBox(height: 5),
              TextFormField(
                  controller: othersController,
                  decoration: const InputDecoration(
                      hintText: 'Others', border: OutlineInputBorder())),
              TextFormField(
                  controller: reportController,
                  decoration: const InputDecoration(
                      hintText: 'Report', border: OutlineInputBorder())),
              const SizedBox(height: 5),
            ])),
            //       final result = await GptApiService().messageCompletion(
            //     ChatGPTCompletionRequest(prompt: prompt, user: userID));
            // story = result.choices.first.text;
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 0),
                child: TextButton(
                    onPressed: () async {
                      if (notetitleController.text.isEmpty) {
                        _titleController.requestFocus();
                        Utils.flushBarErrorMessage(
                            'Please enter title', context);
                      } else if (othersController.text.isEmpty) {
                        _descriptionController.requestFocus();
                        Utils.flushBarErrorMessage(
                            'Please enter others Filed', context);
                      } else {
                        try {
                          $showLoadingDialog(context, 'Retrieving Notes');
                          final prompt =
                              'Create an interesting NotePade between 100 to 120 words. according to The Writing Sample :${sampleController.text}, other information is'
                              '${notetitleController.text.isEmpty ? '' : 'Notes Title Is: ${notetitleController.text} '}'
                              '${clientNameController.text.isEmpty ? '' : 'Client Name is: ${clientNameController.text} '}'
                              '${dateController.text.isEmpty ? '' : 'Date Is: ${dateController.text} '}'
                              '${locationController.text.isEmpty ? '' : 'Location Is ${locationController.text} '}'
                              '${reportController.text.isEmpty ? '' : 'Report Is: ${reportController.text} '}'
                              '${othersController.text.isEmpty ? '' : 'other details is: ${othersController.text} '}';

                          final result = await GptApiService()
                              .messageCompletion(
                                  ChatGPTCompletionRequest(prompt: prompt));
                          final resultDecode = result.choices.first.text;
                          debugPrint("👉" + resultDecode.toString());
                          final data = NotesModel(
                              title: notetitleController.text,
                              description: resultDecode.toString());
                          final box = Boxes.getData();
                          box.add(data);
                          // notetitleController.clear();
                          // othersController.clear();
                          Navigator.pop(context);
                          Navigator.pop(context);
                        } catch (e) {
                          debugPrint("💥 when generate a note:  $e");
                          debugPrint("💥 when generate a note: $e");
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('$e'),
                              duration: const Duration(seconds: 4),
                              action: SnackBarAction(
                                label: 'Undo',
                                onPressed: () {},
                              ),
                            ),
                          );
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF00BCE3),
                          shape: BoxShape.circle,
                        ),
                        height: 50,
                        width: 70,
                        child: Center(
                            child: const Text(
                          'Go',
                          style: TextStyle(color: Colors.black),
                        )))),
              ),
            ],
          );
        });
  }
}

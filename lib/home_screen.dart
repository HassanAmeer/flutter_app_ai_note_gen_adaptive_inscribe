import 'dart:math';
import 'package:adaptive_inscribe/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adaptive_inscribe/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_inscribe/models/notes_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:clipboard/clipboard.dart';
import 'auth/login.dart';
import 'auth/profile_view.dart';
import 'boxes/boxes.dart';
import 'controllers/app_navigation.dart';
import 'services/services.dart';
import 'src/modals/loading_dialog.dart';
import 'src/models/models.dart';
import 'templates.dart';
import 'vm/getkeyVm.dart';

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
  TextEditingController reportController = TextEditingController(text: " ");
  TextEditingController dateController = TextEditingController(text: " ");
  TextEditingController optionalController1 = TextEditingController();
  TextEditingController optionalController2 = TextEditingController();
  TextEditingController optionalController3 = TextEditingController();
  TextEditingController optionalController4 = TextEditingController();
  var templateName = "";
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
    getKeyVmInitF();
    super.initState();
  }

  getKeyVmInitF() async {
    await Provider.of<GetKey>(context, listen: false).getKeyVmF();
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
                              // subtitle: Text(
                              //   data[index]
                              //               .description
                              //               .trim()
                              //               .toString()
                              //               .length >=
                              //           35
                              //       ? data[index]
                              //               .description
                              //               .trim()
                              //               .toString()
                              //               .substring(0, 34) +
                              //           ".."
                              //       : data[index].description.toString(),
                              //   style: TextStyle(color: Colors.white),
                              // ),
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
          return StatefulBuilder(builder: (context, setStates) {
            return AlertDialog(
              title: Text('Create New Note'),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              content: SingleChildScrollView(
                  child: Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  child: TextFormField(
                      controller: notetitleController,
                      decoration: const InputDecoration(
                          hintText: 'Note title',
                          border: OutlineInputBorder())),
                ),
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
                      templateName = selectedTemplate['name'] ?? '';
                      sampleController.text = selectedTemplate['sample'] ?? '';
                      reportController.text = selectedTemplate['report'] ?? '';
                      dateController.text = selectedTemplate['date'] ?? '';
                      optionalController1.text =
                          selectedTemplate['optional1'] ?? '';
                      optionalController2.text =
                          selectedTemplate['optional2'] ?? '';
                      optionalController3.text =
                          selectedTemplate['optional3'] ?? '';
                      optionalController4.text =
                          selectedTemplate['optional4'] ?? '';
                      updateSelectTemlateHintF(
                          selectedTemplate['name'] ?? 'Select a template');
                      // report
                      setStates(() {});
                    },
                    hint: Text(templateValueName.toString())),
                const SizedBox(height: 10),
                templateValueName == "Select a template"
                    ? Text('')
                    : Column(children: [
                        Text("Details 📜",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 5),
                        CupertinoTextField(
                          minLines: 3,
                          maxLines: 4,
                          controller: sampleController,
                          placeholder: "Writing Sample",
                        ),
                        const SizedBox(height: 5),
                        CupertinoTextField(
                            minLines: 3,
                            maxLines: 4,
                            controller: reportController,
                            placeholder: "Report"),
                        const SizedBox(height: 5),
                        dateController.text.toString().trim().isEmpty
                            ? SizedBox(height: 0)
                            : CupertinoTextField(
                                controller: dateController,
                                placeholder: "Date"),
                        const SizedBox(height: 5),
                        optionalController1.text.toString().trim().isEmpty
                            ? SizedBox(height: 0)
                            : CupertinoTextField(
                                controller: optionalController1,
                                placeholder: "Optional 1"),
                        const SizedBox(height: 5),
                        optionalController2.text.toString().trim().isEmpty
                            ? SizedBox(height: 0)
                            : CupertinoTextField(
                                controller: optionalController2,
                                placeholder: "Optional 2"),
                        const SizedBox(height: 5),
                        optionalController3.text.toString().trim().isEmpty
                            ? SizedBox(height: 0)
                            : CupertinoTextField(
                                controller: optionalController3,
                                placeholder: "Optional 3"),
                        const SizedBox(height: 5),
                        optionalController4.text.toString().trim().isEmpty
                            ? SizedBox(height: 0)
                            : CupertinoTextField(
                                controller: optionalController4,
                                placeholder: "Optional 4"),
                      ]),
                const SizedBox(height: 5),
              ])),
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
                        } else {
                          try {
                            $showLoadingDialog(context, 'Retrieving Notes');
                            final prompt = 'This is an Example of a $templateName That i write. ${sampleController.text}, Complete a similar note with same paragrapgh format using the following information:' +
                                '${dateController.text.isEmpty ? '' : '${dateController.text} '},'
                                    '${optionalController1.text.isEmpty ? '' : '${optionalController1.text} '},'
                                    '${optionalController2.text.isEmpty ? '' : '${optionalController2.text} '},'
                                    '${optionalController3.text.isEmpty ? '' : '${optionalController3.text} '},'
                                    '${optionalController4.text.isEmpty ? '' : '${optionalController4.text} '},'
                                    '${reportController.text.isEmpty ? '' : 'Report: ${reportController.text} '}';
                            // debugPrint("📜 $prompt");
                            var apiKey = await Provider.of<GetKey>(context,
                                    listen: false)
                                .apiKey;
                            final resultDecode = await GptApiService("$apiKey")
                                .messageCompletion(
                                    ChatGPTCompletionRequest(prompt: prompt));
                            // debugPrint(
                            //     "👉 resultDecode:" + resultDecode.toString());
                            final data = NotesModel(
                                title: notetitleController.text,
                                description:
                                    resultDecode.choices.first.text.toString());
                            final box = Boxes.getData();
                            box.add(data);
                            // notetitleController.clear();
                            // othersController.clear();
                            Navigator.pop(context);
                            Navigator.pop(context);
                          } catch (e) {
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
        });
  }
}

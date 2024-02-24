import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'utils/snackbar.dart';

class TemplatesPage extends StatefulWidget {
  const TemplatesPage({Key? key}) : super(key: key);

  @override
  State<TemplatesPage> createState() => _TemplatesPageState();
}

class _TemplatesPageState extends State<TemplatesPage> {
  List templates = [];

  @override
  void initState() {
    super.initState();
    getTemplateDataF();
  }

  getTemplateDataF() async {
    // await Hive.openBox("templates");
    var box = Hive.box('templates');
    var data = box.get('templateskey');
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
        title: Text("Templates"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${templates.length}',
              style:
                  TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showTemplateAlertF(context);
          },
          child: Icon(Icons.add)),
      body: templates.isEmpty
          ? Center(
              child: Text(
              "Have No Templates",
              style: TextStyle(color: Colors.blueGrey.shade300),
            ))
          : ListView.builder(
              itemCount: templates.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50),
                    child: ExpansionTile(
                      title: Text(templates[index]['name'] ?? 'Title'),
                      children: [
                        Container(
                          decoration:
                              BoxDecoration(color: Colors.blueGrey.shade50),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                  child: CupertinoListTile(
                                      backgroundColor: Colors.blueGrey.shade100,
                                      title: Text("Sample",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color: Colors.blueGrey)),
                                      subtitle: Text(
                                          ' ${templates[index]['sample']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                  color:
                                                      Colors.grey.shade800)))),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                  child: CupertinoListTile(
                                      backgroundColor: Colors.blueGrey.shade100,
                                      title: Text("Report",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color: Colors.blueGrey)),
                                      subtitle: Text(
                                          ' ${templates[index]['report']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelLarge!
                                              .copyWith(
                                                  color:
                                                      Colors.grey.shade800)))),
                              templates[index]['date'].toString().isEmpty
                                  ? SizedBox(height: 0)
                                  : Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                      child: CupertinoListTile(
                                          backgroundColor:
                                              Colors.blueGrey.shade100,
                                          title: Text("Date",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: Colors.blueGrey)),
                                          subtitle: Text(
                                              ' ${templates[index]['date']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: Colors
                                                          .grey.shade800)))),
                              templates[index]['optional1'].toString().isEmpty
                                  ? SizedBox(height: 0)
                                  : Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                      child: CupertinoListTile(
                                          backgroundColor:
                                              Colors.blueGrey.shade100,
                                          title: Text("Optional 1",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: Colors.blueGrey)),
                                          subtitle: Text(
                                              ' ${templates[index]['optional1']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: Colors
                                                          .grey.shade800)))),
                              templates[index]['optional2'].toString().isEmpty
                                  ? SizedBox(height: 0)
                                  : Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                      child: CupertinoListTile(
                                          backgroundColor:
                                              Colors.blueGrey.shade100,
                                          title: Text("Optional 2",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: Colors.blueGrey)),
                                          subtitle: Text(
                                              ' ${templates[index]['optional2']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: Colors
                                                          .grey.shade800)))),
                              templates[index]['optional3'].toString().isEmpty
                                  ? SizedBox(height: 0)
                                  : Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                      child: CupertinoListTile(
                                          backgroundColor:
                                              Colors.blueGrey.shade100,
                                          title: Text("Optional 3",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: Colors.blueGrey)),
                                          subtitle: Text(
                                              ' ${templates[index]['optional3']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: Colors
                                                          .grey.shade800)))),
                              templates[index]['optional4'].toString().isEmpty
                                  ? SizedBox(height: 0)
                                  : Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                      child: CupertinoListTile(
                                          backgroundColor:
                                              Colors.blueGrey.shade100,
                                          title: Text("Optional 4",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(
                                                      color: Colors.blueGrey)),
                                          subtitle: Text(
                                              ' ${templates[index]['optional4']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge!
                                                  .copyWith(
                                                      color: Colors
                                                          .grey.shade800)))),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Center(
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty
                                                    .all(BeveledRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15))),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.red.shade200)),
                                            onPressed: () {
                                              showCupertinoDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return CupertinoAlertDialog(
                                                      title: const Text(
                                                          'Want to Delete'),
                                                      actions: [
                                                        CupertinoButton(
                                                            onPressed: () {
                                                              deleteTemplate(
                                                                  index);
                                                              setState(() {});
                                                              getTemplateDataF();
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            child: Text(
                                                              'Yes',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red),
                                                            )),
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
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ),
                                    Center(
                                        child: SizedBox(
                                            width:
                                                MediaQuery.of(context).size.width *
                                                    0.4,
                                            child: ElevatedButton(
                                                style: ButtonStyle(
                                                    shape: MaterialStateProperty.all(
                                                        BeveledRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius.circular(
                                                                    15))),
                                                    backgroundColor:
                                                        MaterialStateProperty.all(
                                                            Colors.orange
                                                                .shade200)),
                                                onPressed: () {
                                                  showTemplateAlertForEditF(
                                                      context,
                                                      index: index,
                                                      templateName:
                                                          templates[index]
                                                              ['name'],
                                                      sample: templates[index]
                                                          ['sample'],
                                                      report: templates[index]
                                                          ['report'],
                                                      date: templates[index]
                                                          ['date'],
                                                      optional1:
                                                          templates[index]
                                                              ['optional1'],
                                                      optional2:
                                                          templates[index]
                                                              ['optional2'],
                                                      optional3:
                                                          templates[index]
                                                              ['optional3'],
                                                      optional4:
                                                          templates[index]
                                                              ['optional4']);
                                                },
                                                child: Text('Edit',
                                                    style: TextStyle(
                                                        color: Colors.white)))))
                                  ])
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

// Add a function to delete a template
  void deleteTemplate(int index) async {
    var box = await Hive.openBox("templates");
    // var data = box.get('templateskey');
    // data.removeAt(index);
    List newTemplates = templates.removeAt(index);
    box.put('templateskey', newTemplates);

    // Update the UI
    setState(() {
      // templates.removeAt(index);
    });
  }

  showTemplateAlertForEditF(context,
      {int index = 0,
      String templateName = "",
      String sample = "",
      String report = "",
      String date = "",
      String optional1 = "",
      String optional2 = "",
      String optional3 = "",
      String optional4 = ""}) {
    TextEditingController templateNameController = TextEditingController();
    TextEditingController writingSamplesController = TextEditingController();
    TextEditingController reportController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController optionalController1 = TextEditingController();
    TextEditingController optionalController2 = TextEditingController();
    TextEditingController optionalController3 = TextEditingController();
    TextEditingController optionalController4 = TextEditingController();
    templateNameController.text = templateName;
    writingSamplesController.text = sample;
    reportController.text = report;
    dateController.text = date;
    optionalController1.text = optional1;
    optionalController2.text = optional2;
    optionalController3.text = optional3;
    optionalController4.text = optional4;
    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: CupertinoAlertDialog(
              title: Text('Edit Template',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.orange.shade600)),
              content: Column(
                children: [
                  texteditingforalert(
                      controller: templateNameController,
                      hint: "Template Name"),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14)),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TextField(
                                  controller: writingSamplesController,
                                  minLines: 2,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Writing Sample',
                                      hintStyle: TextStyle(
                                          color: Colors.blueGrey.shade300)))))),
                  Center(child: Text("Details")),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14)),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TextField(
                                  controller: reportController,
                                  minLines: 2,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Report',
                                      hintStyle: TextStyle(
                                          color: Colors.blueGrey.shade300)))))),

                  texteditingforalert(
                      controller: dateController,
                      hint: "Date",
                      suffix: IconButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (picked != null && picked != dateController) {
                            setState(() {
                              // dateController.text = picked.toString();
                              dateController.text =
                                  "${picked.toLocal()}".split(' ')[0];
                            });
                          }
                        },
                        icon: Icon(Icons.date_range_outlined),
                      )),
                  texteditingforalert(
                      controller: optionalController1, hint: "Optional 1"),
                  texteditingforalert(
                      controller: optionalController2, hint: "Optional 2"),
                  texteditingforalert(
                      controller: optionalController3, hint: "Optional 3"),
                  texteditingforalert(
                      controller: optionalController4, hint: "Optional 4"),

                  // Opacity(
                  //     opacity: 0.5,
                  //     child: texteditingforalert(
                  //         controller: reportController,
                  //         hint: "Report",
                  //         isEnable: false)),
                ],
              ),
              actions: [
                CupertinoButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back',
                        style: TextStyle(color: Colors.blueGrey.shade300))),
                CupertinoButton(
                    onPressed: () async {
                      if (templateNameController.text.isEmpty) {
                        showSnackbarF(msg: "Required Name", context: context);
                        // } else if (writingSamplesController.text.trim().isEmpty) {
                        //   showSnackbarF(msg: "Write Sample", context: context);
                        // } else if (clientNameController.text.trim().isEmpty) {
                        //   showSnackbarF(
                        //       msg: "Required Client Name", context: context);
                        // } else if (dateController.text.trim().isEmpty) {
                        //   showSnackbarF(msg: "Required Date", context: context);
                        // } else if (locationController.text.trim().isEmpty) {
                        //   showSnackbarF(
                        //       msg: "Required Location", context: context);
                        // } else if (othersController.text.trim().isEmpty) {
                        //   showSnackbarF(
                        //       msg: "Required Others Field", context: context);
                      } else {
                        // await Hive.openBox("templates");
                        var box = Hive.box('templates');
                        List data = box.get('templateskey') ?? [];

                        data[index] = {
                          'name': templateNameController.text ?? '',
                          'sample': writingSamplesController.text ?? '',
                          'report': reportController.text ?? '',
                          'date': dateController.text ?? '',
                          'optional1': optionalController1.text ?? '',
                          'optional2': optionalController2.text ?? '',
                          'optional3': optionalController3.text ?? '',
                          'optional4': optionalController4.text ?? '',
                        };

                        box.put('templateskey', data);
                        // print('👉Name: $data');
                        getTemplateDataF();
                        setState(() {});
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Update'))
              ],
              insetAnimationCurve: Curves.slowMiddle,
              insetAnimationDuration: const Duration(seconds: 2),
            ),
          );
        });
  }

  showTemplateAlertF(context) {
    TextEditingController templateNameController = TextEditingController();
    TextEditingController writingSamplesController = TextEditingController();
    TextEditingController reportController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController optionalController1 = TextEditingController();
    TextEditingController optionalController2 = TextEditingController();
    TextEditingController optionalController3 = TextEditingController();
    TextEditingController optionalController4 = TextEditingController();

    showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: CupertinoAlertDialog(
              title: const Text('New Template'),
              content: Column(
                children: [
                  texteditingforalert(
                      controller: templateNameController,
                      hint: "Template Name"),

                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14)),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TextField(
                                  controller: writingSamplesController,
                                  minLines: 2,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Writing Sample',
                                      hintStyle: TextStyle(
                                          color: Colors.blueGrey.shade300)))))),
                  Center(child: Text("Details")),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 1.0),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14)),
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: TextField(
                                  controller: reportController,
                                  minLines: 2,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Report',
                                      hintStyle: TextStyle(
                                          color: Colors.blueGrey.shade300)))))),
                  texteditingforalert(
                      controller: dateController,
                      hint: "Date",
                      suffix: IconButton(
                        onPressed: () async {
                          final DateTime? picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (picked != null && picked != dateController) {
                            setState(() {
                              // dateController.text = picked.toString();
                              dateController.text =
                                  "${picked.toLocal()}".split(' ')[0];
                            });
                          }
                        },
                        icon: Icon(Icons.date_range_outlined),
                      )),
                  texteditingforalert(
                      controller: optionalController1, hint: "Optional 1"),
                  texteditingforalert(
                      controller: optionalController2, hint: "Optional 2"),
                  texteditingforalert(
                      controller: optionalController3, hint: "Optional 3"),
                  texteditingforalert(
                      controller: optionalController4, hint: "Optional 4"),

                  // Opacity(
                  //     opacity: 0.5,
                  //     child: texteditingforalert(
                  //         controller: reportController,
                  //         hint: "Report",
                  //         isEnable: false)),
                ],
              ),
              actions: [
                CupertinoButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back',
                        style: TextStyle(color: Colors.blueGrey.shade300))),
                CupertinoButton(
                    onPressed: () async {
                      if (templateNameController.text.isEmpty) {
                        showSnackbarF(msg: "Required Name", context: context);
                      } else if (writingSamplesController.text.trim().isEmpty) {
                        showSnackbarF(msg: "Write Sample", context: context);
                      } else {
                        // await Hive.openBox("templates");
                        var box = Hive.box('templates');

                        final tempData = {
                          'name': templateNameController.text,
                          'sample': writingSamplesController.text,
                          'report': reportController.text,
                          'date': dateController.text,
                          'optional1': optionalController1.text ?? '',
                          'optional2': optionalController2.text ?? '',
                          'optional3': optionalController3.text ?? '',
                          'optional4': optionalController4.text ?? '',
                        };

                        // final tempData = Template(
                        //   name: templateNameController.text,
                        //   clientName: clientNameController.text,
                        //   date: dateController.text,
                        //   location: locationController.text,
                        //   others: othersController.text,
                        //   report: reportController.text,
                        // );
                        // List<Map<String, dynamic>> data =
                        //     box.get('templateskey') ?? [];
                        List data = box.get('templateskey') ?? [];

                        data.add(tempData);
                        box.put('templateskey', data);
                        // print('👉Name: $data');
                        getTemplateDataF();
                        setState(() {});
                        Navigator.pop(context);
                      }
                    },
                    child: Text('Save'))
              ],
              insetAnimationCurve: Curves.slowMiddle,
              insetAnimationDuration: const Duration(seconds: 2),
            ),
          );
        });
  }
}

class texteditingforalert extends StatelessWidget {
  final TextEditingController? controller;
  final String? hint;
  final int? minlines;
  final int? maxlines;
  final Widget? suffix;
  final bool? isEnable;
  const texteditingforalert({
    super.key,
    this.hint,
    this.controller,
    this.minlines = 1,
    this.maxlines = 1,
    this.suffix,
    this.isEnable = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(14)),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: TextField(
                      enabled: isEnable,
                      controller: controller,
                      minLines: minlines,
                      maxLines: minlines,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          suffixIcon: suffix == null ? null : suffix,
                          hintText: hint,
                          hintStyle:
                              TextStyle(color: Colors.blueGrey.shade300)))))),
    );
  }
}

class Template {
  String name;
  String clientName;
  String date;
  String location;
  String others;
  String report;

  Template({
    required this.name,
    required this.clientName,
    required this.date,
    required this.location,
    required this.others,
    required this.report,
  });
}

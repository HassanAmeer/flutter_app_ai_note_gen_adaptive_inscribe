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
        child: Icon(Icons.add),
      ),
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
                                      title: Text("Client Name",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color: Colors.blueGrey)),
                                      subtitle: Text(
                                          ' ${templates[index]['clientName']}',
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
                                                  color:
                                                      Colors.grey.shade800)))),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2.0),
                                  child: CupertinoListTile(
                                      backgroundColor: Colors.blueGrey.shade100,
                                      title: Text("Location",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color: Colors.blueGrey)),
                                      subtitle: Text(
                                          ' ${templates[index]['location']}',
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
                                      title: Text("Others",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color: Colors.blueGrey)),
                                      subtitle: Text(
                                          ' ${templates[index]['others']}',
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Center(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
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
                                                                color:
                                                                    Colors.red),
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
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                  Center(
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
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
                                                      Colors.orange.shade200)),
                                          onPressed: () {
                                            showTemplateAlertForEditF(
                                                context,
                                                index,
                                                templates[index]['name'],
                                                templates[index]['sample'],
                                                templates[index]['clientName'],
                                                templates[index]['date'],
                                                templates[index]['location'],
                                                templates[index]['others'],
                                                templates[index]['report']);
                                          },
                                          child: Text(
                                            'Edit',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                    ),
                                  ),
                                ],
                              )
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
    var data = box.get('templateskey');
    data.removeAt(index);
    box.put('templateskey', data);

    // Update the UI
    setState(() {
      templates.removeAt(index);
    });
  }

  showTemplateAlertForEditF(context, index, templateName, sample, clientName,
      date, location, others, report) {
    TextEditingController templateNameController = TextEditingController();
    TextEditingController clientNameController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController othersController = TextEditingController();
    TextEditingController reportController = TextEditingController();
    TextEditingController writingSamplesController = TextEditingController();
    templateNameController.text = templateName ?? '';
    writingSamplesController.text = sample ?? '';
    clientNameController.text = clientName ?? '';
    dateController.text = date ?? '';
    locationController.text = location ?? '';
    othersController.text = others ?? '';
    reportController.text = report ?? '';
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
                  texteditingforalert(
                      controller: clientNameController, hint: "Client Name"),
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
                      controller: locationController, hint: "Location"),
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
                                  controller: othersController,
                                  minLines: 2,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Others',
                                      hintStyle: TextStyle(
                                          color: Colors.blueGrey.shade300)))))),
                  Opacity(
                      opacity: 0.5,
                      child: texteditingforalert(
                          controller: reportController,
                          hint: "Report",
                          isEnable: false)),
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
                          'clientName': clientNameController.text ?? '',
                          'date': dateController.text ?? '',
                          'location': locationController.text ?? '',
                          'others': othersController.text ?? '',
                          'report': reportController.text ?? '',
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
    TextEditingController clientNameController = TextEditingController();
    TextEditingController dateController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController othersController = TextEditingController();
    TextEditingController reportController = TextEditingController();
    TextEditingController writingSamplesController = TextEditingController();

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
                  texteditingforalert(
                      controller: clientNameController, hint: "Client Name"),
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
                      controller: locationController, hint: "Location"),

                  // texteditingforalert(
                  //     controller: reportController,
                  //     hint: "Report")

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
                                  controller: othersController,
                                  minLines: 2,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      hintText: 'Others',
                                      hintStyle: TextStyle(
                                          color: Colors.blueGrey.shade300)))))),
                  Opacity(
                      opacity: 0.5,
                      child: texteditingforalert(
                          controller: reportController,
                          hint: "Report",
                          isEnable: false)),
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
                      } else if (clientNameController.text.trim().isEmpty) {
                        showSnackbarF(
                            msg: "Required Client Name", context: context);
                      } else if (dateController.text.trim().isEmpty) {
                        showSnackbarF(msg: "Required Date", context: context);
                      } else if (locationController.text.trim().isEmpty) {
                        showSnackbarF(
                            msg: "Required Location", context: context);
                      } else if (othersController.text.trim().isEmpty) {
                        showSnackbarF(
                            msg: "Required Others Field", context: context);
                      } else {
                        // await Hive.openBox("templates");
                        var box = Hive.box('templates');

                        final tempData = {
                          'name': templateNameController.text,
                          'sample': writingSamplesController.text,
                          'clientName': clientNameController.text,
                          'date': dateController.text,
                          'location': locationController.text,
                          'others': othersController.text,
                          'report': reportController.text,
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

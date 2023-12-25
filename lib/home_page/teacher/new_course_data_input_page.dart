import 'dart:ffi';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:future/storage_service.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../../bottom_navigation_home.dart';

class NewCourseDataInput extends StatefulWidget {
  const NewCourseDataInput({Key? key}) : super(key: key);

  static String id = 'newcoursedatainput';

  @override
  State<NewCourseDataInput> createState() => _NewCourseDataInputState();
}

class _NewCourseDataInputState extends State<NewCourseDataInput> {
  @override
  void initState() {
    super.initState();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  late String title;
  late String description;
  String _image =
      'https://firebasestorage.googleapis.com/v0/b/future-6fe3d.appspot.com/o/default%2Fcourse_card.png?alt=media&token=485a2b8b-8cdc-4b84-bae4-81f7d97660e3';
  Widget? selectedPic;
  List<Widget> newFields = [];
  List<String> newItemFieldlist = [];

  int itemcount = -1;
  String? title1;
  String? description1;
  String? title2;
  String? description2;
  String? title3;
  String? description3;
  String? title4;
  String? description4;
  String? title5;
  String? description5;

  @override
  Widget build(BuildContext context) {
    final Storage storage = Storage();

    return Scaffold(
        appBar: AppBar(
          title: Text('Create a Course'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                onPressed: () async {
                  if (title.isEmpty) {
                    print('empty title');
                  } else if (description.isEmpty) {
                    print('empty description');
                  } else {
                    final User? user = auth.currentUser;
                    final uid = user?.uid;

                    try {
                      User? user = FirebaseAuth.instance.currentUser;
                      await FirebaseFirestore.instance
                          .collection('courses')
                          .doc((user?.uid)! + title)
                          .set({
                        'likecourse': null,
                        'courseid': ((user?.uid)! + title),
                        'course_pic': _image,
                        'title': title,
                        'oldtitle': title,
                        'description': description,
                        'new_item_field_list': newItemFieldlist,
                        'title1': title1,
                        'description1': description1,
                        'title2': title2,
                        'description2': description2,
                        'title3': title3,
                        'description3': description3,
                        'title4': title4,
                        'description4': description4,
                        'title5': title5,
                        'description5': description5,
                        'itemcount': itemcount,
                        'uid': uid,
                      });
                      if (description != null) {
                        if (title != null) {
                          Navigator.pushNamed(context, BottomNavigationHome.id);
                        }
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                icon: Icon(Icons.save),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Row(
              children: [
                Text('Select a Picture'),
                // Container(
                //   height: 100.0,
                //   width: 100.0,
                //   margin: const EdgeInsets.all(15.0),
                //   padding: const EdgeInsets.all(3.0),
                //   decoration: BoxDecoration(
                //     border: Border.all(
                //       color: Colors.black,
                //       width: 2.0,
                //     ),
                //   ),
                //   child: selectedPic,
                // ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () async {
                      final results = await FilePicker.platform.pickFiles(
                        allowMultiple: false,
                        type: FileType.custom,
                        allowedExtensions: ['png', 'jpg'],
                      );

                      if (results == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('No Image Selected'),
                          ),
                        );
                        return null;
                      }

                      final path = results.files.single.path;
                      final fileName = results.files.single.name;
                      print(path);
                      print(fileName);
                      storage.uploadFile(path!, fileName).then(
                          (value) => ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Done'),
                                ),
                              ));

                      setState(() {
                        storage.downloadURL(fileName).then((value) {
                          _image = value;
                          selectedPic = Image.network(_image);
                        });
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                onChanged: (value) {
                  title = value;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Course title',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                onChanged: (value) {
                  description = value;
                },
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Course description',
                ),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Column(
              children: newFields,
            )
          ]),
        ),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
                child: Icon(Icons.text_fields),
                label: 'add title',
                onTap: () {
                  itemcount++;
                  newItemFieldlist.add('title');
                  setState(() {
                    switch (itemcount) {
                      case 0:
                        {
                          newFields.add(
                            TextFormField(
                              onChanged: (value) {
                                title1 = value;
                              },
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'title',
                              ),
                            ),
                          );
                        }
                        break;

                      case 1:
                        {
                          newFields.add(
                            TextFormField(
                              onChanged: (value) {
                                title2 = value;
                              },
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'title',
                              ),
                            ),
                          );
                        }
                        break;

                      case 2:
                        {
                          newFields.add(
                            TextFormField(
                              onChanged: (value) {
                                title3 = value;
                              },
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'title',
                              ),
                            ),
                          );
                        }
                        break;

                      case 3:
                        {
                          newFields.add(
                            TextFormField(
                              onChanged: (value) {
                                title4 = value;
                              },
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'title',
                              ),
                            ),
                          );
                        }
                        break;

                      case 4:
                        {
                          newFields.add(
                            TextFormField(
                              onChanged: (value) {
                                title5 = value;
                              },
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'title',
                              ),
                            ),
                          );
                        }
                        break;
                    }
                  });
                }),
            SpeedDialChild(
                child: Icon(Icons.text_fields),
                label: 'add description',
                onTap: () {
                  itemcount++;
                  newItemFieldlist.add('description');
                  setState(() {
                    switch (itemcount) {
                      case 0:
                        {
                          newFields.add(
                            TextFormField(
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              onChanged: (value) {
                                description1 = value;
                              },
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'description',
                              ),
                            ),
                          );
                        }
                        break;

                      case 1:
                        {
                          newFields.add(
                            TextFormField(
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              onChanged: (value) {
                                description2 = value;
                              },
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'description',
                              ),
                            ),
                          );
                        }
                        break;

                      case 2:
                        {
                          newFields.add(
                            TextFormField(
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              onChanged: (value) {
                                description3 = value;
                              },
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'description',
                              ),
                            ),
                          );
                        }
                        break;

                      case 3:
                        {
                          newFields.add(
                            TextFormField(
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              onChanged: (value) {
                                description4 = value;
                              },
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'description',
                              ),
                            ),
                          );
                        }
                        break;

                      case 4:
                        {
                          newFields.add(
                            TextFormField(
                              maxLines: 5,
                              keyboardType: TextInputType.multiline,
                              onChanged: (value) {
                                description5 = value;
                              },
                              decoration: const InputDecoration(
                                border: UnderlineInputBorder(),
                                labelText: 'description',
                              ),
                            ),
                          );
                        }
                        break;
                    }
                  });
                }),
            SpeedDialChild(
                child: Icon(Icons.attach_file_outlined),
                label: 'add file',
                onTap: () {
                  setState(() {});
                }),
            SpeedDialChild(
                child: Icon(Icons.delete_forever),
                label: 'remove last field',
                onTap: () {
                  setState(() {
                    newItemFieldlist.removeLast();
                    newFields.removeLast();
                    itemcount--;
                  });
                }),
          ],
        ));
  }
}

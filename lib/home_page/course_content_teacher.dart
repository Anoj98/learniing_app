import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:future/account_page/account_page.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gallery_saver/gallery_saver.dart';
import '../bottom_navigation_home.dart';
import '../initial_screens/constants.dart';
import 'package:path_provider/path_provider.dart';

class CourseContentTeacher extends StatefulWidget {
  final String passedCourseCard;

  const CourseContentTeacher({
    Key? key,
    required this.passedCourseCard,
  }) : super(key: key);

  static String id = 'course_content_teacher';

  @override
  State<CourseContentTeacher> createState() => _CourseContentTeacherState();
}

class _CourseContentTeacherState extends State<CourseContentTeacher> {
  String topic = ' ';
  String author = ' ';
  List<Widget> texts = [];
  //String j = '1';
  String? title;
  String? oldTitle;
  String? courseId;

  late Future<ListResult> fureFiles;

  @override
  void initState() {
    getClickedCourse();

    super.initState();
    fureFiles = FirebaseStorage.instance.ref('/files').listAll();
  }

//check witch course card selected

  void getClickedCourse() async {
    //User? user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseFirestore.instance.collection('courses').get().then(
          (QuerySnapshot snapshot) =>
              snapshot.docs.forEach((DocumentSnapshot doc) {
                setState(() {
                  if (doc.get('title') == widget.passedCourseCard) {
                    courseId = doc.get('courseid');
                    //oldTitle = doc.get('oldtitle');
                    texts.add(Text(
                      doc.get('title'),
                      style: kWelcomeTextStyle,
                    ));
                    texts.add(SizedBox(
                      height: 10.0,
                    ));
                    texts.add(Text(
                      doc.get('description'),
                      style: kDescriptionTextStyle,
                    ));

                    for (int i = 0; i <= doc.get('itemcount'); i++) {
                      switch (i) {
                        case 0:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(Text(
                                doc.get('title1'),
                                style: kSubtitleTextStyle,
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(Text(doc.get('description1')));
                            }
                          }
                          break;
                        case 1:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(Text(
                                doc.get('title2'),
                                style: kSubtitleTextStyle,
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(Text(doc.get('description2')));
                            }
                          }
                          break;

                        case 2:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(Text(
                                doc.get('title3'),
                                style: kSubtitleTextStyle,
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(Text(doc.get('description3')));
                            }
                          }
                          break;

                        case 3:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(Text(
                                doc.get('title4'),
                                style: kSubtitleTextStyle,
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(Text(doc.get('description4')));
                            }
                          }
                          break;

                        case 4:
                          {
                            if ((doc.get('new_item_field_list')[i]) ==
                                'title') {
                              texts.add(Text(
                                doc.get('title5'),
                                style: kSubtitleTextStyle,
                              ));
                            }
                            if ((doc.get('new_item_field_list')[i]) ==
                                'description') {
                              texts.add(Text(doc.get('description5')));
                            }
                          }
                          break;
                      }
                    }
                  }
                });
              }));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                //String? user = FirebaseAuth.instance.currentUser?.uid;
                FirebaseFirestore.instance
                    .collection('courses')
                    .doc(courseId)
                    .delete();
                Navigator.pushNamed(context, AccountPage.id);
              },
              icon: Icon(Icons.delete_forever))
        ],
        title: Text('Course Content'),
      ),
      body: Column(
        children: [
          Column(
            children: texts,
          ),
          // Column(
          //   children: [
          //     FutureBuilder<ListResult>(
          //       future: fureFiles,
          //       builder: (context, snapshot) {
          //         if (snapshot.hasData) {
          //           final files = snapshot.data!.items;
          //
          //           return ListView.builder(
          //               itemCount: files.length,
          //               itemBuilder: (context, index) {
          //                 final file = files[index];
          //
          //                 return ListTile(
          //                   title: Text(file.name),
          //                   trailing: IconButton(
          //                     icon: const Icon(
          //                       Icons.download,
          //                       color: Colors.black,
          //                     ),
          //                     onPressed: () {
          //                       //downloadFile(file);
          //                     },
          //                   ),
          //                 );
          //               });
          //         } else if (snapshot.hasError) {
          //           return const Center(child: Text('erro'));
          //         } else {
          //           return Center(
          //             child: CircularProgressIndicator(),
          //           );
          //         }
          //       },
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

//   Future downloadFile(Reference ref) async {
//     final url = await ref.getDownloadURL();
//
//     final tempDir = await getTemporaryDirectory();
//     final path = '${tempDir.path}/${ref.name}';
//     await Dio().download(url, path);
//     if (url.contains('.mp4')) {
//       await GallerySaver.saveVideo(path, toDcim: true);
//     } else if (url.contains('.jpg')) {
//       await GallerySaver.saveImage(path, toDcim: true);
//     }
//
//     final dir = await getApplicationDocumentsDirectory();
//     final file = File('${dir.path}/${ref.name}');
//     await ref.writeToFile(file);
//
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text('Downloaded ${ref.name}'),
//     ));
//   }
}

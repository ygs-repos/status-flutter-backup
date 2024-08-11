// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:video_thumbnail/video_thumbnail.dart';
// import 'package:wa_status_saver/ui/saved_screen.dart';
//
// import '../controllers/home_controller.dart';
// import '../utils/video_play.dart';
// import 'recent_screens/recent_screen.dart';
//
// // final Directory _videoDir = Directory(
// //     '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses');
//
// class VideoScreen extends StatefulWidget {
//   const VideoScreen({Key? key}) : super(key: key);
//   @override
//   VideoScreenState createState() => VideoScreenState();
// }
//
// class VideoScreenState extends State<VideoScreen> {
//   final controller = Get.put(HomeController());
//   @override
//   Widget build(BuildContext context) {
//     if (!Directory('${controller.whatsappDirectory.value.path}').existsSync()) {
//       return Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const Text(
//             'Install WhatsApp\n',
//             style: TextStyle(fontSize: 18.0),
//           ),
//           const Text(
//             "Your Friend's Status Will Be Available Here",
//             style: TextStyle(fontSize: 18.0),
//           ),
//         ],
//       );
//     } else {
//       return VideoGrid();
//     }
//   }
// }
//
// class VideoGrid extends StatefulWidget {
//   // final Directory? directory;
//
//   const VideoGrid({Key? key}) : super(key: key);
//
//   @override
//   _VideoGridState createState() => _VideoGridState();
// }
//
// class _VideoGridState extends State<VideoGrid> {
//   final controller = Get.put(HomeController());
//   Future<String?> _getImage(videoPathUrl) async {
//     final thumb = await VideoThumbnail.thumbnailFile(video: videoPathUrl);
//     return thumb;
//   }
//
//   showSaveDialogue() {
//     showDialog(
//         context: context,
//         builder: (context) {
//           return SimpleDialog(
//             children: <Widget>[
//               Center(
//                 child: Container(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Column(
//                     children: <Widget>[
//                       const Text(
//                         'Saved in Gallery',
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       const Padding(
//                         padding: EdgeInsets.all(10.0),
//                       ),
//                       Text("All selected status have been saved.",
//                           style: const TextStyle(
//                             fontSize: 16.0,
//                           )),
//                       const Padding(
//                         padding: EdgeInsets.all(10.0),
//                       ),
//                       const Text('FileManager > Pictures > SavedStatus',
//                           style: TextStyle(fontSize: 16.0, color: Colors.teal)),
//                       const Padding(
//                         padding: EdgeInsets.all(10.0),
//                       ),
//                       MaterialButton(
//                         child: const Text('Close'),
//                         color: Colors.teal,
//                         textColor: Colors.white,
//                         onPressed: () => Navigator.pop(context),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         });
//   }
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     controller.videoList = controller.whatsappDirectory.value
//         .listSync()
//         .map((item) => item.path)
//         .where((item) => item.endsWith('.mp4'))
//         .toList(growable: false).obs;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       if (controller.videoList.isNotEmpty) {
//         if (controller.videoList.length > 0) {
//           return Obx(() {
//             return Scaffold(
//                 body: Container(
//                   margin:
//                   const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
//                   child: GridView.builder(
//                     itemCount: controller.videoList.length,
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         childAspectRatio: 1.0,
//                         mainAxisSpacing: 6.0,
//                         crossAxisSpacing: 6),
//                     itemBuilder: (context, index) {
//                       return InkWell(
//                         onTap: () {
//                           if (!controller.multiSelectVideo.value) {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => PlayStatus(
//                                   videoFile: controller.videoList[index],
//                                 ),
//                               ),
//                             );
//                           } else {
//                             controller.selectedFilesVideo[index].selected!.value =
//                             !controller
//                                 .selectedFilesVideo[index].selected!.value;
//                           }
//                         },
//                         onLongPress: () async {
//                           HapticFeedback.vibrate();
//                           if (!controller.multiSelectVideo.value) {
//                             controller.multiSelectVideo.value = true;
//                             controller.selectedFilesVideo.clear();
//                             for (var item in controller.videoList) {
//                               controller.selectedFilesVideo.add(MultiSelectClass(
//                                   file: File(item), selected: false.obs));
//                               print(item);
//                             }
//                             controller.selectedFilesVideo[index].selected!.value =
//                             true;
//                           }
//                         },
//                         child: Obx(() {
//                           return Stack(
//                             children: [
//                               Positioned.fill(
//                                 child: Container(
//                                   decoration: const BoxDecoration(
//                                       color: Color(0xffF4F4F2)),
//                                   child: FutureBuilder<String?>(
//                                       future: _getImage(controller.videoList[index]),
//                                       builder: (context, snapshot) {
//                                         if (snapshot.connectionState ==
//                                             ConnectionState.done) {
//                                           if (snapshot.hasData) {
//                                             return Hero(
//                                               tag: controller.videoList[index],
//                                               child: Image.file(
//                                                 File(snapshot.data!),
//                                                 fit: BoxFit.cover,
//                                               ),
//                                             );
//                                           } else {
//                                             return const Center(
//                                               child:
//                                               CircularProgressIndicator(),
//                                             );
//                                           }
//                                         } else {
//                                           return Hero(
//                                             tag: controller.videoList[index],
//                                             child: FractionallySizedBox(
//                                               heightFactor: .8,
//                                               widthFactor: .8,
//                                               child: Image.asset(
//                                                 'assets/images/video_loader.gif',
//                                                 fit: BoxFit.contain,
//                                               ),
//                                             ),
//                                           );
//                                         }
//                                       }),
//                                   //new cod
//                                 ),
//                               ),
//                               if (controller.multiSelectVideo.value)
//                                 Positioned(
//                                     child: Align(
//                                         alignment: Alignment.topRight,
//                                         child: Container(
//                                           margin:
//                                           EdgeInsets.only(top: 4, right: 4),
//                                           decoration: BoxDecoration(
//                                               shape: BoxShape.circle,
//                                               color: controller
//                                                   .selectedFilesVideo[index]
//                                                   .selected!
//                                                   .value
//                                                   ? Colors.white
//                                                   : null),
//                                           child: Icon(
//                                             Icons.check_circle_sharp,
//                                             size: 28,
//                                             color: controller
//                                                 .selectedFilesVideo[index]
//                                                 .selected!
//                                                 .value
//                                                 ? Colors.green
//                                                 : Colors.white,
//                                           ),
//                                         )))
//                             ],
//                           );
//                         }),
//                       );
//                     },
//                   ),
//                 ),
//                 floatingActionButton: controller.multiSelectVideo.value
//                     ? FloatingActionButton(
//                   onPressed: () async {
//                     bool chosen = false;
//                     for (var item in controller.selectedFilesVideo) {
//                       if (item.selected!.value) {
//                         if (chosen == false) {
//                           showSaveDialogue();
//                         }
//                         chosen = true;
//                         await item.file
//                             .copy(controller.saveDirectory.value.path +
//                             "/" +
//                             item.file.path.split("/").last)
//                             .catchError((e) {
//                           throw Exception(e);
//                         });
//                       }
//                     }
//                     if (!chosen) {
//                       Fluttertoast.showToast(msg: "Please select any");
//                     } else {
//                       controller.multiSelectVideo.value = false;
//                       controller.selectedFilesVideo.clear();
//                     }
//                   },
//                   child: Icon(Icons.save),
//                 )
//                     : null);
//           });
//         }
//         else {
//           return Center(
//             child: SizedBox(
//                 height: MediaQuery.of(context).size.height * .74,
//                 child: Image.asset("assets/images/how.png")),
//           );
//         }
//       }
//       else {
//         return Center(
//           child: SizedBox(
//               height: MediaQuery.of(context).size.height * .74,
//               child: Image.asset("assets/images/how.png")),
//         );
//       }
//     });
//   }
// }

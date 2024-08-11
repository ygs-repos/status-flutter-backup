// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:chewie/chewie.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:video_player/video_player.dart';
// import 'package:wa_status_saver/controllers/home_controller.dart';
//
//
// class StatusVideo extends StatefulWidget {
//   final bool looping;
//   final String videoSrc;
//   final double? aspectRatio;
//   final bool? hideButton;
//   final String? videoFile;
//
//   const StatusVideo({
//     this.looping = false,
//     required this.videoSrc,
//     this.aspectRatio,
//     this.hideButton = false,
//     Key? key,
//     this.videoFile,
//   }) : super(key: key);
//
//   @override
//   _StatusVideoState createState() => _StatusVideoState();
// }
//
// class _StatusVideoState extends State<StatusVideo> {
//   final controller = Get.put(HomeController());
//   late ChewieController _chewieController;
//   late VideoPlayerController videoPlayerController;
//
//   @override
//   void initState() {
//     super.initState();
//     loadControllers();
//   }
//
//   loadControllers() async {
//     videoPlayerController = VideoPlayerController.file(File(widget.videoFile!));
//     await videoPlayerController.initialize();
//     print("aspect ratio... ${videoPlayerController.value.aspectRatio}");
//     _chewieController = ChewieController(
//       videoPlayerController: videoPlayerController,
//       autoInitialize: true,
//       looping: widget.looping,
//       allowFullScreen: true,
//       aspectRatio: videoPlayerController.value.aspectRatio,
//       errorBuilder: (context, errorMessage) {
//         return Center(
//           child: Text(errorMessage),
//         );
//       },
//     );
//     setState(() {});
//   }
//
//   disposeControllers() {
//     videoPlayerController.pause();
//     _chewieController.pause();
//     videoPlayerController.dispose();
//     _chewieController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         disposeControllers();
//         return true;
//       },
//       child: Scaffold(
//           backgroundColor: Colors.black,
//           appBar: AppBar(
//             elevation: 0.0,
//             backgroundColor: Colors.transparent,
//             leading: IconButton(
//               color: Colors.white,
//               icon: const Icon(
//                 Icons.close,
//                 color: Colors.white,
//               ),
//               onPressed: () {
//                 disposeControllers();
//                 Navigator.of(context).pop();
//               },
//             ),
//           ),
//           body: Container(
//             padding: const EdgeInsets.only(top: 0),
//             margin: EdgeInsets.only(bottom: 80),
//             child: videoPlayerController.value.isInitialized
//                 ? Chewie(
//                     controller: _chewieController,
//                   )
//                 : null,
//           ),
//           floatingActionButton: !widget.hideButton!
//               ? Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           final File name = File(widget.videoFile!);
//                           print(name.path);
//                           name
//                               .copy(controller.saveDirectory.value.path +
//                                   "/" +
//                                   widget.videoFile!.split("/").last)
//                               .then((value) {
//                             Fluttertoast.showToast(msg: "File Saved");
//                           }).catchError((e) {
//                             throw Exception(e);
//                           });
//                         },
//                         icon: Icon(
//                           Icons.save_alt,
//                           color: Colors.white,
//                         )),
//                     IconButton(
//                         onPressed: () {
//                           Share.shareFiles(['${widget.videoFile!}'], text: '');
//                         },
//                         icon: Icon(
//                           Icons.share,
//                           color: Colors.white,
//                         )),
//                   ],
//                 )
//               : Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     IconButton(
//                         onPressed: () {
//                           Share.shareFiles(['${widget.videoFile!}'], text: '');
//                           // Share.shareFiles(['${directory.path}/image1.jpg', '${directory.path}/image2.jpg']);
//                         },
//                         icon: Icon(
//                           Icons.share,
//                           color: Colors.white,
//                         )),
//                     IconButton(
//                         onPressed: () {
//                           disposeControllers();
//                           final File name = File(widget.videoFile!);
//                           print(name.path);
//                           name.delete().then((value) {
//                             print("Deleted Successfully");
//                             print(value.path);
//                             setState(() {
//                               Fluttertoast.showToast(msg: "Deleted");
//                               Get.back();
//                               controller.updateFiles();
//                             });
//                           }).catchError((e) {
//                             throw Exception(e);
//                           });
//                         },
//                         icon: Icon(
//                           Icons.delete,
//                           color: Colors.white,
//                         )),
//                   ],
//                 )
//           // !widget.hideButton!
//           //     ? SpeedDialFabWidget(
//           //         secondaryIconsList: [
//           //           Icons.sd_card,
//           //           Icons.share,
//           //         ],
//           //         secondaryIconsText: [
//           //           "Save",
//           //           "Share",
//           //         ],
//           //         secondaryIconsOnPress: [
//           //           () async {
//           //             final File name = File(widget.videoFile!);
//           //             print(name.path);
//           //             name
//           //                 .copy(controller.saveDirectory.value.path +
//           //                     "/" +
//           //                     widget.videoFile!.split("/").last)
//           //                 .then((value) {
//           //               print("image copied successful");
//           //               print(value.path);
//           //               setState(() {
//           //                 ScaffoldMessenger.of(context).showSnackBar(
//           //                     SnackBar(content: Text("File Saved")));
//           //               });
//           //             }).catchError((e) {
//           //               throw Exception(e);
//           //             });
//           //           },
//           //           () {
//           //             Share.shareFiles(['${widget.videoFile!}'], text: '');
//           //             // Share.shareFiles(['${directory.path}/image1.jpg', '${directory.path}/image2.jpg']);
//           //           },
//           //         ],
//           //         primaryIconExpand: Icons.add,
//           //         primaryIconCollapse: Icons.add,
//           //         secondaryBackgroundColor: Colors.teal,
//           //         secondaryForegroundColor: Colors.white,
//           //         primaryBackgroundColor: Colors.teal,
//           //         primaryForegroundColor: Colors.white,
//           //       )
//           //     : SpeedDialFabWidget(
//           //         secondaryIconsList: [Icons.share, Icons.delete],
//           //         secondaryIconsText: ["Share", "Delete"],
//           //         secondaryIconsOnPress: [
//           //           () {
//           //             Share.shareFiles(['${widget.videoFile}'],
//           //                 text: 'Whatsapp status');
//           //             // Share.shareFiles(['${directory.path}/image1.jpg', '${directory.path}/image2.jpg']);
//           //           },
//           //           () async {
//           //             disposeControllers();
//           //             final File name = File(widget.videoFile!);
//           //             print(name.path);
//           //             name.delete().then((value) {
//           //               print("Deleted Successfully");
//           //               print(value.path);
//           //               setState(() {
//           //                 Fluttertoast.showToast(msg: "Deleted");
//           //                 Get.back();
//           //                 controller.updateFiles();
//           //               });
//           //             }).catchError((e) {
//           //               throw Exception(e);
//           //             });
//           //           },
//           //         ],
//           //         primaryIconExpand: Icons.add,
//           //         primaryIconCollapse: Icons.add,
//           //         secondaryBackgroundColor: Colors.teal,
//           //         secondaryForegroundColor: Colors.white,
//           //         primaryBackgroundColor: Colors.teal,
//           //         primaryForegroundColor: Colors.white,
//           //       ),
//           ),
//     );
//   }
//
//   // @override
//   // void dispose() {
//   //   widget.videoPlayerController.pause();
//   //   widget.videoPlayerController.dispose();
//   //   _chewieController.pause();
//   //   _chewieController.dispose();
//   //   super.dispose();
//   // }
// }

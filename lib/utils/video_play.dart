//
// import 'package:flutter/material.dart';
//
// import 'video_controller.dart';
//
// class PlayStatus extends StatefulWidget {
//   final String videoFile;
//   final bool? hideButton;
//   const PlayStatus({
//     Key? key,
//     required this.videoFile, this.hideButton = false,
//   }) : super(key: key);
//   @override
//   _PlayStatusState createState() => _PlayStatusState();
// }
//
// class _PlayStatusState extends State<PlayStatus> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: StatusVideo(
//         // videoPlayerController:
//         //     VideoPlayerController.file(File(widget.videoFile)),
//         looping: true,
//         videoSrc: widget.videoFile,
//         hideButton: widget.hideButton,
//         videoFile: widget.videoFile,
//       ),
//       // ),
//     );
//   }
// }

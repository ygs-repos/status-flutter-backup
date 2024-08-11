import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:wa_status_saver/controllers/home_controller.dart';

class VideoView extends StatefulWidget {
  final String? videoFile;
  final bool? deleteImage;
 final ChewieController? chewieController;
 final VideoPlayerController? videoPlayerController;

  const VideoView({
    Key? key,
    this.videoFile,
    this.chewieController,
    this.videoPlayerController,
    this.deleteImage = false,
  }) : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  final controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 0),
      margin: EdgeInsets.only(bottom: 80),
      child: widget.videoPlayerController!.value.isInitialized
          ? Chewie(
        controller: widget.chewieController!,
      )
          : null,
    );
  }
}

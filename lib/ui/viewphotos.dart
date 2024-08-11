import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wa_status_saver/controllers/home_controller.dart';

class ViewPhotos extends StatefulWidget {
  final String imgPath;
  final bool? deleteImage;
  final bool? fromVideos;
  const ViewPhotos({
    Key? key,
    required this.imgPath,
    this.deleteImage = false, this.fromVideos = false,
  }) : super(key: key);

  @override
  _ViewPhotosState createState() => _ViewPhotosState();
}

class _ViewPhotosState extends State<ViewPhotos> {
  var filePath;
  final String imgShare = 'Image.file(File(widget.imgPath),)';

  final LinearGradient backgroundGradient = const LinearGradient(
    colors: [
      Color(0x00000000),
      Color(0x00333333),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  void initState() {
    super.initState();
    // getDirectory();
  }

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Center(
        child: Image.file(
          File(widget.imgPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

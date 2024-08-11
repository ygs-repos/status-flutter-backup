import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import 'package:wa_status_saver/controllers/home_controller.dart';
import 'package:wa_status_saver/ui/recent_screens/videos_view.dart';
import '../viewphotos.dart';

class ViewCombineScreen extends StatefulWidget {
  final List<dynamic> list;
  final int index;
  final bool? fromSave;

  const ViewCombineScreen(
      {Key? key,
      required this.list,
      required this.index,
      this.fromSave = false})
      : super(key: key);

  @override
  State<ViewCombineScreen> createState() => _ViewCombineScreenState();
}

class _ViewCombineScreenState extends State<ViewCombineScreen> {
  late PageController pageController;
  RxList<dynamic> viewList = [].obs;

  final controller = Get.put(HomeController());

  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController;

  RxInt currentIndex = 0.obs;

  @override
  void initState() {
    super.initState();
    currentIndex.value = widget.index;
    viewList.value = widget.list;
    pageController = PageController(initialPage: widget.index);
    if (viewList[widget.index].toString().contains(".mp4")) {
      loadControllers(viewList[widget.index]);
    }
  }

  bool addListener = false;

  loadControllers(path) async {
    if(mounted){
    print("Video Controller initialized......");
    videoPlayerController = VideoPlayerController.file(File(path));
    await videoPlayerController.initialize().then((value) {
      videoControllerInitialized.value = true;
    });
    initialized.value = true;
    onceInitialized = true;
    print("aspect ratio... ${videoPlayerController.value.aspectRatio}");
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoInitialize: true,
      looping: true,
      allowFullScreen: false,
      allowPlaybackSpeedChanging: false,
      fullScreenByDefault: false,
      showOptions: false,
      showControls: false,
      aspectRatio: videoPlayerController.value.aspectRatio,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(errorMessage),
        );
      },
    );
    videoPlayerController.play();
    chewieController.play();
    if(mounted) {
      setState(() {});
    }
    }
  }
  bool onceInitialized = false;

  disposeControllers() {
    if (initialized.value) {
      if(videoControllerInitialized.value == true){
        videoPlayerController.pause();
        chewieController.pause();
      }
      videoPlayerController.dispose().then((value) {
        videoControllerInitialized.value = false;
      });
      chewieController.dispose();
    }
  }
  RxBool videoControllerInitialized = false.obs;

  RxBool initialized = false.obs;
  // OverlayEntry overlayReady({onTap}) {
  //   OverlayEntry loader = OverlayEntry(builder: (context) {
  //     final size = MediaQuery.of(context).size;
  //     return Positioned(
  //       height: size.height,
  //       width: size.width,
  //       top: 0,
  //       left: 0,
  //       child: GestureDetector(
  //         behavior: HitTestBehavior.opaque,
  //         onTap: onTap,
  //         child: SizedBox(
  //           width: size.width,
  //           height: size.height,
  //         ),
  //       ),
  //     );
  //   });
  //   return loader;
  // }
  //
  // late OverlayEntry loader;

  RxBool fullScreen = false.obs;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        disposeControllers();
        return true;
      },
      child: Obx(() {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: !fullScreen.value
              ? AppBar(
                  backgroundColor: Colors.black,
                  leading: IconButton(
                    onPressed: () {
                      disposeControllers();
                      Get.back();
                    },
                    icon: Icon(Icons.clear),
                  ),
                )
              : null,
          // extendBodyBehindAppBar: true,
          body: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                fullScreen.value = !fullScreen.value;
              },
              child: Obx(() {
                return Padding(
                  padding: EdgeInsets.only(top: fullScreen.value
                      ? 56 : 0),
                  child: PageView.builder(
                      controller: pageController,
                      itemCount: viewList.length,
                      physics: BouncingScrollPhysics(),
                      onPageChanged: (value) async {
                        try{
                          if(mounted) {
                            currentIndex.value = value;
                            if (onceInitialized == true) {
                              if (viewList[value].toString().contains(".mp4")) {
                                initialized.value = false;
                                if (videoControllerInitialized.value == true) {
                                  videoPlayerController.pause();
                                  chewieController.pause();
                                }
                                videoPlayerController.dispose().then((value) {
                                  videoControllerInitialized.value = false;
                                });
                                videoPlayerController =
                                    VideoPlayerController.file(
                                        File(viewList[value]));
                                await videoPlayerController.initialize().then((
                                    value) {
                                  initialized.value = true;
                                  videoControllerInitialized.value = true;
                                });
                                chewieController = ChewieController(
                                  videoPlayerController: videoPlayerController,
                                  autoInitialize: true,
                                  looping: true,
                                  allowFullScreen: false,
                                  allowPlaybackSpeedChanging: false,
                                  fullScreenByDefault: false,
                                  showOptions: false,
                                  showControls: false,
                                  aspectRatio: videoPlayerController.value
                                      .aspectRatio,
                                  errorBuilder: (context, errorMessage) {
                                    return Center(
                                      child: Text(errorMessage),
                                    );
                                  },
                                );
                                videoPlayerController.play();
                                chewieController.play();
                                if(mounted) {
                                  setState(() {
                                  });
                                }
                              } else {
                                if (videoControllerInitialized.value == true) {
                                  videoPlayerController.pause();
                                  chewieController.pause();
                                }
                                videoPlayerController.dispose().then((value) {
                                  videoControllerInitialized.value = false;
                                });
                              }
                            }
                            else {
                              print("Page changed....   " + value.toString());
                              if (viewList[value].toString().contains(".mp4")) {
                                loadControllers(viewList[value]);
                              }
                            }
                          }
                        } catch(e){}
                      },
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return
                          viewList[index].toString().contains(".jpg")
                            ? ViewPhotos(
                                imgPath: viewList[index],
                                fromVideos: true,
                                deleteImage: widget.fromSave,
                              )
                            : videoControllerInitialized.value == true
                                ? VideoView(
                                  videoFile: viewList[index],
                                  chewieController: chewieController,
                                  videoPlayerController: videoPlayerController,
                                  deleteImage: widget.fromSave,
                                )
                                : SizedBox();
                      }),
                );
              }),
            ),
          ),
          bottomNavigationBar: !fullScreen.value
              ? Obx(() {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (!widget.fromSave!)
                            IconButton(
                                onPressed: () {
                                  final File name =
                                      File(viewList[currentIndex.value]);
                                  print(name.path);
                                  name.copy(controller.saveDirectory.value.path + "/" + viewList[currentIndex.value].split("/").last).then((value) {
                                    print("image copied successful");
                                    print(value.path);
                                    if(mounted) {
                                      setState(() {
                                        Fluttertoast.showToast(
                                            msg: "Saved Successfully");
                                      });
                                    }
                                  }).catchError((e) {
                                    throw Exception(e);
                                  });
                                },
                                icon: Icon(
                                  Icons.save_alt,
                                  color: Colors.white,
                                )),
                          if (widget.fromSave!)
                            IconButton(
                                onPressed: () {
                                  final File name =
                                      File(viewList[currentIndex.value]);
                                  print(name.path);
                                  name.delete().then((value) {
                                    print("Deleted Successfully");
                                      Fluttertoast.showToast(msg: "Deleted");
                                      disposeControllers();
                                      Get.back();
                                      Future.delayed(Duration(milliseconds: 600)).then((value) {
                                        controller.savedList.removeAt(currentIndex.value);});
                                      // controller.updateFiles();
                                  }).catchError((e) {
                                    throw Exception(e);
                                  });
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                )),
                          IconButton(
                              onPressed: () {
                                Share.shareFiles(
                                    ['${viewList[currentIndex.value]}'],
                                    text: 'Whatsapp status');
                              },
                              icon: Icon(
                                Icons.share,
                                color: Colors.white,
                              )),
                        ],
                      ),
                      if (controller.loadAd2.value)
                        Container(
                          height: controller.banner2.size.height.toDouble(),
                          width: controller.banner2.size.width.toDouble(),
                          child: AdWidget(
                            ad: controller.banner2,
                          ),
                        )
                    ],
                  );
                })
              : null,
        );
      }),
    );
  }
}

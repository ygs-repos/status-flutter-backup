import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wa_status_saver/ui/recent_screens/recent_screen.dart';
import 'package:wa_status_saver/ui/recent_screens/view_page_screen.dart';
import '../../controllers/home_controller.dart';

class AllVideoScreen extends StatefulWidget {
  const AllVideoScreen({Key? key}) : super(key: key);

  @override
  State<AllVideoScreen> createState() => _AllVideoScreenState();
}

class _AllVideoScreenState extends State<AllVideoScreen> {
  final controller = Get.put(HomeController());

  List<String> saved = [];

  showSaveDialogue() {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            children: <Widget>[
              Center(
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Saved in Gallery',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Text("All selected status have been saved.",
                          style: const TextStyle(
                            fontSize: 16.0,
                          )),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      const Text('FileManager > Pictures > SavedStatus',
                          style: TextStyle(fontSize: 16.0, color: Colors.teal)),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      MaterialButton(
                        child: const Text('Close'),
                        color: Colors.teal,
                        textColor: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<String?> _getImage(videoPathUrl) async {
    Directory tempDir = await getTemporaryDirectory();
    final thumb =
    await VideoThumbnail.thumbnailFile(video: videoPathUrl, quality: 5,thumbnailPath: tempDir.path);
    return thumb;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.videoList.value = controller.whatsappDirectory.value
          .listSync()
          .map((item) => item.path)
          .where((item) {
        return item.endsWith('.mp4');
      }).toList(growable: false);
      saved = controller.saveDirectory.value
          .listSync()
          .map((item) => item.path)
          .where((item) {
        return item.endsWith('.jpg') || item.endsWith('.mp4');
      }).toList(growable: false);
      log(saved.toString());
      if (controller.videoList.length > 0) {
        return Obx(() {
          return Scaffold(
              body: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                      margin: const EdgeInsets.all(8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: .875,
                            maxCrossAxisExtent: 150),
                        itemCount: controller.videoList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String imgPath = controller.videoList[index];
                          return GestureDetector(
                            onTap: () {
                              if (!controller.selectedFilesVideo.isNotEmpty) {
                                Get.to(()=> ViewCombineScreen(list: controller.videoList.value,index: index,));
                              } else {
                                controller.selectedFilesVideo[index].selected!
                                    .value =
                                !controller.selectedFilesVideo[index]
                                    .selected!.value;
                              }
                            },
                            onLongPress: () async {
                              HapticFeedback.vibrate();
                              if (!controller.selectedFilesVideo.isNotEmpty) {
                                controller.selectedFilesVideo.clear();
                                for (var item in controller.videoList) {
                                  controller.selectedFilesVideo.add(
                                      MultiSelectClass(
                                          file: File(item), selected: false.obs));
                                  print(item);
                                }
                                controller.selectedFilesVideo[index].selected!
                                    .value = true;
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: .22),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Obx(() {
                                return Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Obx(() {
                                          return Stack(
                                            children: [
                                              Positioned.fill(
                                                child: Container(
                                                  decoration: const BoxDecoration(
                                                      color: Color(0xffF4F4F2)),
                                                  child: FutureBuilder<String?>(
                                                      future: _getImage(controller
                                                          .videoList[index]),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot
                                                            .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          if (snapshot.hasData) {
                                                            return Hero(
                                                              tag: controller
                                                                  .videoList[
                                                              index],
                                                              child: Image.file(
                                                                File(snapshot
                                                                    .data!),
                                                                fit: BoxFit.cover,
                                                              ),
                                                            );
                                                          } else {
                                                            return const Center(
                                                              child:
                                                              CircularProgressIndicator(),
                                                            );
                                                          }
                                                        } else {
                                                          return Hero(
                                                            tag: controller
                                                                .videoList[index],
                                                            child:
                                                            FractionallySizedBox(
                                                              heightFactor: .8,
                                                              widthFactor: .8,
                                                              child: Image.asset(
                                                                'assets/images/video_loader.gif',
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          );
                                                        }
                                                      }),
                                                  //new cod
                                                ),
                                              ),
                                              Positioned.fill(
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Icon(
                                                      Icons.play_circle,
                                                      color: Colors.white,
                                                      size: 28,
                                                    ),
                                                  ))
                                            ],
                                          );
                                        }),
                                      ),
                                    ),
                                    controller.selectedFilesVideo.isNotEmpty
                                        ? Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      color: Colors.white,
                                      child: Icon(
                                        Icons.check_circle_sharp,
                                        size: 18,
                                        color: controller
                                            .selectedFilesVideo[index]
                                            .selected!
                                            .value
                                            ? Colors.green
                                            : Colors.grey,
                                      ),
                                    )
                                        : InkWell(
                                      onTap: () {
                                        final File name = File(imgPath);
                                        print(name.path);
                                        name
                                            .copy(controller.saveDirectory.value.path +
                                            "/" +
                                            imgPath.split("/").last)
                                            .then((value) {
                                          print("image copied successful");
                                          print(value.path);
                                          setState(() {
                                            Fluttertoast.showToast(
                                                msg: "Saved Successfully");
                                          });
                                        }).catchError((e) {
                                          throw Exception(e);
                                        });
                                      },
                                      child: saved.join("").contains(imgPath.split(".Statuses/").last) ?
                                      Container(
                                        height: 20,
                                        alignment: Alignment.center,
                                        color: Colors.green,
                                        child: Icon(
                                          Icons.download,
                                          size: 18,
                                          color: Colors.white,
                                        ),
                                      ) :
                                      Container(
                                        height: 20,
                                        alignment: Alignment.center,
                                        color: Colors.white,
                                        child: Icon(
                                          Icons.download,
                                          size: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }),
                            ),
                          );
                        },
                      )
                    // child: StaggeredGrid.count(
                    //   crossAxisCount: 4,
                    //   children: [
                    //     ...imageList.map((imgPath) => StaggeredGridTile.count(
                    //           crossAxisCellCount: 2,
                    //           mainAxisCellCount:
                    //               imageList.indexOf(imgPath).isEven ? 2 : 3,
                    //           child: Material(
                    //             elevation: 8.0,
                    //             borderRadius: const BorderRadius.all(Radius.circular(8)),
                    //             child: InkWell(
                    //               onTap: () {
                    //                 Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                     builder: (context) => ViewPhotos(
                    //                       imgPath: imgPath,
                    //                     ),
                    //                   ),
                    //                 );
                    //               },
                    //               child: Hero(
                    //                   tag: imgPath,
                    //                   child: Image.file(
                    //                     File(imgPath),
                    //                     fit: BoxFit.cover,
                    //                   )),
                    //             ),
                    //           ),
                    //         ))
                    //   ],
                    //   mainAxisSpacing: 8.0,
                    //   crossAxisSpacing: 8.0,
                    // ),
                  ),
                ),
              )
          );
        });
      }
      else {
        return noContentMessage(context);
      }
    });
  }

  Scaffold noContentMessage(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * .74,
            child: Image.asset("assets/images/how.png")),
      ),
    );
  }

  Column installWhatsappMessage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          controller.normal == controller.whatsAppType.value
              ? 'Install WhatsApp\n' :
          controller.business == controller.whatsAppType.value
              ? "Install WhatsApp Business"
              : 'Install GB WhatsApp',
          style: TextStyle(fontSize: 15.0),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          controller.normal == controller.whatsAppType.value
              ? "Your Friend's Status Will Be Available Here" :
          controller.business == controller.whatsAppType.value
              ? "Whatsapp business status will be available here"
              : "Whatsapp GB status will be available here",
          style: TextStyle(fontSize: 15.0),
        ),
      ],
    );
  }
}

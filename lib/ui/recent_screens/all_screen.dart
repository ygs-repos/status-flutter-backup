import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wa_status_saver/ui/recent_screens/view_page_screen.dart';

import '../../controllers/home_controller.dart';
import 'recent_screen.dart';

class AllScreen extends StatefulWidget {
  const AllScreen({Key? key}) : super(key: key);

  @override
  State<AllScreen> createState() => _AllScreenState();
}

class _AllScreenState extends State<AllScreen> {
  final controller = Get.put(HomeController());

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
  List<String> saved = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      controller.allList.value = controller.whatsappDirectory.value
          .listSync()
          .map((item) => item.path)
          .where((item) {
        return item.endsWith('.jpg') || item.endsWith('.mp4');
      }).toList(growable: false);
      saved = controller.saveDirectory.value
          .listSync()
          .map((item) => item.path)
          .where((item) {
        return item.endsWith('.jpg') || item.endsWith('.mp4');
      }).toList(growable: false);
      log(controller.allList.toString());
      if (controller.allList.length > 0) {
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
                        itemCount: controller.allList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String imgPath = controller.allList[index];
                          return imgPath.endsWith(".jpg")
                              ? GestureDetector(
                            onTap: () {
                              if (!controller.selectedFilesAll.isNotEmpty) {
                                Get.to(() => ViewCombineScreen(
                                  list: controller.allList.value,
                                  index: index,
                                ));
                              }
                              else {
                                controller.selectedFilesAll[index].selected!
                                    .value =
                                !controller.selectedFilesAll[index]
                                    .selected!.value;
                              }
                            },
                            onLongPress: () async {
                              HapticFeedback.vibrate();
                              if (!controller.selectedFilesAll.isNotEmpty) {
                                controller.selectedFilesAll.clear();
                                for (var item in controller.allList) {
                                  controller.selectedFilesAll.add(
                                      MultiSelectClass(
                                          file: File(item),
                                          selected: false.obs));
                                }
                                controller.selectedFilesAll[index].selected!
                                    .value = true;
                              }
                            },
                            child: Obx(() {
                              return commonImages(index, imgPath);
                            }),
                          )
                              : GestureDetector(
                            onTap: () {
                              if (!controller.selectedFilesAll.isNotEmpty) {
                                Get.to(() => ViewCombineScreen(
                                  list: controller.allList.value,
                                  index: index,
                                ));
                              } else {
                                controller.selectedFilesAll[index].selected!
                                    .value =
                                !controller.selectedFilesAll[index]
                                    .selected!.value;
                              }
                            },
                            onLongPress: () async {
                              HapticFeedback.vibrate();
                              if (!controller.selectedFilesAll.isNotEmpty) {
                                controller.selectedFilesAll.clear();
                                for (var item in controller.allList) {
                                  controller.selectedFilesAll.add(
                                      MultiSelectClass(
                                          file: File(item),
                                          selected: false.obs));
                                }
                                controller.selectedFilesAll[index].selected!
                                    .value = true;
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: .22),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Obx(() {
                                return commonVideo(index, imgPath);
                              }),
                            ),
                          );
                        },
                      )),
                ),
              ),
          );
        });
      }
      else {
        return noContentMessage(context);
      }
    });
  }

  Column commonVideo(int index, String imgPath) {
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
                      decoration: const BoxDecoration(color: Color(0xffF4F4F2)),
                      child: FutureBuilder<String?>(
                          future: _getImage(controller.allList[index]),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                return Hero(
                                  tag: controller.allList[index],
                                  child: Image.file(
                                    File(snapshot.data!),
                                    fit: BoxFit.cover,
                                  ),
                                );
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                            } else {
                              return Hero(
                                tag: controller.allList[index],
                                child: FractionallySizedBox(
                                  heightFactor: .8,
                                  widthFactor: .8,
                                  child: Image.asset(
                                    'assets/images/video_loader.gif',
                                    fit: BoxFit.contain,
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
        controller.selectedFilesAll.isNotEmpty
            ? Container(
                height: 20,
                alignment: Alignment.center,
                color: Colors.white,
                child: Icon(
                  Icons.check_circle_sharp,
                  size: 18,
                  color: controller.selectedFilesAll[index].selected!.value
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
                    setState(() {
                      Fluttertoast.showToast(
                          msg: "Saved Successfully");
                    });
                    print(name.path);
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
  }

  Container commonImages(int index, String imgPath) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: .22),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                width: double.maxFinite,
                child: Image.file(
                  File(controller.allList[index]),
                  fit: BoxFit.cover,
                  filterQuality: FilterQuality.medium,
                ),
              ),
            ),
          ),
          controller.selectedFilesAll.isNotEmpty
              ? Container(
                  height: 20,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Icon(
                    Icons.check_circle_sharp,
                    size: 18,
                    color: controller.selectedFilesAll[index].selected!.value
                        ? Colors.green
                        : Colors.grey,
                  ),
                )
              : InkWell(
                  onTap: () {
                    final File name = File(imgPath);
                    print(name.path);
                    name.copy(controller.saveDirectory.value.path + "/" + imgPath.split("/").last).then((value) {
                      print("image copied successful");
                      setState(() {
                        Fluttertoast.showToast(
                            msg: "Saved Successfully");
                      });
                      print(name.path);
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
      ),
    );
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
              ? 'Install WhatsApp\n'
              : controller.business == controller.whatsAppType.value
                  ? "Install WhatsApp Business"
                  : 'Install GB WhatsApp',
          style: TextStyle(fontSize: 15.0),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          controller.normal == controller.whatsAppType.value
              ? "Your Friend's Status Will Be Available Here"
              : controller.business == controller.whatsAppType.value
                  ? "Whatsapp business status will be available here"
                  : "Whatsapp GB status will be available here",
          style: TextStyle(fontSize: 15.0),
        ),
      ],
    );
  }
}

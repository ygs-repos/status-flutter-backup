import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wa_status_saver/controllers/home_controller.dart';
import 'package:wa_status_saver/ui/recent_screens/view_page_screen.dart';

class SavedStatus extends StatefulWidget {
  const SavedStatus({Key? key}) : super(key: key);
  @override
  SavedStatusState createState() => SavedStatusState();
}

class SavedStatusState extends State<SavedStatus> {
  final controller = Get.put(HomeController());
  createDirectory() async {
    if(!Directory('${controller.saveDirectory.value.path}').existsSync()) {
      await Directory('${controller.saveDirectory.value.path}')
          .create(recursive: false)
          .then((value) {
        print("directory created successfully");
        print(value.path.toString());
      }).catchError((e) {
        throw Exception(e);
      });
    }
  }

  Future<String?> _getImage(videoPathUrl) async {
    if (mounted) {
      Directory tempDir = await getTemporaryDirectory();
      final thumb =
          await VideoThumbnail.thumbnailFile(video: videoPathUrl, quality: 5,thumbnailPath: tempDir.path);
      return thumb;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    directoryExist = Directory('${controller.saveDirectory.value.path}').existsSync();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      createDirectory();
    });
  }

  bool directoryExist = false;

  @override
  Widget build(BuildContext context) {
      if (!directoryExist) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Install WhatsApp\n',
              style: TextStyle(fontSize: 18.0),
            ),
            const Text(
              "Your Friend's Status Will Be Available Here",
              style: TextStyle(fontSize: 18.0),
            ),
          ],
        );
      }
      else {
        controller.savedList.value =
            Directory('${controller.saveDirectory.value.path}')
                .listSync()
                .map((item) => item.path)
                .where((item) {
              return item.endsWith('.jpg') || item.endsWith('.mp4');
            })
                .toList(growable: false)
                .reversed
                .toList();
        if (controller.savedList.length > 0) {
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
                margin: const EdgeInsets.all(8.0),
                child: GridView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        crossAxisCount: 3),
                    itemCount: controller.savedList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final String imgPath = controller.savedList[index];
                      return imgPath.endsWith(".jpg")
                          ? GestureDetector(
                        onTap: () {
                          Get.to(() => ViewCombineScreen(
                            list: controller.savedList,
                            index: index,
                            fromSave: true,
                          ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: .22),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(
                              File(controller.savedList[index]),
                              fit: BoxFit.cover,
                              filterQuality: FilterQuality.medium,
                            ),
                          ),
                        ),
                      )
                          : InkWell(
                        onTap: () => Get.to(() => ViewCombineScreen(
                          list: controller.savedList,
                          index: index,
                          fromSave: true,
                        )),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(width: .22),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Color(0xffF4F4F2)),
                                    child: FutureBuilder<String?>(
                                        future: _getImage(imgPath),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            if (snapshot.hasData) {
                                              return Image.file(
                                                File(snapshot.data!),
                                                fit: BoxFit.cover,
                                              );
                                            } else {
                                              return const Center(
                                                child:
                                                CircularProgressIndicator(),
                                              );
                                            }
                                          } else {
                                            return FractionallySizedBox(
                                              heightFactor: .8,
                                              widthFactor: .8,
                                              child: Image.asset(
                                                  'assets/images/video_loader.gif'),
                                            );
                                          }
                                        }),
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
                            ),
                          ),
                        ),
                      );
                    },
                  )
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 14),
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * .35,
                        child: Image.asset("assets/images/nothing.png")),
                  ),
                  Container(
                    // padding: const EdgeInsets.only(bottom: 60.0),
                      child: Text(
                        'You have not saved any status yet!',
                        style: TextStyle(fontSize: 14.0, color: Colors.grey.shade600),
                      ))
                ],
              ),
            ),
          );
        }
      }
  }
}

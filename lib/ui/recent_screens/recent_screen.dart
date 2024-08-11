import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wa_status_saver/controllers/home_controller.dart';
import 'all_screen.dart';
import 'images.dart';
import 'video.dart';

class RecentScreen extends StatefulWidget {
  const RecentScreen({Key? key}) : super(key: key);
  @override
  RecentScreenState createState() => RecentScreenState();
}

class RecentScreenState extends State<RecentScreen>
    with TickerProviderStateMixin {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size(double.maxFinite, 50),
            child: Obx(() {
              return IgnorePointer(
                ignoring: controller.selectedFilesAll.isNotEmpty ||
                        controller.selectedFilesImage.isNotEmpty ||
                        controller.selectedFilesVideo.isNotEmpty
                    ? true
                    : false,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: TabBar(
                      unselectedLabelColor: Colors.grey.shade700,
                      labelColor: Colors.teal,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorPadding: EdgeInsets.zero,
                      isScrollable: true,
                      indicator: BoxDecoration(),
                      physics: BouncingScrollPhysics(),
                      labelStyle: GoogleFonts.lato(
                        fontWeight: FontWeight.w900,
                        color: Colors.teal,
                        height: 0,
                        fontSize: 16,
                      ),
                      unselectedLabelStyle: GoogleFonts.lato(
                          fontWeight: FontWeight.w400, fontSize: 16),
                      padding: EdgeInsets.symmetric(horizontal: 14),
                      indicatorWeight: .01,
                      tabs: [
                        Tab(
                          text: "All",
                        ),
                        Tab(
                          text: "Images",
                        ),
                        Tab(
                          text: "Videos",
                        ),
                        // Container(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: const Text(
                        //     'IMAGES',
                        //   ),
                        // ),
                        // Container(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: const Text(
                        //     'VIDEOS',
                        //   ),
                        // ),
                        // Container(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: const Text(
                        //     'Saved',
                        //   ),
                        // ),
                      ]),
                ),
              );
            }),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Text(
                  "The status files will be 24 hours after published. Please download and watch on saved page.",
                  style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                )),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  AllScreen(),
                  AllImagesScreen(),
                  AllVideoScreen(),
                ],
              ),
            ),
          ],
        ),
        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.only(bottom: 10),
        //   child: TabBar(
        //       unselectedLabelColor: Colors.grey.shade700,
        //       labelColor: Colors.green.shade500,
        //       indicatorSize: TabBarIndicatorSize.tab,
        //       indicatorPadding: EdgeInsets.zero,
        //       indicator: UnderlineTabIndicator(
        //           borderSide: BorderSide(
        //             width: 0,
        //             color: Colors.green.shade500,
        //           ),
        //           insets: EdgeInsets.symmetric(
        //               horizontal: MediaQuery
        //                   .of(context)
        //                   .size
        //                   .width * .12)),
        //       labelStyle: GoogleFonts.lato(
        //         fontWeight: FontWeight.w900,
        //         fontSize: 16,
        //       ),
        //       unselectedLabelStyle: GoogleFonts.lato(
        //           fontWeight: FontWeight.w400, fontSize: 16),
        //       padding: EdgeInsets.symmetric(horizontal: 14),
        //       indicatorWeight: .01,
        //       tabs: [
        //         Tab(
        //           text: "All",
        //         ),
        //         Tab(
        //           text: "Images",
        //         ),
        //         Tab(
        //           text: "Videos",
        //         ),
        //         // Container(
        //         //   padding: const EdgeInsets.all(12.0),
        //         //   child: const Text(
        //         //     'IMAGES',
        //         //   ),
        //         // ),
        //         // Container(
        //         //   padding: const EdgeInsets.all(12.0),
        //         //   child: const Text(
        //         //     'VIDEOS',
        //         //   ),
        //         // ),
        //         // Container(
        //         //   padding: const EdgeInsets.all(12.0),
        //         //   child: const Text(
        //         //     'Saved',
        //         //   ),
        //         // ),
        //       ]),
        // ),
      ),
    );
    /*return Obx(() {
      if (!Directory('${controller.whatsappDirectory.value.path}')
          .existsSync()) {
        return installWhatsappMessage();
      } else {
        controller.recentList.value = controller.whatsappDirectory.value
            .listSync()
            .map((item) => item.path)
            .where((item) {
          return item.endsWith('.jpg') || item.endsWith('.mp4');
        }).toList(growable: false);
        if (controller.recentList.length > 0) {
          return Obx(() {
            return Scaffold(
                body: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Text(
                              "The status files will be 24 hours after published. Please download and watch on saved page.",
                              style: TextStyle(
                                  color: Colors.grey.shade400,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            )),
                        Container(
                            margin: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              key: PageStorageKey(widget.key),
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                      crossAxisSpacing: 12,
                                      mainAxisSpacing: 12,
                                      maxCrossAxisExtent: 150),
                              itemCount: controller.recentList.length,
                              itemBuilder: (BuildContext context, int index) {
                                final String imgPath =
                                    controller.recentList[index];
                                return imgPath.endsWith(".jpg")
                                    ? GestureDetector(
                                        onTap: () {
                                          if (!controller.multiSelect.value) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ViewPhotos(
                                                  imgPath: imgPath,
                                                ),
                                              ),
                                            );
                                          } else {
                                            controller.selectedFiles[index]
                                                    .selected!.value =
                                                !controller.selectedFiles[index]
                                                    .selected!.value;
                                          }
                                        },
                                        onLongPress: () async {
                                          HapticFeedback.vibrate();
                                          if (!controller.multiSelect.value) {
                                            controller.multiSelect.value = true;
                                            controller.selectedFiles.clear();
                                            for (var item
                                                in controller.recentList) {
                                              controller.selectedFiles.add(
                                                  MultiSelectClass(
                                                      file: File(item),
                                                      selected: false.obs));
                                              print(item);
                                            }
                                            controller.selectedFiles[index]
                                                .selected!.value = true;
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(width: .22),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Obx(() {
                                              return Stack(
                                                children: [
                                                  Positioned.fill(
                                                    child: Image.file(
                                                      File(controller
                                                          .recentList[index]),
                                                      fit: BoxFit.cover,
                                                      filterQuality:
                                                          FilterQuality.medium,
                                                    ),
                                                  ),
                                                  if (controller
                                                      .multiSelect.value)
                                                    Positioned(
                                                        child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 4,
                                                                      right: 4),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: controller
                                                                          .selectedFiles[
                                                                              index]
                                                                          .selected!
                                                                          .value
                                                                      ? Colors
                                                                          .white
                                                                      : null),
                                                              child: Icon(
                                                                Icons
                                                                    .check_circle_sharp,
                                                                size: 28,
                                                                color: controller
                                                                        .selectedFiles[
                                                                            index]
                                                                        .selected!
                                                                        .value
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .white,
                                                              ),
                                                            ))),
                                                ],
                                              );
                                            }),
                                          ),
                                        ),
                                      )
                                    : GestureDetector(
                                        onTap: () {
                                          if (!controller.multiSelect.value) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    PlayStatus(
                                                  videoFile: controller
                                                      .recentList[index],
                                                ),
                                              ),
                                            );
                                          } else {
                                            controller.selectedFiles[index]
                                                    .selected!.value =
                                                !controller.selectedFiles[index]
                                                    .selected!.value;
                                          }
                                        },
                                        onLongPress: () async {
                                          HapticFeedback.vibrate();
                                          if (!controller.multiSelect.value) {
                                            controller.multiSelect.value = true;
                                            controller.selectedFiles.clear();
                                            for (var item
                                                in controller.recentList) {
                                              controller.selectedFiles.add(
                                                  MultiSelectClass(
                                                      file: File(item),
                                                      selected: false.obs));
                                              print(item);
                                            }
                                            controller.selectedFiles[index]
                                                .selected!.value = true;
                                          }
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(width: .22),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            child: Obx(() {
                                              return Stack(
                                                children: [
                                                  Positioned.fill(
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: Color(
                                                                  0xffF4F4F2)),
                                                      child: FutureBuilder<
                                                              String?>(
                                                          future: _getImage(
                                                              controller
                                                                      .recentList[
                                                                  index]),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .done) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                return Hero(
                                                                  tag: controller
                                                                          .recentList[
                                                                      index],
                                                                  child: Image
                                                                      .file(
                                                                    File(snapshot
                                                                        .data!),
                                                                    fit: BoxFit
                                                                        .cover,
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
                                                                        .recentList[
                                                                    index],
                                                                child:
                                                                    FractionallySizedBox(
                                                                  heightFactor:
                                                                      .8,
                                                                  widthFactor:
                                                                      .8,
                                                                  child: Image
                                                                      .asset(
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
                                                  if (controller
                                                      .multiSelect.value)
                                                    Positioned(
                                                        child: Align(
                                                            alignment: Alignment
                                                                .topRight,
                                                            child: Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      top: 4,
                                                                      right: 4),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: controller
                                                                          .selectedFiles[
                                                                              index]
                                                                          .selected!
                                                                          .value
                                                                      ? Colors
                                                                          .white
                                                                      : null),
                                                              child: Icon(
                                                                Icons
                                                                    .check_circle_sharp,
                                                                size: 28,
                                                                color: controller
                                                                        .selectedFiles[
                                                                            index]
                                                                        .selected!
                                                                        .value
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .white,
                                                              ),
                                                            ))),
                                                  if (!controller
                                                      .multiSelect.value)
                                                    Positioned.fill(
                                                        child: Align(
                                                      alignment:
                                                          Alignment.center,
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
                      ],
                    ),
                  ),
                ),
                floatingActionButton: controller.multiSelect.value
                    ? FloatingActionButton(
                        onPressed: () async {
                          bool chosen = false;
                          for (var item in controller.selectedFiles) {
                            if (item.selected!.value) {
                              if (chosen == false) {
                                showSaveDialogue();
                              }
                              chosen = true;
                              await item.file
                                  .copy(controller.saveDirectory.value.path +
                                      "/" +
                                      item.file.path.split("/").last)
                                  .catchError((e) {
                                throw Exception(e);
                              });
                            }
                          }
                          if (!chosen) {
                            Fluttertoast.showToast(msg: "Please select any");
                          } else {
                            controller.multiSelect.value = false;
                            controller.selectedFiles.clear();
                          }
                        },
                        child: Icon(Icons.save),
                      )
                    : null);
          });
        } else {
          return noContentMessage(context);
        }
      }
    })*/
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

class MultiSelectClass {
  final File file;
  RxBool? selected = false.obs;
  MultiSelectClass({required this.file, this.selected});
}

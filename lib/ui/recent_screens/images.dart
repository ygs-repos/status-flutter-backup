import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:wa_status_saver/ui/recent_screens/recent_screen.dart';
import 'package:wa_status_saver/ui/recent_screens/view_page_screen.dart';
import '../../controllers/home_controller.dart';

class AllImagesScreen extends StatefulWidget {
  const AllImagesScreen({Key? key}) : super(key: key);

  @override
  State<AllImagesScreen> createState() => _AllImagesScreenState();
}

class _AllImagesScreenState extends State<AllImagesScreen> {
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
    return Obx(() {
      controller.imageList.value = controller.whatsappDirectory.value
          .listSync()
          .map((item) => item.path)
          .where((item) {
        return item.endsWith('.jpg');
      }).toList(growable: false);
      List<String> saved = controller.saveDirectory.value
          .listSync()
          .map((item) => item.path)
          .where((item) {
        return item.endsWith('.jpg');
      })
          .toList(growable: false);

      log(saved.toString());
      if (controller.imageList.length > 0) {
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
                        itemCount: controller.imageList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final String imgPath = controller.imageList[index];
                          return GestureDetector(
                            onTap: () {
                              if (!controller.selectedFilesImage.isNotEmpty) {
                                Get.to(() => ViewCombineScreen(
                                  list: controller.imageList.value,
                                  index: index,
                                ));
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => ViewPhotos(
                                //       imgPath: imgPath,
                                //     ),
                                //   ),
                                // );
                              } else {
                                controller.selectedFilesImage[index].selected!
                                    .value =
                                !controller.selectedFilesImage[index]
                                    .selected!.value;
                              }
                            },
                            onLongPress: () async {
                              HapticFeedback.vibrate();
                              if (!controller.selectedFilesImage.isNotEmpty) {
                                controller.selectedFilesImage.clear();
                                for (var item in controller.imageList) {
                                  controller.selectedFilesImage.add(
                                      MultiSelectClass(
                                          file: File(item), selected: false.obs));
                                  print(item);
                                }
                                controller.selectedFilesImage[index].selected!
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
                                        child: Image.file(
                                          File(controller.imageList[index]),
                                          fit: BoxFit.cover,
                                          filterQuality: FilterQuality.medium,
                                          width: double.maxFinite,
                                        ),
                                      ),
                                    ),
                                    controller.selectedFilesImage.isNotEmpty
                                        ? Container(
                                      height: 20,
                                      alignment: Alignment.center,
                                      color: Colors.white,
                                      child: Icon(
                                        Icons.check_circle_sharp,
                                        size: 18,
                                        color: controller
                                            .selectedFilesImage[index]
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
                                            .copy(controller.saveDirectory
                                            .value.path +
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
                              }),
                            ),
                          );
                        },
                      )
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

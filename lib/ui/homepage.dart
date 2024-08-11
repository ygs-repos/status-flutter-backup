import 'dart:developer';
import 'dart:io';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:wa_status_saver/controllers/home_controller.dart';
import 'package:wa_status_saver/ui/drawer_screens/how_to_use.dart';
import 'package:wa_status_saver/ui/recent_screens/recent_screen.dart';
import 'package:wa_status_saver/ui/saved_screen.dart';
import 'package:wa_status_saver/ui/subscription_screen.dart';
import 'package:wa_status_saver/ui/tools/tools.dart';
import 'package:whatsapp_share2/whatsapp_share2.dart';
import 'drawer_screens/drawer.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> with TickerProviderStateMixin {
  final controller = Get.put(HomeController());

  late TabController tabController;

  void launchWhatsApp() async {
    await LaunchApp.openApp(androidPackageName: controller.launcherUrl, openStore: false);
  }

  RxString temp = "".obs;

  showOptionDialogue() {
    temp.value = controller.whatsAppType.value;
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.symmetric(horizontal: 17),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              padding: EdgeInsets.all(18),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Save Status From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Obx(() {
                    return ListTile(
                      minVerticalPadding: 0,
                      minLeadingWidth: 0,
                      onTap: () {
                        temp.value = controller.normal;
                        // controller.switchToNormal();
                        // Future.delayed(Duration(milliseconds: 800))
                        //     .then((value) {
                        //   setState(() {});
                        // });
                      },
                      selected: controller.normal == temp.value,
                      selectedTileColor: Colors.teal.shade50.withOpacity(.8),
                      title: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            // fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: controller.normal == temp.value,
                            shape: CircleBorder(),
                            onChanged: (bool? value) {
                              // setState(() {
                              //   isChecked = value!;
                              // });
                            },
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                              width: 19,
                              height: 19,
                              child: SvgPicture.asset(
                                "assets/images/whatsapp-normal.svg",
                              )),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            "Whatsapp Status",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          )
                        ],
                      ),
                    );
                  }),
                  Obx(() {
                    return ListTile(
                      minVerticalPadding: 0,
                      minLeadingWidth: 0,
                      onTap: () {
                        temp.value = controller.business;
                        // controller.switchToBusiness();
                        // Future.delayed(Duration(milliseconds: 800))
                        //     .then((value) {
                        //   setState(() {});
                        // });
                      },
                      selected: controller.business == temp.value,
                      selectedTileColor: Colors.teal.shade50.withOpacity(.8),
                      title: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            // fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: controller.business == temp.value,
                            shape: CircleBorder(),
                            onChanged: (bool? value) {
                              // setState(() {
                              //   isChecked = value!;
                              // });
                            },
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: SvgPicture.asset(
                                "assets/images/whatsapp-business.svg",
                                fit: BoxFit.cover,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "WABusiness Status",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          )
                        ],
                      ),
                    );
                  }),
                  Obx(() {
                    return ListTile(
                      minVerticalPadding: 0,
                      minLeadingWidth: 0,
                      onTap: () {
                        temp.value = controller.gbWhatsapp;
                        // controller.switchToGbWhatsapp();
                        // Future.delayed(Duration(milliseconds: 800))
                        //     .then((value) {
                        //   setState(() {});
                        // });
                      },
                      selected: controller.gbWhatsapp == temp.value,
                      selectedTileColor: Colors.teal.shade50.withOpacity(.8),
                      title: Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            // fillColor: MaterialStateProperty.resolveWith(getColor),
                            value: controller.gbWhatsapp == temp.value,
                            shape: CircleBorder(),
                            onChanged: (bool? value) {
                              // setState(() {
                              //   isChecked = value!;
                              // });
                            },
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          SizedBox(
                              width: 24,
                              height: 24,
                              child: Image.asset(
                                "assets/images/gb.png",
                                fit: BoxFit.contain,
                              )),
                          SizedBox(
                            width: 11,
                          ),
                          Text(
                            "GBBusiness Status",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15),
                          )
                        ],
                      ),
                    );
                  }),
                  SizedBox(
                    height: 6,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        if (temp.value == controller.normal) {
                          controller.switchToNormal(context);
                        } else if (temp.value == controller.business) {
                          controller.switchToBusiness(context);
                        } else if (temp.value == controller.gbWhatsapp) {
                          controller.switchToGbWhatsapp(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.greenAccent.shade700,
                          padding: EdgeInsets.symmetric(horizontal: 40)),
                      child: Text(
                        "Confirm",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ))
                ],
              ),
            ),
          );
        });
  }

  AppOpenAd? myAppOpenAd;

  loadAppOpenAd() {
    AppOpenAd.load(
        adUnitId:
            "ca-app-pub-3940256099942544/3419835294", //Your ad Id from admob
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
          myAppOpenAd = ad;
          myAppOpenAd!.show();
        }, onAdFailedToLoad: (error) {
          log("Open App Ad load failed.... $error");
        }),
        orientation: AppOpenAd.orientationPortrait);
  }

  late BannerAd banner1;

  int tabIndex = 0;
  int tabIndex1 = 0;

  showBottomSheetAd() {
    Fluttertoast.showToast(msg: "Press again to Exit");
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            // if(exit == true){
            //   SystemNavigator.pop();
            // }
            return true;
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: banner1.size.height.toDouble(),
                width: banner1.size.width.toDouble(),
                child: AdWidget(
                  ad: banner1,
                ),
              ),
              SizedBox(
                height: 14,
              ),
              ElevatedButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.maxFinite, 50),
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  child: Text(
                    "Press Again To Exit",
                    style: TextStyle(fontSize: 16),
                  ))
            ],
          ),
        );
      },
    );
  }

  bool exit = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    if(controller.haveUserPermission.value) {
      loadAppOpenAd();
    }
    tabController.addListener(() {
      tabIndex1 = tabController.index;
      if (tabIndex1 != tabIndex) {
        tabIndex = tabController.index;
        controller.adCount.value++;
        if (controller.adCount.value > controller.adCountShow.value) {
          controller.loadAdInter(context);
          controller.adCount.value = 0;
        }
      }
    });
    controller.loadAdd();
    loadAdd1();
  }

  loadAdd1() async {
    banner1 = BannerAd(
        size: AdSize.largeBanner,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: BannerAdListener(
            onAdLoaded: (value) {
              if(mounted) {
                setState(() {
                });
              }
            },
            onAdFailedToLoad: (ad, error) {}),
        request: AdRequest());
    await banner1.load();
  }

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
    return WillPopScope(
      onWillPop: () async {
        if (controller.selectedFilesAll.isNotEmpty ||
            controller.selectedFilesImage.isNotEmpty ||
            controller.selectedFilesVideo.isNotEmpty) {
          controller.selectedFilesAll.clear();
          controller.selectedFilesImage.clear();
          controller.selectedFilesVideo.clear();
          return false;
        } else {
          showBottomSheetAd();
          Future.delayed(Duration(seconds: 4)).then((value) {
            exit = false;
          });
          if (exit == true) {
            SystemNavigator.pop();
          }
          if (exit == false) {
            exit = true;
          }
          return false;
        }
      },
      child: Obx(() {
        return Scaffold(
          key: controller.scaffoldKey,
          appBar: controller.selectedFilesAll.isNotEmpty ||
                  controller.selectedFilesImage.isNotEmpty ||
                  controller.selectedFilesVideo.isNotEmpty
              ? multiSelectAppBar(context)
              : normalAppBar(context),
          drawer: controller.selectedFilesAll.isNotEmpty ||
                  controller.selectedFilesImage.isNotEmpty ||
                  controller.selectedFilesVideo.isNotEmpty
              ? null
              : DrawerScreen(),
          body: TabBarView(
            physics: controller.selectedFilesAll.isNotEmpty ||
                    controller.selectedFilesImage.isNotEmpty ||
                    controller.selectedFilesVideo.isNotEmpty
                ? NeverScrollableScrollPhysics()
                : AlwaysScrollableScrollPhysics(),
            controller: tabController,
            children: [
              if (controller.haveUserPermission.value && controller.loadingPermissions.value) ...[
                RecentScreen(),
                SavedStatus(),
              ],
              if (!controller.haveUserPermission.value && controller.loadingPermissions.value) ...[
                noPermissionCard(context),
                noPermissionCard(context),
              ],
              if(!controller.loadingPermissions.value)...[
                SizedBox(),
                SizedBox()
              ],
              ToolScreen(),
            ],
          ),
          bottomNavigationBar: controller.loadAd.value
              ? Container(
                  height: controller.banner.size.height.toDouble(),
                  width: controller.banner.size.width.toDouble(),
                  child: AdWidget(
                    ad: controller.banner,
                  ),
                )
              : null,
        );
      }),
    );
  }

  Column noPermissionCard(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        SizedBox(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * .4,
            child: Lottie.asset('assets/images/lotti.json')),
        Text(
          "Dear User,\n\nSince Android 11, you\nneed to manually allow\nStorage Permission.",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: 15,
        ),
        ElevatedButton(
            onPressed: () {
              controller.getStoragePermission();
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent.shade700,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25)),
            child: Text(
              "Allow",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ))
      ],
    );
  }

  AppBar normalAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 50,
      leading: leadingIcon(),
      elevation: 0,
      title: titleButton(),
      backgroundColor: Colors.white,
      actions: [
        GestureDetector(
            onTap: () {
              launchWhatsApp();
            },
            child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  "assets/images/whatsapp.svg",
                ))),
        SizedBox(
          width: 15,
        ),
        GestureDetector(
            onTap: () {
              Get.to(() => SubscriptionScreen());
              // controller.kk();
            },
            child: SizedBox(
                width: 24,
                height: 24,
                child: SvgPicture.asset(
                  "assets/images/premium.svg",
                ))),
        SizedBox(
          width: 15,
        ),
        GestureDetector(
          onTap: () {
            Get.to(HowToUseScreen());
          },
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.yellow.shade500,
                    Colors.yellow.shade600,
                    Colors.yellow.shade700,
                    Colors.yellow.shade800,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )),
            padding: EdgeInsets.all(3),
            child: Icon(
              Icons.question_mark,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
        SizedBox(
          width: 15,
        ),
      ],
      bottom: TabBar(
          controller: tabController,
          unselectedLabelColor: Colors.grey.shade700,
          labelColor: Colors.green.shade500,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorPadding: EdgeInsets.zero,
          indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 1.8,
                color: Colors.green.shade500,
              ),
              insets: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .12)),
          labelStyle: GoogleFonts.lato(
            fontWeight: FontWeight.w900,
            fontSize: 16,
          ),
          unselectedLabelStyle:
              GoogleFonts.lato(fontWeight: FontWeight.w400, fontSize: 16),
          padding: EdgeInsets.symmetric(horizontal: 14),
          indicatorWeight: .01,
          tabs: [
            Tab(
              text: "Recent",
            ),
            Tab(
              text: "Saved",
            ),
            Tab(
              text: "Tools",
            ),
          ]),
    );
  }

  AppBar multiSelectAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 50,
      leading: IconButton(
        onPressed: () {
          controller.selectedFilesAll.clear();
          controller.selectedFilesImage.clear();
          controller.selectedFilesVideo.clear();
        },
        icon: Icon(
          Icons.clear,
          color: Colors.black,
        ),
      ),
      elevation: 0,
      title: Text(
        "${(controller.selectedFilesAll.map((element) => element.selected!.value == true).toList().where((element) => element == true).length + controller.selectedFilesImage.map((element) => element.selected!.value == true).toList().where((element) => element == true).length + controller.selectedFilesVideo.map((element) => element.selected!.value == true).toList().where((element) => element == true).length)}",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      actions: [
        IconButton(
            onPressed: () {
              if (controller.selectedFilesAll.isNotEmpty) {
                controller.selectedFilesAll.forEach((element) {
                  element.selected!.value = true;
                });
              }
              if (controller.selectedFilesImage.isNotEmpty) {
                controller.selectedFilesImage.forEach((element) {
                  element.selected!.value = true;
                });
              }
              if (controller.selectedFilesVideo.isNotEmpty) {
                controller.selectedFilesVideo.forEach((element) {
                  element.selected!.value = true;
                });
              }
              Fluttertoast.showToast(msg: "All Selected");
            },
            icon: Icon(
              Icons.select_all_rounded,
              color: Colors.black,
            )),
        IconButton(
            onPressed: () async {
              await WhatsappShare.shareFile(
                text: 'Whatsapp share text',
                phone: '91xxxxxxxxxx',
                filePath: [
                  ...controller.selectedFilesAll
                      .where((element) => element.selected!.value == true)
                      .toList()
                      .map((e) => e.file.path)
                      .toList(),
                  ...controller.selectedFilesImage
                      .where((element) => element.selected!.value == true)
                      .toList()
                      .map((e) => e.file.path)
                      .toList(),
                  ...controller.selectedFilesVideo
                      .where((element) => element.selected!.value == true)
                      .toList()
                      .map((e) => e.file.path)
                      .toList(),
                ],
              );
            },
            icon: Icon(
              Icons.whatshot,
              color: Colors.black,
            )),
        IconButton(
            onPressed: () {
              Share.shareFiles([
                ...controller.selectedFilesAll
                    .where((element) => element.selected!.value == true)
                    .toList()
                    .map((e) => e.file.path)
                    .toList(),
                ...controller.selectedFilesImage
                    .where((element) => element.selected!.value == true)
                    .toList()
                    .map((e) => e.file.path)
                    .toList(),
                ...controller.selectedFilesVideo
                    .where((element) => element.selected!.value == true)
                    .toList()
                    .map((e) => e.file.path)
                    .toList(),
              ], text: 'Whatsapp status');
            },
            icon: Icon(
              Icons.share,
              color: Colors.black,
            )),
        IconButton(
            onPressed: () async {
              List<File> allMightyList = [
                ...controller.selectedFilesAll
                    .where((element) => element.selected!.value == true)
                    .toList()
                    .map((e) => e.file)
                    .toList(),
                ...controller.selectedFilesImage
                    .where((element) => element.selected!.value == true)
                    .toList()
                    .map((e) => e.file)
                    .toList(),
                ...controller.selectedFilesVideo
                    .where((element) => element.selected!.value == true)
                    .toList()
                    .map((e) => e.file)
                    .toList(),
              ];
              if (allMightyList.length != 0) {
                showSaveDialogue();
                for (var item in allMightyList) {
                  print("Don't worry bro saving these files for you...");
                  await item
                      .copy(controller.saveDirectory.value.path +
                          "/" +
                          item.path.split("/").last)
                      .catchError((e) {
                    throw Exception(e);
                  });
                }
                controller.selectedFilesAll.clear();
                controller.selectedFilesImage.clear();
                controller.selectedFilesVideo.clear();
                if(mounted) {
                  setState(() {
                  });
                }
              } else {
                Fluttertoast.showToast(msg: "Please select any");
              }
            },
            icon: Icon(
              Icons.file_download_rounded,
              color: Colors.black,
            )),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(45),
        child: Obx(() {
          return IgnorePointer(
            ignoring: controller.selectedFilesAll.isNotEmpty ||
                    controller.selectedFilesImage.isNotEmpty ||
                    controller.selectedFilesVideo.isNotEmpty
                ? true
                : false,
            child: TabBar(
                controller: tabController,
                physics: controller.selectedFilesAll.isNotEmpty ||
                        controller.selectedFilesImage.isNotEmpty ||
                        controller.selectedFilesVideo.isNotEmpty
                    ? NeverScrollableScrollPhysics()
                    : AlwaysScrollableScrollPhysics(),
                unselectedLabelColor: Colors.grey.shade700,
                labelColor: Colors.green.shade500,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorPadding: EdgeInsets.zero,
                indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(
                      width: 1.8,
                      color: Colors.green.shade500,
                    ),
                    insets: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * .12)),
                labelStyle: GoogleFonts.lato(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
                unselectedLabelStyle:
                    GoogleFonts.lato(fontWeight: FontWeight.w400, fontSize: 16),
                padding: EdgeInsets.symmetric(horizontal: 14),
                indicatorWeight: .01,
                tabs: [
                  Tab(
                    text: "Recent",
                  ),
                  Tab(
                    text: "Saved",
                  ),
                  Tab(
                    text: "Tools",
                  ),
                ]),
          );
        }),
      ),
    );
  }

  GestureDetector titleButton() {
    return GestureDetector(
      onTap: () {
        showOptionDialogue();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Obx(() {
            return Text(
              controller.titleText.value,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            );
          }),
          Icon(
            Icons.arrow_drop_down_outlined,
            color: Colors.black,
          )
        ],
      ),
    );
  }

  IconButton leadingIcon() {
    return IconButton(
      onPressed: () {
        controller.scaffoldKey.currentState!.openDrawer();
        controller.adCount.value++;
      },
      icon: Container(
        decoration: BoxDecoration(color: Colors.transparent),
        height: 13,
        width: 20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FractionallySizedBox(
              widthFactor: .5,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black,
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: .75,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              height: 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

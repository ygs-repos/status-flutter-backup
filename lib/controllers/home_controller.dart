import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ui/recent_screens/recent_screen.dart';

class HomeController extends GetxController {

  RxBool haveUserPermission = false.obs;
  RxBool loadingPermissions = false.obs;

  getStoragePermission() async {
    if(await Permission.storage.isGranted == false || await Permission.manageExternalStorage.isGranted == false){
      Permission.manageExternalStorage.request().then((value) {
        loadingPermissions.value = true;
        if(value.isGranted){
          haveUserPermission.value = true;
        }
      });
    } else {
      loadingPermissions.value = true;
      haveUserPermission.value = true;
    }
  }

  // whatsapp Directory
  final Rx<Directory> whatsappDirectory = Directory('/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses').obs;
  String normal = '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses';
  String business = '/storage/emulated/0/Android/media/com.whatsapp.w4b/WhatsApp Business/Media/.Statuses';
  String gbWhatsapp = "/storage/emulated/0/Android/media/com.gbwhatsapp/GBWhatsApp/Media/.Statuses";


  // Save Directory
  final Rx<Directory> saveDirectory = Directory('/storage/emulated/0/Pictures/Status_Saver/Whatsapp').obs;
  String normalSave = '/storage/emulated/0/Pictures/Status_Saver/Whatsapp';
  String businessSave =
      '/storage/emulated/0/Pictures/Status_Saver/WhatsappBusiness';
  String gbSave = '/storage/emulated/0/Pictures/Status_Saver/WhatsappGB';


  //Pakage Names
  String whatsappPackageName = "com.whatsapp";
  String whatsappBusinessPackageName = "com.whatsapp.w4b";
  String gbPackageName = "com.wapp.status.saver";
  String launcherUrl = "com.whatsapp";

  RxString titleText = "Whatsapp Saver".obs;

  RxString whatsAppType = "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses".obs;

  RxList<MultiSelectClass> selectedFilesAll = <MultiSelectClass>[].obs;
  RxList<MultiSelectClass> selectedFilesImage = <MultiSelectClass>[].obs;
  RxList<MultiSelectClass> selectedFilesVideo = <MultiSelectClass>[].obs;
  // RxBool multiSelect = false.obs;

  RxList<dynamic> allList = [].obs;
  RxList<dynamic> imageList = [].obs;
  RxList<dynamic> videoList = [].obs;
  RxList<dynamic> savedList = [].obs;

  Rx<ModelNames> modelNames = ModelNames(title: [Title1(names: "",time: DateTime.now())]).obs;

  // gg() async {
  //   print(jsonEncode(modelNames));
  //   // modelNames.value.title = [Title(names: DateTime.now().millisecondsSinceEpoch.toString())];
  //   modelNames.value.title!
  //       .add(Title1(names: DateTime.now().millisecondsSinceEpoch.toString()));
  //   print(jsonEncode(modelNames));
  //
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString("savedStatus", jsonEncode(modelNames));
  // }
  //
  // kk() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   modelNames.value =
  //       ModelNames.fromJson(jsonDecode(preferences.getString("savedStatus")!));
  //   print(jsonEncode(modelNames));
  // }

  updateDownloadList({
    required name,
}) async {
    // modelNames.value.title!.add(Title1(names: name,time: DateTime.now()));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("savedStatus", jsonEncode(modelNames));
    print(jsonEncode(preferences.getString("savedStatus")));
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  RxString phoneCode = "+91".obs;

  RxDouble adCountShow = (10.0).obs;
  RxInt adCount = 0.obs;

  switchToNormal(context) async {
    saveDirectory.value = Directory(normalSave);
    whatsAppType.value = normal;
    whatsappDirectory.value = Directory(normal);
    launcherUrl = whatsappPackageName;
    titleText.value = "Whatsapp Saver";
    updateFiles();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("normal_whatsApp", whatsAppType.value);
    preferences.setString("launcherUrl", launcherUrl);
    preferences.setString("titleText", titleText.value);
    Get.back();
    loadAdInter(context);
  }

  switchToBusiness(context) async {
    if (Directory(business).existsSync()) {
      await Directory(businessSave)
          .create(recursive: false)
          .then((value) async {
        launcherUrl = whatsappBusinessPackageName;
        whatsAppType.value = business;
        whatsappDirectory.value = Directory(business);
        saveDirectory.value = Directory(businessSave);
        updateFiles();
        titleText.value = "Business Saver";
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString("normal_whatsApp", whatsAppType.value);
        preferences.setString("launcherUrl", launcherUrl);
        preferences.setString("titleText", titleText.value);
        Get.back();
        loadAdInter(context);
      }).catchError((e) {
        throw Exception(e);
      });
    } else {
      Fluttertoast.showToast(
          msg: "You don't have Whatsapp business app installed.");
    }
  }


  late BannerAd banner;
  RxBool loadAd = false.obs;
  loadAdd() async {
    banner = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: BannerAdListener(
            onAdLoaded: (value) {
                loadAd.value = true;
            },
            onAdFailedToLoad: (ad, error) {}),
        request: AdRequest());
    await banner.load();
  }

  late BannerAd banner2;
  RxBool loadAd2 = false.obs;
  loadAdd2() async {
    banner2 = BannerAd(
        size: AdSize.banner,
        adUnitId: "ca-app-pub-3940256099942544/6300978111",
        listener: BannerAdListener(
            onAdLoaded: (value) {
                loadAd2.value = true;
            },
            onAdFailedToLoad: (ad, error) {}),
        request: AdRequest());
    await banner2.load();
  }

  switchToGbWhatsapp(context) async {
    if (Directory(gbWhatsapp).existsSync()) {
      await Directory(gbSave)
          .create(recursive: false)
          .then((value) async {
            launcherUrl = gbPackageName;
      whatsAppType.value = gbWhatsapp;
      whatsappDirectory.value = Directory(gbWhatsapp);
      saveDirectory.value = Directory(gbSave);
      updateFiles();
            titleText.value = "GBWhatsapp Saver";
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString("normal_whatsApp", whatsAppType.value);
        preferences.setString("launcherUrl", launcherUrl);
        preferences.setString("titleText", titleText.value);
      Get.back();
            loadAdInter(context);
      }).catchError((e) {
        throw Exception(e);
      });
    } else {
      Fluttertoast.showToast(
          msg: "You don't have GB Whatsapp app installed.");
    }
  }

  updateFiles() {
    allList.value = whatsappDirectory.value
        .listSync()
        .map((item) => item.path)
        .where((item) {
      return item.endsWith('.jpg') || item.endsWith('.mp4');
    }).toList(growable: false);

    savedList.value = Directory('${saveDirectory.value.path}')
        .listSync()
        .map((item) => item.path)
        .where((item) {
          return item.endsWith('.jpg') || item.endsWith('.mp4');
        })
        .toList(growable: false)
        .reversed
        .toList();
  }

  @override
  void onInit() {
    super.onInit();
    setupRemoteConfig();
    createDirectoryInitial();
    getWhatsApp();
    loadAdd2();
  }

  createDirectoryInitial() async {
    print("Creating Directory..............  /storage/emulated/0/Pictures/Status_Saver");
    await Directory('/storage/emulated/0/Pictures/Status_Saver')
        .create(recursive: false)
        .then((value) {
      print("directory created successfully");
      print(value.path.toString());
      getDirectory();
    }).catchError((e) {
      throw Exception(e);
    });
  }

  getWhatsApp() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
      launcherUrl = preferences.getString("launcherUrl") ?? whatsappPackageName;
    titleText.value = preferences.getString("titleText") ?? "Whatsapp Saver";
      whatsAppType.value = preferences.getString("normal_whatsApp") ?? normal;
      whatsappDirectory.value = Directory(preferences.getString("normal_whatsApp") ?? normal);
      updateFiles();
  }

  setupRemoteConfig() async {
    final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: Duration.zero,
    ));
    await remoteConfig.fetchAndActivate();
    adCountShow.value = remoteConfig.getDouble("AdCount");
    if (kDebugMode) {
      log("remote config result..... adCount.. ${adCountShow.value}");
    }
  }

  late InterstitialAd interstitialAd;
  bool showAd = false;

  showAdLoading(context){
    showDialog(context: context, builder: (context){
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Loading Ad.. "),
              SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  color: Colors.teal,

                ),
              )
            ],
          ),
        ),
      );
    });
  }

  loadAdInter(context) {
    if (showAd == false) {
      showAdLoading(context);
      showAd = true;
      log("Ad is now being showing so plz wait............");
      InterstitialAd.load(
          adUnitId: "ca-app-pub-3940256099942544/1033173712",
          request: AdRequest(),
          adLoadCallback:
              InterstitialAdLoadCallback(onAdLoaded: (InterstitialAd ad) {
                Get.back();
            interstitialAd = ad;
            interstitialAd.show();
            adCount.value = 0;
            showAd = false;
          }, onAdFailedToLoad: (LoadAdError error) {
                Get.back();
            print(error.toString());
            adCount.value = 0;
            showAd = false;
          }));
      setupRemoteConfig();
    }
  }

  getDirectory() async {
    print("check Directory");
    if (Directory(saveDirectory.value.path).existsSync()) {
      print("Directory exist.....  true");
    } else {
      await createDirectory();
      print("Directory exist.....  false");
    }
  }

  createDirectory() async {
    print("Creating Directory");
    await Directory(saveDirectory.value.path)
        .create(recursive: false)
        .then((value) {
      print("directory created successfully");
      print(value.path.toString());
    }).catchError((e) {
      throw Exception(e);
    });
  }
}

class ModelNames {
  List<Title1>? title;

  ModelNames({this.title});

  ModelNames.fromJson(Map<String, dynamic> json) {
    if (json['title'] != null) {
      title = <Title1>[];
      json['title'].forEach((v) {
        title!.add(new Title1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.title != null) {
      data['title'] = this.title!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Title1 {
  String? names;
  DateTime? time;

  Title1({this.names,this.time});

  Title1.fromJson(Map<String, dynamic> json) {
    names = json['names'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['names'] = this.names;
    data['time'] = this.time;
    return data;
  }
}

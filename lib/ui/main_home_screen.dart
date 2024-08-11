import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../controllers/home_controller.dart';
import 'homepage.dart';

const String monthlyPlanProduct = '30.days.subscription';
const String monthlySubscription = 'monthly_subscription_30_days_period';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {

  final controller = Get.put(HomeController());

  // Instantiates inAppPurchase
  final InAppPurchase _iap = InAppPurchase.instance;

  // checks if the API is available on this device
  bool _isAvailable = false;

  // keeps a list of products queried from Playstore or app store
  List<ProductDetails> _products = [];

  // List of users past purchases
  List<PurchaseDetails> _purchases = [];

  // subscription that listens to a stream of updates to purchase details
  late StreamSubscription _subscription;

  // used to represents consumable credits the user can buy
  int _coins = 0;


  Future<void> _initialize() async {

    // Check availability of InApp Purchases
    _isAvailable = await _iap.isAvailable();

    print("Is In app purchase available.....$_isAvailable");


    // perform our async calls only when in-app purchase is available
    if(_isAvailable){

      await _getUserProducts();
      // await _getPastPurchases();
      // _verifyPurchases();

      // listen to new purchases and rebuild the widget whenever
      // there is a new purchase after adding the new purchase to our
      // purchase list

      _subscription = _iap.purchaseStream.listen((data)=> setState((){
        print(data.toString());
        _purchases.addAll(data);
        // _verifyPurchases();
      }));

    }
  }


  // Method to retrieve product list
  Future<void> _getUserProducts() async {
    Set<String> ids = <String>{monthlyPlanProduct,monthlySubscription};
    ProductDetailsResponse response = await _iap.queryProductDetails(ids).catchError((e){
      print(e.toString());
    }).then((value) {
      print("is error...."+value.error.toString());
      print("is products Found...."+value.productDetails.toString());
      print("is products Not Found...."+value.notFoundIDs.toString());
      return value;
    });
    // print("is products Not Found...."+response.notFoundIDs);
    setState(() {
      _products = response.productDetails;
      print(_products);
    });
    // await _iap.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: productDetails))
    // await _iap
  }

  // Method to retrieve users past purchase
  // Future<void> _getPastPurchases() async {
    // fi response = await _iap();
    //
    // for(PurchaseDetails purchase in response.pastPurchases){
    //   if(Platform.isIOS){
    //     _iap.completePurchase(purchase);
    //   }
    // }
    // setState(() {
    //   _purchases = response.pastPurchases;
    // });
  // }

  // checks if a user has purchased a certain product
  // PurchaseDetails _hasUserPurchased(String productID){
  //   return _purchases.firstWhere((purchase) => purchase.productID == productID);
  // }


  // Method to check if the product has been purchased already or not.
  // void _verifyPurchases(){
  //   PurchaseDetails purchase = _hasUserPurchased(monthlyPlanProduct);
  //   if(purchase.status == PurchaseStatus.purchased){
  //     _coins = 10;
  //   }
  // }

  // Method to purchase a product
  // void _buyProduct(ProductDetails prod){
  //   final PurchaseParam purchaseParam = PurchaseParam(productDetails: prod);
  //   _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: false);
  // }


  // void spendCoins(PurchaseDetails purchase) async {
  //   setState(() {
  //     _coins--;
  //   });
  //   if(_coins == 0 ){
  //     // var res = await _iap.buyConsumable(autoConsume: true,purchaseParam: );
  //   }
  // }

  @override
  void dispose() {

    // cancelling the subscription
    _subscription.cancel();

    super.dispose();
  }




  @override
  void initState() {
    super.initState();
    // _initialize();
    getPermissions();
    getPath();
  }

  getPermissions() async {
    if(!await Permission.storage.isGranted) {
      Permission.storage.request().then((value) {
        controller.loadingPermissions.value = true;
        if(value.isGranted) {
          controller.haveUserPermission.value = true;
        }
      });
    }
    else {
      controller.loadingPermissions.value = true;
      controller.haveUserPermission.value = true;
    }
  }
  // getPermissions() async {
  //   if(!await Permission.manageExternalStorage.isGranted) {
  //     Permission.manageExternalStorage.request().then((value) {
  //       controller.loadingPermissions.value = true;
  //       if(value.isGranted) {
  //         controller.haveUserPermission.value = true;
  //       }
  //     });
  //   }
  //   else {
  //     controller.loadingPermissions.value = true;
  //     controller.haveUserPermission.value = true;
  //   }
  // }

  getPath() async {
    final path = await getExternalStorageDirectories();
    log("path");
    final dir = Directory("/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses");
    print(path!.first.path);
    print(dir.listSync());
  }

  // Future<int> requestPermission() async {
  //   if (androidSDK! >= 30) {
  //     //request management permissions for android 11 and higher devices
  //     final _requestStatusManaged =
  //     await Permission.manageExternalStorage.request();
  //     //Update Provider model
  //     if (_requestStatusManaged.isGranted) {
  //       return 1;
  //     } else {
  //       return 0;
  //     }
  //   } else {
  //     final _requestStatusStorage = await Permission.storage.request();
  //     //Update provider model
  //     if (_requestStatusStorage.isGranted) {
  //       return 1;
  //     } else {
  //       return 0;
  //     }
  //   }
  // }
  //
  // Future<int> requestStoragePermission() async {
  //   /// PermissionStatus result = await
  //   /// SimplePermissions.requestPermission(Permission.ReadExternalStorage);
  //   final result = await [Permission.storage].request();
  //   setState(() {});
  //   if (result[Permission.storage]!.isDenied) {
  //     return 0;
  //   } else if (result[Permission.storage]!.isGranted) {
  //     return 1;
  //   } else {
  //     return 0;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      // child: Scaffold(
      //   body: Center(
      //     child: ElevatedButton(
      //       onPressed: () async {
      //         // await _iap.buyNonConsumable(purchaseParam: PurchaseParam(productDetails: _products[0]));
      //
      //       },
      //       child: Text("Buy"),
      //     ),
      //   ),
      // ),
      child: MyHome(),
    );
  }
}

showToast(msg){
  Fluttertoast.cancel();
  Fluttertoast.showToast( msg: msg);
}
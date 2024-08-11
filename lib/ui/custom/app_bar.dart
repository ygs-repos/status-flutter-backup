
import 'package:flutter/material.dart';
import 'package:get/get.dart';

customAppBar({
  required String titleText,
  List<Widget>? action,
  PreferredSizeWidget? bottom,
}){
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    leadingWidth: 48,
    leading: IconButton(
      onPressed: (){
        Get.back();
      },
      icon: Icon(Icons.adaptive.arrow_back,color: Colors.black,size: 22,),
    ),
    title: Text(titleText,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16
      ),),
    actions: action,
    bottom: bottom,
  );
}
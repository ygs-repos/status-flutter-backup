import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:wa_status_saver/controllers/home_controller.dart';
import 'direct_message.dart';

class ToolScreen extends StatefulWidget {
  const ToolScreen({Key? key}) : super(key: key);

  @override
  State<ToolScreen> createState() => _ToolScreenState();
}

class _ToolScreenState extends State<ToolScreen> {
  
  late InterstitialAd interstitialAd;
  bool showAd = false;
  final controller = Get.put(HomeController());
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16,),
              Text("Whatsapp tool".toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),),
              SizedBox(height: 16,),
              InkWell(
                onTap: (){
                  Get.to(()=> DirectMessage());
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.message,color: Color(0xff088e11),),
                        SizedBox(width: 10,),
                        Text("Direct Message",style: TextStyle(
                          color: Color(0xff088e11),
                          fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 18,),
              InkWell(
                onTap: (){
                  controller.loadAdInter(context);
                },
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(Icons.monetization_on_outlined,color: Color(0xff088e11),),
                        SizedBox(width: 10,),
                        Text("Surprise is Waiting for you! Click Now",style: TextStyle(
                          color: Color(0xff088e11),
                          fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

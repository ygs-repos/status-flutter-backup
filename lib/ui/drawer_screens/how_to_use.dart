import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wa_status_saver/ui/custom/app_bar.dart';
import 'package:wa_status_saver/ui/drawer_screens/contact_us.dart';

class HowToUseScreen extends StatefulWidget {
  const HowToUseScreen({Key? key}) : super(key: key);

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(titleText: "How to Use",action: [
        GestureDetector(
          onTap: (){
            Get.to(()=> ContactUsScreen());
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
              )
          ),
          margin: EdgeInsets.only(right: 15),
          padding: EdgeInsets.all(2),
          child: Icon(Icons.question_mark,color: Colors.white,size: 18,),
      ),
        ),]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height*.72,
                child: Image.asset("assets/images/how.png")),
            MaterialButton(
                onPressed: (){},
              minWidth: MediaQuery.of(context).size.width*.8,
              height: 56,
              color: Colors.teal,
              child: Text("Got it",
              style: TextStyle(color: Colors.white,fontSize: 18),),
            )
          ],
        ),
      ),
    );
  }
}

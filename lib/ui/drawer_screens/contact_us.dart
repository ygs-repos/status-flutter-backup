import 'dart:io';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wa_status_saver/ui/custom/app_bar.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {


  void launchWhatsApp({required String phone,
    required String message,
  }) async {
    String url() {
      if (Platform.isAndroid) {
        // add the [https]
        return "https://wa.me/$phone/?text=${Uri.parse(message)}";
        // new line
      } else {
        // add the [https]
        return "https://api.whatsapp.com/send?phone=$phone=${Uri.parse(
            message)}";
        // new line
      }
    }

    if (await canLaunchUrlString(url())) {
      await launchUrlString(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(titleText: "Contact Us", action: [
        Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  Colors.green.shade500,
                  Colors.green.shade600,
                  Colors.green.shade700,
                  Colors.green.shade800,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
          ),
          margin: EdgeInsets.only(right: 15),
          padding: EdgeInsets.all(2),
          child: Icon(Icons.headset_mic_outlined,color: Colors.white,size: 18,),
        ),
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 24,),
            MaterialButton(
              onPressed: (){
                launchWhatsApp(phone: "+0916376977145",message: "I am a Flutter Developer who developed this app.");
              },
              minWidth: MediaQuery.of(context).size.width*.8,
              height: 56,
              color: Colors.teal,
              child: Text("Contact Us",
                style: TextStyle(color: Colors.white,fontSize: 18),),
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height*.74,
                child: Image.asset("assets/images/how.png")),
          ],
        ),
      ),
    );
  }
}

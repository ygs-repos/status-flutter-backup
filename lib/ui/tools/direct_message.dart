import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wa_status_saver/controllers/home_controller.dart';
import 'package:wa_status_saver/ui/tools/country_screen.dart';

class DirectMessage extends StatefulWidget {
  const DirectMessage({Key? key}) : super(key: key);

  @override
  State<DirectMessage> createState() => _DirectMessageState();
}

class _DirectMessageState extends State<DirectMessage> {

  final controller = Get.put(HomeController());

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

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
  }

  final TextEditingController numberController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.black,
            size: 22,
          ),
        ),
        leadingWidth: 46,
        title: Text("Direct Chat",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 16
          ),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 14,),
              Text("Send a message on",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),),
              SizedBox(height: 12,),
              Row(),
              SizedBox(height: 12,),
              Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(1, 1),
                          spreadRadius: 0,
                          blurRadius: 2),
                      BoxShadow(
                          color: Colors.grey.shade200,
                          offset: const Offset(-1, -1),
                          spreadRadius: 0,
                          blurRadius: 2),
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4)
                ),
                padding: EdgeInsets.only(left: 14),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => CountryScreen(),
                            transition: Transition.downToUp);
                      },
                      child: Obx(() {
                        return Text(controller.phoneCode.value,
                          style: TextStyle(
                              fontSize: 12.4
                          ),);
                      }),
                    ),
                    SizedBox(width: 12,),
                    Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: numberController,
                          decoration: InputDecoration(
                            hintText: "Input phone number",
                            hintStyle: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade500,
                                  fontSize: 14
                              ),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 16),
                            border: InputBorder.none,
                          ),
                        )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16,),
              TextFormField(
                controller: messageController,
                minLines: 26,
                maxLines: 28,
                decoration: InputDecoration(
                  hintText: "Input Message",
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.grey.shade100
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16.0).copyWith(top: 10),
        color: Colors.white,
        child: Row(
          children: [
            // Expanded(
            //   child: OutlinedButton(
            //     onPressed: () async {
            //      await Permission.contacts.request().then((value) async {
            //        if(value.isGranted || value.isLimited){
            //          showDialog(context: context, builder: (context){
            //            return Dialog(
            //              // contentPadding: EdgeInsets.symmetric(horizontal: 16),
            //              insetPadding: EdgeInsets.symmetric(horizontal: 16),
            //              child: Container(
            //                padding: EdgeInsets.symmetric(horizontal: 16),
            //                child: Column(
            //                  children: [
            //                    Text("Add Contact",
            //                    style: TextStyle(
            //                      fontSize: 18,
            //                      fontWeight: FontWeight.w500
            //                    ),),
            //                      SizedBox(height: 20,),
            //                      TextFormField(
            //                        decoration: InputDecoration(
            //                            border: OutlineInputBorder(
            //                              borderRadius: BorderRadius.circular(4),
            //                            ),
            //                            hintText: "Contact Name",
            //                            labelText: "Contact Name"
            //                        ),
            //                      ),
            //
            //                  ],
            //                ),
            //              ),
            //            );
            //          });
            //
            //          // final newContact = Contact()
            //          //   ..name.first = ''
            //          //   ..name.last = ''
            //          //   ..phones = [Phone(numberController.text.trim())];
            //          // await newContact.insert();
            //        }
            //      });
            //     },
            //     style: OutlinedButton.styleFrom(
            //       minimumSize: Size(double.maxFinite, 50)
            //     ),
            //     child: Text("Add Contact"),
            //   ),
            // ),
            // SizedBox(width: 14,),
            Expanded(
              child: MaterialButton(
                color: Colors.greenAccent.shade700,
                onPressed: (){
                  if(numberController.text.trim().isEmpty){
                    Fluttertoast.showToast(msg: "Enter Phone Number");
                  }  else if(numberController.text.trim().length <8){
                    Fluttertoast.showToast(msg: "Enter Valid Phone Number");
                  }
                  else {
                    launchWhatsApp(phone: controller.phoneCode.value+numberController.text.trim(), message: messageController.text.trim());
                  }
                },
                height: 50,
                child: Text("Send",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
                ),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

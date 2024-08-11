import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:wa_status_saver/controllers/home_controller.dart';
import 'package:wa_status_saver/ui/drawer_screens/contact_us.dart';

import '../subscription_screen.dart';
import 'how_to_use.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/drawer_back.jpeg"),
                fit: BoxFit.cover,
                opacity: .04
              )
            ),
            child: Column(
              children: [
                Container(
                  height: 100,
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 20,),
                        SizedBox(
                            width: 40,
                            height: 40,
                            child: Image.asset("assets/images/app_icon.jpeg",fit: BoxFit.contain,)),
                        SizedBox(width: 6,),
                        Text("Status",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.teal,
                              fontWeight: FontWeight.w600
                          ),),
                        Text(" Saver",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                          ),),
                      ],
                    ),
                  ),
                  // child: FractionallySizedBox(
                  //     heightFactor: .6,
                  //     child: Image.asset("assets/images/app_icon.jpeg",fit: BoxFit.contain,)),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(100),
                    onTap: () {
                      Get.to(()=> SubscriptionScreen());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          gradient: LinearGradient(
                            colors: [
                              Colors.yellow.shade400,
                              Colors.yellow.shade500,
                              Colors.yellow.shade600,
                              Colors.yellow.shade700,
                              Colors.yellow.shade800,
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.workspace_premium,
                            color: Colors.white,
                            size: 18,
                          ),
                          Text(
                            "  Premium",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 16,
              ),
              Text(
                "Switch Apps",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 10,),
          Obx(() {
            return ListTile(
              minVerticalPadding: 0,
              onTap: () {
                controller.switchToNormal(context);
              },
              selected: controller.normal == controller.whatsAppType.value,
              selectedTileColor: Colors.teal.shade50.withOpacity(.8),
              title: Row(
                children: [
                  SizedBox(
                    width: 21,
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
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )
                ],
              ),
            );
          }),
          Obx(() {
            return ListTile(
              minVerticalPadding: 0,
              onTap: () {
                controller.switchToBusiness(context);
              },
              selected: controller.business == controller.whatsAppType.value,
              selectedTileColor: Colors.teal.shade50.withOpacity(.8),
              title: Row(
                children: [
                  SizedBox(
                    width: 15,
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
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )
                ],
              ),
            );
          }),
          Obx(() {
            return ListTile(
              minVerticalPadding: 0,
              onTap: () {
                controller.switchToGbWhatsapp(context);
              },
              selected: controller.gbWhatsapp == controller.whatsAppType.value,
              selectedTileColor: Colors.teal.shade50.withOpacity(.8),
              title: Row(
                children: [
                  SizedBox(
                    width: 20,
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
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                  )
                ],
              ),
            );
          }),
          Divider(height: 0,),
          SizedBox(
            height: 6,
          ),
          ListTile(
            onTap: () {
              Get.to(() => HowToUseScreen());
            },
            title: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
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
                  padding: EdgeInsets.all(2),
                  child: Icon(
                    Icons.question_mark,
                    color: Colors.white,
                    size: 17,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "How to use",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                )
              ],
            ),
          ),
          ListTile(
            onTap: () {
              Get.to(() => ContactUsScreen());
            },
            title: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.green
                          // gradient: LinearGradient(
                          //   colors: [
                          //     Colors.yellow.shade500,
                          //     Colors.yellow.shade600,
                          //     Colors.yellow.shade700,
                          //     Colors.yellow.shade800,
                          //   ],
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          // )
                          ),
                  padding: EdgeInsets.all(3.25),
                  child: Icon(
                    Icons.headset_mic_outlined,
                    color: Colors.white,
                    size: 15,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Contact Us",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                )
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.lightBlue
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Colors.yellow.shade500,
                      //     Colors.yellow.shade600,
                      //     Colors.yellow.shade700,
                      //     Colors.yellow.shade800,
                      //   ],
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      // )
                      ),
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                    size: 14,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Share",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                )
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                SizedBox(
                  width: 18,
                ),
                Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.white
                          // gradient: LinearGradient(
                          //   colors: [
                          //     Colors.yellow.shade500,
                          //     Colors.yellow.shade600,
                          //     Colors.yellow.shade700,
                          //     Colors.yellow.shade800,
                          //   ],
                          //   begin: Alignment.topCenter,
                          //   end: Alignment.bottomCenter,
                          // )
                          ),
                  // padding: EdgeInsets.all(2),
                  child: Icon(
                    Icons.info,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Privacy Policy",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                )
              ],
            ),
          ),
          ListTile(
            title: Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Color(0xffA15D57FF)
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Colors.yellow.shade500,
                      //     Colors.yellow.shade600,
                      //     Colors.yellow.shade700,
                      //     Colors.yellow.shade800,
                      //   ],
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      // )
                      ),
                  padding: EdgeInsets.all(3.25),
                  child: Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                SizedBox(
                  width: 16,
                ),
                Text(
                  "More Our Apps",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                )
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

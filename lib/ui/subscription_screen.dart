import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  RxBool month = true.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 320,
              width: double.maxFinite,
              // child: SvgPicture.asset("assets/images/subs.svg",fit: BoxFit.cover,),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/subs.jpeg"),
                      fit: BoxFit.cover)),
              // child: Column(
              //   children: [
              //     SizedBox(height: 25,),
              //     Text("Premium",
              //     style: TextStyle(
              //       color: Colors.white,
              //       fontWeight: FontWeight.w600,
              //       fontSize: 28
              //     ),)
              //   ],
              // )
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  Expanded(
                      child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: InkWell(
                              onTap: () {
                                month.value = true;
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Obx(() {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: month.value
                                        ? Colors.white
                                        : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                    border: month.value
                                        ? Border.all(
                                            color: Colors.greenAccent.shade700,
                                            width: 3.4)
                                        : null,
                                  ),
                                  width: 130,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 28,
                                      ),
                                      Text(
                                        "Monthly",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 28,
                                      ),
                                      Text(
                                        "₹330.00",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 28,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
                  Expanded(
                      child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: InkWell(
                              onTap: () {
                                month.value = false;
                              },
                              borderRadius: BorderRadius.circular(10),
                              child: Obx(() {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: !month.value
                                        ? Colors.white
                                        : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10),
                                    border: !month.value
                                        ? Border.all(
                                            color: Colors.greenAccent.shade700,
                                            width: 3.4)
                                        : null,
                                  ),
                                  width: 130,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 28,
                                      ),
                                      Text(
                                        "Yearly",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 28,
                                      ),
                                      Text(
                                        "₹2600.00",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 28,
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.yellow.shade700,
                                borderRadius: BorderRadius.circular(100)),
                            padding:
                                EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                            child: Text(
                              "34% OFF",
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  )),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.maxFinite, 0),
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Color(0xff01ce58)),
                  child: Text(
                    "Try 3 days for free",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  )),
            ),
            SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Restore Purchases",
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 15),
                )),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "You can cancel subscription or free trial in the google"
                " play settings at least 24-hours before the end of the"
                " free trial period. The cancellation will take effect the day "
                "after the last day of the current subscription period and you "
                "will be downgraded to the free service",
                style: TextStyle(color: Colors.grey, height: 1.4),
              ),
            )
          ],
        ),
      ),
    );
  }
}

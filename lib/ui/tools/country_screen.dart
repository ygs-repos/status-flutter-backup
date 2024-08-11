
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wa_status_saver/controllers/home_controller.dart';
import 'package:wa_status_saver/models/country_data.dart';
import 'package:wa_status_saver/models/country_model.dart';
import 'package:wa_status_saver/ui/custom/app_bar.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({Key? key}) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  RxList<ModelCountryCode> countries = <ModelCountryCode>[].obs;
  List<ModelCountryCode> countries1 = [];
  final controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    countries.clear();
    Countries.data.forEach((element) {
      countries.add(ModelCountryCode(
          name: element["name"],
          phoneCode: element["phone_code"].toString().contains("-")
              ? element["phone_code"].toString().split("-").last
              : element["phone_code"].toString()));
    });
    countries1 = countries;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          titleText: "Country",
          bottom: PreferredSize(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Search country name",
                    hintStyle: GoogleFonts.lato(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade500,
                          fontSize: 14),
                    ),
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    fillColor: Colors.grey.shade100,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent)),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade500,
                      size: 22,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            BorderSide(color: Colors.green, width: 1.6)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.transparent)),
                  ),
                  onChanged: (value){
                    if(value.trim().isNotEmpty){
                      List<ModelCountryCode> temp = [];
                      for(var item in countries1){
                        if(item.name!.toLowerCase().contains(value.toLowerCase())){
                          temp.add(item);
                        }
                      }
                      countries.value = temp;
                    } else {
                      countries.clear();
                      countries.value = countries1;
                    }
                  },
                ),
              ),
              preferredSize: Size(double.maxFinite, 50))),
      body: Obx(() {
        return ListView.separated(
          itemCount: countries.length,
          padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 24),
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            print(index);
            return Obx(() {
              return InkWell(
                onTap: (){
                  controller.phoneCode.value = "+ ${countries[index].phoneCode!.replaceAll("+", "")}";
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 2),
                  child: Row(
                    children: [
                      Expanded(child: Text(countries[index].name ?? "")),
                      Text("+ ${countries[index].phoneCode!.replaceAll("+", "")}")
                    ],
                  ),
                ),
              );
            });
          },
          separatorBuilder: (BuildContext context, int index) => Divider(),
        );
      }),
    );
  }
}

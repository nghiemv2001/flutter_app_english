import 'package:english_directory_flutter/values/Share_key.dart';
import 'package:english_directory_flutter/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:english_directory_flutter/values/app_styles.dart';
import 'package:english_directory_flutter/values/app_assets.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Control_Page extends StatefulWidget {
  const Control_Page({Key? key}) : super(key: key);

  @override
  State<Control_Page> createState() => _Control_PageState();
}

class _Control_PageState extends State<Control_Page> {
  double sliderValue = 5;
  late SharedPreferences pref;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDefautValue();
  }

  initDefautValue() async{
    pref = await SharedPreferences.getInstance();
    int Value = pref.getInt(ShareKeys.counter, ) ?? 5 ;
    setState(() {
      sliderValue = Value.toDouble();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App_colors.secondColor,
      appBar: AppBar(
        backgroundColor: App_colors.secondColor,
        elevation: 0,
        title: Text(
          'Your control',
          style:
          AppStyles.h3.copyWith(color: App_colors.textColor, fontSize: 36),
        ),
        leading: InkWell(
          onTap: ()async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.setInt(ShareKeys.counter, sliderValue.toInt());
            Navigator.pop(context);
          },
          child: Image.asset(App_Assets.leftArrow),
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          children: [
            Spacer(),
            Text("How much a number word at once",
        style: AppStyles.h4.copyWith(
          color: App_colors.lightGrey,
          fontSize: 18,
        ),),
            Text("${sliderValue.toInt()}",
            style: AppStyles.h1.copyWith(
              color: App_colors.primaryColor,
              fontSize: 150,
              fontWeight: FontWeight.bold,
            ),),
            Slider(value: sliderValue,min : 5, max : 100,
                divisions: 95,
                activeColor: App_colors.primaryColor,
                inactiveColor: App_colors.primaryColor,
                onChanged: (value){
                      setState(() {
                        sliderValue = value;
                      });
                }
                ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              alignment: Alignment.centerLeft,
              child: Text("sile to set",
              style: AppStyles.h5.copyWith(
                color: App_colors.textColor
              ),),
            ),
            Spacer(),
            Spacer()
          ],
        ),
      ),
    );
  }
}

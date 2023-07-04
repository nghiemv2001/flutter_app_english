import 'package:english_directory_flutter/pages/home_page.dart';
import 'package:english_directory_flutter/values/app_assets.dart';
import 'package:english_directory_flutter/values/app_colors.dart';
import 'package:english_directory_flutter/values/app_styles.dart';
import 'package:flutter/material.dart';

class Langding_page extends StatelessWidget {
  const Langding_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: App_colors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.centerLeft,
              child: Text("Welcome to", style: AppStyles.h3),
            )),
            Expanded(
                child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 1),
                    child: Text("English",
                        style: AppStyles.h2.copyWith(
                            color: App_colors.blackGrey,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Text(
                      'Qouets"',
                      textAlign: TextAlign.right,
                      style: AppStyles.h4.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            )),
            Expanded(
                child: RawMaterialButton(
              fillColor: App_colors.lighBlue,
              shape: CircleBorder(),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => HomePage()),
                    (route) => false);
              },
              child: Image.asset(App_Assets.rightArrow),
            )),
          ],
        ),
      ),
    );
  }
}

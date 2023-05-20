import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:storefront/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int splashtime = 3;
  @override
  void initState() {
    Future.delayed(Duration(seconds: splashtime), () async {
      Get.off(MainPage());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/wc.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Center(
                  child: Image.asset(
                "assets/shop.png",
                height: 40.h,
              )),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 72.h,
                    ),
                    Text(
                      'Welcome To',
                      style: GoogleFonts.josefinSans(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'STOREFRONT',
                      style: GoogleFonts.josefinSans(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w200,
                          letterSpacing: 0.5,
                          color: Color(0xFFFF00C7)),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Lörem ipsum häligen heteroskap samt homoligt digall\n såsom telengar. Bes däjevis. Dagshandlare mikros.\n Måbebatt androsofi. Neligt vil. ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.josefinSans(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

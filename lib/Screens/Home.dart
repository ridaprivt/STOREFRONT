// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'Beverages.dart';
import 'Snack.dart';
import 'Sweet.dart';

class Home extends KFDrawerContent {
  final List<String> imagePaths = [
    "assets/sw.png",
    "assets/ice.png",
    "assets/tea.png",
  ];

  final List<String> itemTexts = [
    '12',
    '42',
    '42',
  ];

  final List<String> categoryTexts = [
    'Sweets',
    'Bevarages',
    'Snacks',
  ];

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 1,
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffE7ABAA),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 5.w,
                child: MaterialButton(
                  minWidth: 5.h,
                  padding: EdgeInsets.all(0),
                  onPressed: widget.onMenuPressed,
                  child: Image.asset("assets/draw.png"),
                ),
              ),
              Text(
                'STOREFRONT',
                style: GoogleFonts.josefinSans(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.5,
                  color: Colors.black,
                ),
              ),
              Image.asset("assets/search.png"),
            ],
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Container(
              height: 43.h,
              width: 100.w,
              child: Stack(
                children: [
                  Container(
                    height: 40.h,
                    width: 100.w,
                    margin: EdgeInsets.only(bottom: 3.h),
                    decoration: BoxDecoration(
                        color: Color(0xffE7ABAA),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40))),
                    alignment: Alignment.topCenter,
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Image.asset(
                        'assets/burgg.png',
                        height: 33.h,
                      )),
                  Positioned(
                    top: 6.h,
                    left: 6.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mr. Cheezy',
                          style: GoogleFonts.josefinSans(
                            fontSize: 22.5.sp,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Container(
                          height: 5.h,
                          width: 43.w,
                          padding: EdgeInsets.all(10.sp),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Text(
                            'Best Seller',
                            style: GoogleFonts.josefinSans(
                              fontSize: 18.5.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 3.h),
            Padding(
              padding: EdgeInsets.only(left: 3.w),
              child: Container(
                height: 20.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.imagePaths.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (index == 0) {
                          Get.to(Sweet());
                        } else if (index == 1) {
                          Get.to(Beverages());
                        } else if (index == 2) {
                          Get.to(Snack());
                        }
                      },
                      child: menu(index),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Container(
                width: 100.w,
                decoration: BoxDecoration(color: Color(0xffF1EFEF)),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(7.w, 3.h, 7.w, 2.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 7.h,
                          decoration: BoxDecoration(
                              color: Color(0xffFF00C7),
                              borderRadius: BorderRadius.circular(10)),
                          child: Image.asset(
                            'assets/pin.png',
                            height: 5.h,
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Near You',
                              style: GoogleFonts.josefinSans(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 1,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Wattala, Sri Lanka',
                              style: GoogleFonts.josefinSans(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w300,
                                letterSpacing: 1,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Image.asset(
                          'assets/arr.png',
                          height: 4.h,
                        )
                      ],
                    ),
                  ),
                  Wrap(
                    spacing: 2.5.w, // Horizontal spacing between containers
                    runSpacing: 2.h, // Vertical spacing between rows
                    children: <Widget>[
                      BOX('Javicenter Resto', 'Pasuruan', 'assets/rec12.png',
                          '1.2'),
                      BOX('Blembem Coffee Shop', 'Not Surabaya',
                          'assets/rex2.png', '1.3'),
                      BOX('Javicenter Resto', 'Not Surabaya', 'assets/r3.png',
                          '1.2'),
                      BOX('Blembem Coffee Shop', 'Not Surabaya',
                          'assets/r4.png', '1.3'),
                      // Add more containers as needed
                    ],
                  ),
                  SizedBox(height: 4.h),
                ]))
          ],
        ));
  }

  menu(int index) {
    return Container(
      width: 36.w,
      height: 20.h,
      margin: EdgeInsets.all(2.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(14)),
      child: Stack(
        children: [
          Image.asset(
            widget.imagePaths[index],
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.only(left: 2.5.w, top: 1.h, bottom: 1.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: widget.itemTexts[index],
                        style: GoogleFonts.josefinSans(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                      ),
                      TextSpan(
                        text: 'items',
                        style: GoogleFonts.josefinSans(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Center(
                  child: Text(
                    widget.categoryTexts[index],
                    style: GoogleFonts.josefinSans(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  BOX(String res, String place, String img, String num) {
    return Container(
      width: 45.w,
      height: 43.h,
      padding: EdgeInsets.fromLTRB(2.5.w, 2.h, 2.5.w, 2.h),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(13)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(img, height: 21.h),
          SizedBox(height: 2.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                res,
                textAlign: TextAlign.left,
                style: GoogleFonts.josefinSans(
                  fontSize: 17.sp,
                  height: 0.2.h,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                place,
                style: GoogleFonts.josefinSans(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 2.h),
              Row(
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: num,
                          style: GoogleFonts.josefinSans(
                            fontSize: 17.5.sp,
                            height: 0.2.h,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff54A5DA),
                          ),
                        ),
                        TextSpan(
                          text: ' km',
                          style: GoogleFonts.josefinSans(
                            fontSize: 17.5.sp,
                            height: 0.2.h,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff54A5DA),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Image.asset('assets/arro.png', height: 3.h),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

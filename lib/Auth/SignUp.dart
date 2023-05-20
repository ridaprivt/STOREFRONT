// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'SignIn.dart';
import 'package:storefront/main.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final email = TextEditingController();
  final pw = TextEditingController();
  final fname = TextEditingController();
  final conf = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
              height: 100.h,
              width: 100.w,
              child: Stack(children: [
                Positioned.fill(
                    child: Image.asset('assets/cov.jpg', fit: BoxFit.cover)),
                Padding(
                  padding: EdgeInsets.fromLTRB(10.w, 11.h, 10.w, 5.h),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Sign  Up',
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 23.sp,
                                    fontWeight: FontWeight.bold))),
                        SizedBox(height: 3.h),
                        box('Email', TextInputType.emailAddress, email, false),
                        SizedBox(height: 2.5.h),
                        box('Password', TextInputType.visiblePassword, pw,
                            true),
                        SizedBox(height: 2.5.h),
                        GestureDetector(
                          onTap: () => SignUpp(),
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(left: 2.w),
                            height: 5.3.h,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20.sp),
                              border: Border.all(
                                  width: 0.2.w,
                                  color: Color.fromARGB(255, 206, 206, 206)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 15,
                                  offset: Offset(
                                      5, 12), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text('Create Account',
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize: 16.5.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold))),
                          ),
                        ),
                        SizedBox(height: 1.5.h),
                        Container(
                            margin: EdgeInsets.only(left: 2.w, right: 2.w),
                            child: Divider(
                              color: Colors.grey,
                              height: 2.h,
                            )),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('   Already have an account?',
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize: 15.5.sp,
                                        fontWeight: FontWeight.w500))),
                            GestureDetector(
                              onTap: () {
                                Get.to(SignIn());
                              },
                              child: Text(' Login',
                                  style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                          fontSize: 15.7.sp,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ],
                        ),
                      ]),
                )
              ]))
        ],
      ),
    );
  }

  Future SignUpp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            ));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: pw.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  box(String hint, TextInputType typ, TextEditingController controller,
      bool why) {
    return Container(
      padding: EdgeInsets.only(left: 2.w),
      height: 5.h,
      decoration: BoxDecoration(
        color: Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(20.sp),
        border:
            Border.all(width: 0.2.w, color: Color.fromARGB(255, 206, 206, 206)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 15,
            offset: Offset(5, 12), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        obscureText: why,
        controller: controller,
        style: TextStyle(
            fontSize: 16.5.sp,
            fontWeight: FontWeight.w400,
            color: Colors.black),
        decoration: InputDecoration(
          hintText: hint,
          contentPadding: EdgeInsets.only(top: 1.h, bottom: 1.6.h),
          hintStyle: TextStyle(
              color: Color.fromARGB(169, 0, 0, 0),
              fontWeight: FontWeight.w400,
              fontSize: 16.5.sp),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(0, 44, 44, 44))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
            color: Color.fromARGB(0, 44, 44, 44),
          )),
          prefixIcon: Image.asset(
            'assets/lock.png',
            height: 5.h,
          ),
        ),
        keyboardType: typ,
      ),
    );
  }
}

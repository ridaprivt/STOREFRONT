// ignore_for_file: unnecessary_const, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:storefront/Screens/Cart.dart';
import 'Screens/Home.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainWidget extends StatefulWidget {
  MainWidget({Key? key}) : super(key: key);

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> with TickerProviderStateMixin {
  late KFDrawerController _drawerController;

  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: Home(),
      items: [
        KFDrawerItem.initWithPage(
          text: Text(
            'Home',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.home,
            color: Colors.white,
          ),
          page: Home(),
        ),
        KFDrawerItem.initWithPage(
          text: Text(
            'Cart',
            style: TextStyle(color: Colors.white),
          ),
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          page: Cart(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: KFDrawer(
          borderRadius: 30.0,
          shadowBorderRadius: 30.0,
          menuPadding: EdgeInsets.all(5.0),
          scrollable: true,
          controller: _drawerController,
          header: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                SizedBox(height: 7.h),
                Padding(
                  padding: EdgeInsets.only(left: 14.w),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.sp),
                            border: Border.all(
                                color: Color.fromARGB(255, 223, 130, 163),
                                width: 0.6.h)),
                        child: Image.asset(
                          'assets/me.png',
                          height: 15.5.h,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text('Esra Torun',
                          style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w600))),
                    ],
                  ),
                ),
                SizedBox(height: 7.h),
              ],
            ),
          ),
          footer: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: GestureDetector(
                    onTap: () => FirebaseAuth.instance.signOut(),
                    child: Row(
                      children: [
                        Icon(Icons.logout, color: Colors.white),
                        Text(
                          'Sign Out',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0XffDAE2F8), Color(0xffD6A4A4)],
              tileMode: TileMode.repeated,
            ),
          ),
        ),
      ),
    );
  }
}

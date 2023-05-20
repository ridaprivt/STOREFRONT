import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'Cart.dart';
import 'package:storefront/Drawer.dart';

class Beverages extends StatefulWidget {
  const Beverages({Key? key}) : super(key: key);

  @override
  State<Beverages> createState() => _BeveragesState();
}

class _BeveragesState extends State<Beverages> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            height: 64.h,
            width: 100.w,
            child: Stack(
              children: [
                Positioned.fill(
                    child: Image.asset(
                  'assets/big.png',
                  fit: BoxFit.cover,
                )),
                Padding(
                  padding: EdgeInsets.fromLTRB(8.w, 6.h, 8.w, 4.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.off(MainWidget());
                            },
                            child: Icon(
                              Icons.arrow_back_ios_new,
                              size: 3.h,
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                              width: 5.w,
                              child: MaterialButton(
                                  minWidth: 5.h,
                                  padding: EdgeInsets.all(0),
                                  onPressed: () => Get.to(Cart()),
                                  child: Image.asset(
                                    'assets/cart.png',
                                    height: 3.h,
                                  )))
                        ],
                      ),
                      SizedBox(height: 21.h),
                      Text(
                        'Desserts',
                        style: GoogleFonts.josefinSans(
                          fontSize: 17.5.sp,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                      Text(
                        'Yellow Ice Creamy',
                        style: GoogleFonts.josefinSans(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        '\$12.00',
                        style: GoogleFonts.josefinSans(
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Nibh faucibus pellentesque ac viverra maecenas ultricies in nisl, faucibus pellentesque ac viverra ecenas ultricies in nisl',
                        style: GoogleFonts.josefinSans(
                          fontSize: 13.7.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1,
                          height: 1,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 100.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(7.w, 3.h, 7.w, 4.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 7.h,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Color(0xffFA5D5D),
                            borderRadius: BorderRadius.circular(10)),
                        child: Image.asset(
                          'assets/heart.png',
                          height: 4.h,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Popular',
                            style: GoogleFonts.josefinSans(
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            'Let’s choose, and enjoy the food',
                            style: GoogleFonts.josefinSans(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              letterSpacing: 0.5,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(7.w, 0, 7.w, 4.h),
                  child: Column(
                    children: [
                      items('assets/reds.png', 'Red Velvet', '12.99'),
                      items('assets/spook.png', 'Spooky Drink', '8.99'),
                      items('assets/ice.png', 'Yellow Ice creamy', '12.00')
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  items(String img, String item, String price) {
    return Container(
      margin: EdgeInsets.only(bottom: 2.h),
      padding: EdgeInsets.fromLTRB(3.w, 1.5.h, 4.w, 1.5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(2, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            img,
            height: 13.h,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 0.6.h, bottom: 0.6.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    item,
                    style: GoogleFonts.josefinSans(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Container(
                    padding: EdgeInsets.all(10.sp),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(49, 39, 174, 95),
                      borderRadius: BorderRadius.circular(17.sp),
                    ),
                    child: Text(
                      'Desserts ',
                      style: GoogleFonts.josefinSans(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                        color: Color(0xff27AE60),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '\$ $price',
                        style: GoogleFonts.josefinSans(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      Spacer(),
                      Container(
                        height: 4.h,
                        child: IconButton(
                          onPressed: () {
                            storeItemInFirestore(img, item, price);
                          },
                          icon: Icon(
                            Icons.shopping_cart,
                          ),
                          color: const Color.fromARGB(255, 193, 193, 193),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void storeItemInFirestore(String img, String item, String price) async {
    String imageURL = await uploadImageToStorage(img);

    // Check if the item already exists in Firestore
    QuerySnapshot querySnapshot =
        await firestore.collection('cart').where('item', isEqualTo: item).get();

    if (querySnapshot.docs.isEmpty) {
      // Item doesn't exist, add it to Firestore
      firestore.collection('cart').add({
        'item': item,
        'price': price,
        'imageURL': imageURL,
      }).then((value) {
        // Document added successfully
        showSnackBar('Item added to cart');
      }).catchError((error) {
        // Error occurred while adding the document
        print('Failed to add item to Firestore: $error');
      });
    } else {
      // Item already exists
      showSnackBar('Item already added to cart');
    }
  }

  Future<String> uploadImageToStorage(String img) async {
    ByteData byteData = await rootBundle.load(img);
    List<int> imageData = byteData.buffer.asUint8List();

    Directory tempDir = await getTemporaryDirectory();
    String tempPath =
        '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}.png';

    await File(tempPath).writeAsBytes(imageData);

    File imageFile = File(tempPath);
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = storage.ref().child('images/$fileName');
    UploadTask uploadTask = ref.putFile(imageFile);
    TaskSnapshot storageTaskSnapshot = await uploadTask;

    await imageFile.delete();

    return await storageTaskSnapshot.ref.getDownloadURL();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.josefinSans(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.black87,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.sp),
        ),
      ),
    );
  }
}

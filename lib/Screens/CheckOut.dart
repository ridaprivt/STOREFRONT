import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:storefront/Screens/Payment.dart';
import 'Cart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckoutScreen extends StatefulWidget {
  final List<CartItem> cartItems;
  final double totalPrice;

  const CheckoutScreen(
      {Key? key, required this.cartItems, required this.totalPrice})
      : super(key: key);

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Map<String, dynamic>? paymentIntentData;
  int paymentMethod = 1;
  TextEditingController emailController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    fullNameController.dispose();
    addressController.dispose();
    phoneNumberController.dispose();
    postalCodeController.dispose();
    cityController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey, // change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            SizedBox(width: 18.w),
            Text(
              'CHECKOUT',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.5,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 12.h,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 2.h),
              child: Text(
                'Total Bill: \$ ${widget.totalPrice.toStringAsFixed(2)}',
                textAlign: TextAlign.center,
                style: GoogleFonts.josefinSans(
                  fontSize: 18.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 3.h),
              child: Text(
                'Delivery Charges: \$ 10',
                textAlign: TextAlign.center,
                style: GoogleFonts.josefinSans(
                  fontSize: 15.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          ListView.builder(
            shrinkWrap: true, // Set shrinkWrap to true
            itemCount: widget.cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = widget.cartItems[index];
              return buyItem(cartItem);
            },
          ),
          Form(
            child: Column(
              children: [
                Row(
                  children: [
                    Spacer(),
                    Padding(
                      padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                      child: Text(
                        'RECEIVER DETAILS',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(width: 11.w),
                    IconButton(
                        onPressed: () {
                          Get.to(Payment(totalPrice: widget.totalPrice));
                        },
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        )),
                    SizedBox(width: 2.w),
                  ],
                ),
                buildTextField(
                    emailController, TextInputType.emailAddress, 'Email'),
                buildTextField(
                    fullNameController, TextInputType.text, 'Full Name'),
                buildTextField(
                    addressController, TextInputType.text, 'Address'),
                buildTextField(
                    phoneNumberController, TextInputType.phone, 'Phone Number'),
                buildTextField(
                    postalCodeController, TextInputType.number, 'Postal Code'),
                buildTextField(cityController, TextInputType.text, 'City'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buyItem(CartItem cartItem) {
    return Container(
      margin: EdgeInsets.only(bottom: 5.sp),
      decoration: BoxDecoration(color: Color.fromARGB(45, 183, 182, 182)),
      child: ListTile(
        title: Text(
          cartItem.item,
          style: GoogleFonts.josefinSans(
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          '\$ ${cartItem.price.toStringAsFixed(2)}',
          style: GoogleFonts.josefinSans(
            fontSize: 16.5.sp,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
            color: Colors.grey,
          ),
        ),
        trailing: Text(
          '${cartItem.count}',
          style: GoogleFonts.josefinSans(
            fontSize: 17.sp,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  buildTextField(TextEditingController controller, TextInputType keyboardType,
      String labelText) {
    return Container(
      padding: EdgeInsets.fromLTRB(5.w, 0.h, 5.w, 0.h),
      margin: EdgeInsets.only(top: 1.h),
      height: 7.h,
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: 13,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w400,
          color: Colors.grey[400],
        ),
        keyboardType: keyboardType,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your username';
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.josefinSans(
            fontSize: 13,
            letterSpacing: 0.5,
            fontWeight: FontWeight.w400,
            color: Colors.grey[400],
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(40, 66, 66, 66)!),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: const Color.fromARGB(15, 66, 66, 66)!),
          ),
        ),
      ),
    );
  }

  String calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}

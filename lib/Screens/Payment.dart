import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'Cart.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';

class Payment extends StatefulWidget {
  final double totalPrice;

  const Payment({Key? key, required this.totalPrice}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  Map<String, dynamic>? paymentIntentData;
  int paymentMethod = 1;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.grey, // change your color here
        ),
        backgroundColor: Colors.black,
        elevation: 3,
        title: Row(
          children: [
            SizedBox(width: 19.w),
            Text(
              'PAYMENT',
              style: TextStyle(
                fontSize: 17.5.sp,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: 20.h,
        child: Column(children: [
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
            padding: EdgeInsets.only(bottom: 2.h),
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
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF00C7),
            ),
            child: Text(
              'PLACE ORDER',
              style: TextStyle(
                fontSize: 17.5.sp,
                fontWeight: FontWeight.w400,
                letterSpacing: 0.5,
                color: Colors.white,
              ),
            ),
          ),
        ]),
      ),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
            decoration: BoxDecoration(color: Colors.black),
            child: Theme(
              data: ThemeData(
                unselectedWidgetColor: Colors.white,
              ),
              child: Column(
                children: [
                  RadioListTile(
                    title: Text(
                      'Card Payment',
                      style: GoogleFonts.josefinSans(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    value: 0,
                    groupValue: paymentMethod,
                    onChanged: (value) {
                      setState(() {
                        paymentMethod = value as int;
                        makePayment();
                      });
                    },
                    activeColor: Color(0xFFFF00C7),
                  ),
                  RadioListTile(
                    title: Text(
                      'Cash on Delivery',
                      style: GoogleFonts.josefinSans(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w300,
                          color: Colors.white),
                    ),
                    value: 1,
                    groupValue: paymentMethod,
                    onChanged: (value) {
                      setState(() {
                        paymentMethod = value as int;
                      });
                    },
                    activeColor: Color(0xFFFF00C7),
                  ),
                ],
              ),
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

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent('20', 'USD');
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              setupIntentClientSecret:
                  'sk_test_51NFBVUBiSKRu4PPuHbPLUxFLZYk1tuJPyzTsSYWq5VRFxbdKlbgVD3d3eVY9f1XBRmG9Y6J6KdC9lJmXYlpd9KUO00veG4h01B',
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              customFlow: true,
              style: ThemeMode.dark,
              merchantDisplayName: 'Rida',
            ),
          )
          .then((value) {});

      displayPaymentSheet();
    } catch (e, s) {
      print('Payment exception: $e $s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) {
        print('payment intent: ${paymentIntentData!['id']}');
        print('payment intent: ${paymentIntentData!['client_secret']}');
        print('payment intent: ${paymentIntentData!['amount']}');
        print('payment intent: $paymentIntentData');

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Paid successfully")),
        );

        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print('Exception/DISPLAYPAYMENTSHEET ==> $error $stackTrace');
      });
    } on StripeException catch (e) {
      print('Exception/DISPLAYPAYMENTSHEET ==> $e');
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Cancelled"),
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      final body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      final response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':
              'Bearer sk_test_51NFBVUBiSKRu4PPuHbPLUxFLZYk1tuJPyzTsSYWq5VRFxbdKlbgVD3d3eVY9f1XBRmG9Y6J6KdC9lJmXYlpd9KUO00veG4h01B',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      print('Create Intent response ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('Error charging user: ${err.toString()}');
      throw err;
    }
  }

  String calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}

import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cart extends KFDrawerContent {
  @override
  CartState createState() => CartState();
}

class CartState extends State<Cart> {
  double totalPrice = 0.0;
  List<CartItem> itemList = [];

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    for (var item in itemList) {
      totalPrice += item.price * item.count;
    }
    return totalPrice;
  }

  @override
  void initState() {
    super.initState();
    fetchCartItems();
  }

  Future<void> fetchCartItems() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('cart').get();

      final List<CartItem> fetchedItems = snapshot.docs.map((doc) {
        final data = doc.data();
        return CartItem(
          itemId: doc.id,
          img: data['imageURL'] ?? '',
          item: data['item'] ?? '',
          price: double.parse(data['price'] ?? '0.0'),
          count: 1,
        );
      }).toList();

      setState(() {
        itemList.addAll(fetchedItems);
      });
    } catch (e) {
      print('Error fetching cart items: $e');
    }
  }

  Future<void> deleteCartItem(String itemId) async {
    try {
      await FirebaseFirestore.instance.collection('cart').doc(itemId).delete();
    } catch (e) {
      print('Error deleting cart item: $e');
    }
  }

  void incrementCount(int index) {
    setState(() {
      itemList[index].count++;
    });
  }

  void decrementCount(int index) {
    setState(() {
      if (itemList[index].count > 0) {
        itemList[index].count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
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
            SizedBox(width: 15.w),
            Text(
              'YOUR CART READY TO GO',
              style: GoogleFonts.josefinSans(
                fontSize: 16.sp,
                fontWeight: FontWeight.w300,
                letterSpacing: 0.5,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 4.h),
        child: FloatingActionButton.extended(
          backgroundColor: Color(0xFFFF00C7),
          elevation: 6.0,
          onPressed: () {},
          label: Padding(
            padding: EdgeInsets.fromLTRB(5.w, 3.h, 5.w, 3.h),
            child: Text(
              'Continue Pay - \$ ${calculateTotalPrice().toStringAsFixed(2)}',
              textAlign: TextAlign.center,
              style: GoogleFonts.josefinSans(
                fontSize: 17.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: ListView(
        padding: EdgeInsets.fromLTRB(5.w, 2.h, 5.w, 2.h),
        children: itemList.map((item) => buildCartItem(item)).toList(),
      ),
    );
  }

  Widget buildCartItem(CartItem item) {
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
            offset: Offset(2, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            item.img,
            height: 10.h,
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  item.item,
                  style: GoogleFonts.josefinSans(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 1.h),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.remove),
                      onPressed: () => decrementCount(itemList.indexOf(item)),
                      padding: EdgeInsets.zero,
                      iconSize: 15.sp,
                    ),
                    Text(
                      '${item.count}',
                      style: TextStyle(
                        fontSize: 16.5.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () => incrementCount(itemList.indexOf(item)),
                      iconSize: 15.sp,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$ ${item.price.toStringAsFixed(2)}',
                style: GoogleFonts.josefinSans(
                  fontSize: 16.5.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 2.h),
              Container(
                height: 4.h,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      itemList.remove(item);
                      deleteCartItem(item.itemId);
                    });
                  },
                  icon: Icon(
                    Icons.delete,
                  ),
                  color: const Color.fromARGB(255, 193, 193, 193),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class CartItem {
  final String itemId;
  final String img;
  final String item;
  final double price;
  int count;

  CartItem({
    required this.itemId,
    required this.img,
    required this.item,
    required this.price,
    this.count = 1,
  });
}

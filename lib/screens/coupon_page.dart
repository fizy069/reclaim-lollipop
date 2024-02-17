import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CouponPage extends StatefulWidget {
  @override
  _CouponPageState createState() => _CouponPageState();
}

class _CouponPageState extends State<CouponPage> {
  late Future<List<Coupon>> _couponFuture;

  @override
  void initState() {
    super.initState();
    _couponFuture = _fetchCoupons();
  }

  Future<List<Coupon>> _fetchCoupons() async {
    return Future.delayed(Duration(milliseconds: 50), () {
      return List.generate(5, (index) {
        return Coupon(
          title: 'Coupon $index',
          discount: 'Description of Coupon $index',
          code: 'coupon$index',
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Coupons in your Area'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Coupon>>(
              future: _couponFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final List<Coupon>? coupons = snapshot.data;
                  return ListView.builder(
                    itemCount: coupons!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                        child: coupons[index],
                      ); // Display Coupon directly
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                //login screen
              },
              child: Text('Generate New Coupons'),
            ),
          ),
        ],
      ),
    );
  }
}

class Coupon extends StatelessWidget {
  final String title;
  final String discount;
  final String code;

  const Coupon({
    Key? key,
    required this.title,
    required this.discount,
    required this.code,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.orange, // Set the border color here
          width: 1.0, // Set the border width here
        ),
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.grey[900]
            : Colors.grey[200],
        // color: Colors.white,
      ),
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                  // color : Colors.white
                ),
              ),
              Text(
                '${discount}% OFF',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ],
          ),
          // TextButton(
          //   onPressed: () async {
          //     await Clipboard.setData(ClipboardData(text: code));
          //     print("copied");
          //   },
          //   style: ButtonStyle(
          //     textStyle: MaterialStateProperty.all<TextStyle>(
          //       TextStyle(
          //         fontSize: 16.0,
          //         fontWeight: FontWeight.bold,
          //         color: Colors.white,
          //       ),
          //     ),
          //     backgroundColor: MaterialStateProperty.all<Color>(
          //         Color.fromARGB(255, 0, 131, 157)),
          //     overlayColor: MaterialStateProperty.all<Color>(
          //         Colors.black.withOpacity(0.1)),
          //     shape: MaterialStateProperty.all<OutlinedBorder>(
          //       RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(8.0),
          //       ),
          //     ),
          //   ),
          //   child: Text(code),
          // ),
          ElevatedButton(
              onPressed: () {
                
              },
              child: Text(code),
            ),
        ],
      ),
    );
  }
}

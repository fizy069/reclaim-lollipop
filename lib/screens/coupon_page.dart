import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reclaim_lollipop/screens/login.dart';
// import 'package:reclaim_lollipop/screens/qrscreen.dart';

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
          discount: ' ${index * 10} on xyz',
          code: '583A${index * 11}',
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Top Coupons in your Area',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
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

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: Colors.deepOrange, // Set the border color here
          width: 0.5, // Set the border width here
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.blue
                .withOpacity(0.2), // Adjust opacity to make it very light
            Colors.green
                .withOpacity(0.2), // Adjust opacity to make it very light
          ],
        ),
      ),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
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
            ),
            ElevatedButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: code));
              },
              child: Text(code),
            ),
          ],
        ),
      ),
    );
  }
}

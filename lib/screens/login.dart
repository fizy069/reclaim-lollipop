import 'package:flutter/material.dart';
import 'package:reclaim_lollipop/pallete.dart';
import 'qrscreen.dart';
import 'package:animated_icon_button/animated_icon_button.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Stack(children: [
            Center(child: Image.asset('assets/signin_balls.png')),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                AnimatedIconButton(
                  size: 100,
                  onPressed: () {},
                  duration: const Duration(milliseconds: 500),
                  splashColor: Colors.transparent,
                  icons: const <AnimatedIconItem>[
                    AnimatedIconItem(
                      icon: Icon(Icons.add, color: Colors.purple),
                    ),
                    AnimatedIconItem(
                      icon: Icon(Icons.close, color: Colors.purple),
                    ),
                  ],
                ),
                const Text(
                  'Sign in.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                  ),
                ),
                const SizedBox(height: 50),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const QRScreen()),
                //     );
                //   },
                //   child: const Text('Login with Swiggy'),
                // ),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Pallete.gradient1,
                        Pallete.gradient2,
                        Pallete.gradient3,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QRScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(395, 55),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text(
                      'Sign in with Swiggy',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Pallete.gradient1,
                        Pallete.gradient2,
                        Pallete.gradient3,
                      ],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QRScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(395, 55),
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                    ),
                    child: const Text(
                      'Sign in with Swiggy',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => const QRScreen()),
                //     );
                //   },
                //   child: const Text('Login with Zomato'),
                // ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

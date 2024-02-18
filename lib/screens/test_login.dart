import 'package:flutter/material.dart';
import 'package:reclaim_lollipop/widgets/gradient_button.dart';
import 'package:reclaim_lollipop/widgets/login_field.dart';
import 'package:reclaim_lollipop/widgets/social_button.dart';
import 'package:reclaim_lollipop/pallete.dart';


class LoginT extends StatelessWidget {
  const LoginT({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Image.asset('assets/signin_balls.png'),
              const Text(
                'Sign in.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                ),
              ),
              const SizedBox(height: 50),
              // const SocialButton(iconPath: 'assets/svgs/g_logo.svg', label: 'Continue with Google'),
              // const SizedBox(height: 20),
              // const SocialButton(
              //   iconPath: 'assets/svgs/f_logo.svg',
              //   label: 'Continue with Facebook',
              //   horizontalPadding: 90,
              // ),
              const SizedBox(height: 15),
              const Text(
                'or',
                style: TextStyle(
                  fontSize: 17,
                ),
              ),
              // const SizedBox(height: 15),
              // const LoginField(hintText: 'Email'),
              // const SizedBox(height: 15),
              // const LoginField(hintText: 'Password'),
              // const SizedBox(height: 20),
 
             const GradientButton(),
            ],
          ),
        ),
      ),
    );
  }
}
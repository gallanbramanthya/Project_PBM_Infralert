import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infralert/common/styles.dart';
import 'package:infralert/ui/landing_page.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});
  static const routeName = '/onboard';

  @override
  State<OnBoard> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<OnBoard> {
  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  _startSplashScreen() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (BuildContext context) => const LandingPage(),
      ));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: primaryBase,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Image.asset(
            'assets/images/logo1.png',
          ),
        ),
      ),
    );
  }
}

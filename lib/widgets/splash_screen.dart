// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_guard/widgets/bottom_nav.dart';
import 'package:wallet_guard/widgets/on_boarding.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3), () => userEntered(context));
    });
    return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Image(
          image: AssetImage('assets/mainlogo.png'),
        )));
  }

  userEntered(BuildContext context) async {
    final pref = await SharedPreferences.getInstance();
    final userEntered = pref.getString('savedValue');
    if (userEntered == null) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const OnBoadingScreen())));
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: ((context) => const NavigationScreen())));
    }
  }
}

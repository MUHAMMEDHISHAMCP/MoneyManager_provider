import 'package:flutter/material.dart';

class ScreenNavigator with ChangeNotifier {
  push(context, page) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => page,
    ));
  }

  pushReplacment(context, page) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => page,
    ));
  }

  pushRemove(context, page) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: ((context) => page())), (route) => false);
  }
}

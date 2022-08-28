import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_guard/widgets/bottom_nav.dart';
import 'package:wallet_guard/widgets/controller/navigator_pro.dart';

class OnBoadingScreen extends StatelessWidget {
  const OnBoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nameEditController = TextEditingController();

    return Scaffold(
        body: Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'WHAT IS YOUR \n NAME?',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
              ),
              Image.asset('assets/myprjct3.0.png'),
              Form(
                child: TextFormField(
                  controller: nameEditController,
                  decoration: const InputDecoration(
                      counterText: '',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                      label: Text('Enter Your Name')),
                  maxLength: 15,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    final name = nameEditController.text;
                    if (name.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        elevation: 0,
                        content: Text(
                          'Enter Your Name',
                          style: TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                        backgroundColor: Colors.white,
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 3),
                      ));
                    } else {
                      final pref = await SharedPreferences.getInstance();
                      await pref.setString('savedValue', name);
                      Provider.of<ScreenNavigator>(context,listen: false)
                          .pushReplacment(context, const NavigationScreen());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(150, 30),
                    primary: Colors.teal.shade400,
                  ),
                  child: const Text('Start Now'))
            ],
          ),
        ),
      ),
    ));
  }
}

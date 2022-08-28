import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/widgets/controller/nav_provider.dart';

class NavigationScreen extends StatelessWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
        final provider = Provider.of<NavProvider>(context);
    return Scaffold(
      // backgroundColor: Colors.black,
      body: provider.screens[provider.currentIndex],
      bottomNavigationBar: CurvedNavigationBar(
        
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(
            Icons.category,
            size: 30,
          ),
          Icon(
            Icons.pie_chart,
            size: 30,
          ),
          Icon(
            Icons.settings,
            size: 30,
          ),
        ],
        onTap: (newIndex) {
         provider.currentIndex = newIndex;
           // selectedIndex = newIndex;
        },
        buttonBackgroundColor: maincolor,
        backgroundColor: Colors.white,
        height: 60.0,
        color: maincolor,
      ),
    );
  }
}

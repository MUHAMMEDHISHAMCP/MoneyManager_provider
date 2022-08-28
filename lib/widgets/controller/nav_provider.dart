import 'package:flutter/cupertino.dart';
import 'package:wallet_guard/category_page/view/category_screen.dart';
import 'package:wallet_guard/chart_page/view/pie_chart.dart';
import 'package:wallet_guard/home_page/view/home_screen.dart';
import 'package:wallet_guard/settings_page/view/settings.dart';

class NavProvider with ChangeNotifier {
  int _currentIndex = 0;
  get currentIndex => _currentIndex;

  final screens = [
     TransactionScreen(),
    const CategoryPage(),
    const ChartScreen(),
    const SettingsScreen(),
  ];
  set currentIndex(index) {
    _currentIndex = index;
    notifyListeners();
  }
}

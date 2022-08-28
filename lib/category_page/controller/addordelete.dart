import 'package:flutter/cupertino.dart';
import 'package:wallet_guard/category_page/model/db_model/category_model.dart';

class AddOrDeleteProvider with ChangeNotifier {
  List<CategoryModel> incomeList = [];
  List<CategoryModel> expenseList = [];
  addIncomeCategory({required list}) async {
    incomeList.clear();

    await Future.forEach(list, (CategoryModel category) {
      if (category.type == CategoryType.income) {
        incomeList.add(category);
      }
    });
    notifyListeners();
  }
   addExpenseCategory({required List<CategoryModel> values}) async {
    expenseList.clear();

    await Future.forEach(values, (CategoryModel category) {
      if (category.type == CategoryType.expense) {
        expenseList.add(category);
      }
    });
    notifyListeners();
  }
}

// ignore_for_file: invalid_use_of_protected_member


import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wallet_guard/category_page/controller/addordelete.dart';
import 'package:wallet_guard/category_page/model/db_model/category_model.dart';

const categoryDB = 'cetogery_database';

abstract class CategoryDbFunctions {
  Future<List<CategoryModel>> getCategories();
  Future<void> insertcategory(CategoryModel value,context);
  Future<void> deleteCategory(String categoryID,context);
  Future<void> resetCategory();
}

class CategoryDB implements CategoryDbFunctions {
  CategoryDB._internal();
  static CategoryDB instance = CategoryDB._internal();

  factory CategoryDB() {
    return instance;
  }

  final ValueNotifier<List<CategoryModel>> incomeCategoryList =
      ValueNotifier([]);
  final ValueNotifier<List<CategoryModel>> expenseCategoryList =
      ValueNotifier([]);

  @override
  Future<void> insertcategory(CategoryModel value,context) async {
    final categoryDb = await Hive.openBox<CategoryModel>(categoryDB);
    categoryDb.put(value.id, value);

    refreshUI(context);
  }

  @override
  Future<List<CategoryModel>> getCategories() async {
    final categoryDb = await Hive.openBox<CategoryModel>(categoryDB);
    return categoryDb.values.toList();
  }

  refreshUI(context) async {
    // incomeCategoryList.value.clear();
    // expenseCategoryList.value.clear();
    final allCategory = await getCategories();
    // await Future.forEach(allCategory, (CategoryModel category) {
    //   if (category.type == CategoryType.income) {
    //     incomeCategoryList.value.add(category);
    //   } else {
    //     expenseCategoryList.value.add(category);
    //   }
    // });
    // ignore: invalid_use_of_visible_for_testing_member
    // incomeCategoryList.notifyListeners();
    // ignore: invalid_use_of_visible_for_testing_member
    // expenseCategoryList.notifyListeners();
    Provider.of<AddOrDeleteProvider>(context,listen: false).addIncomeCategory(list: allCategory);
    Provider.of<AddOrDeleteProvider>(context,listen: false).addExpenseCategory(values: allCategory);
  }

  @override
  Future<void> deleteCategory(String categoryID,context) async {
    final categoryDb = await Hive.openBox<CategoryModel>(categoryDB);
    categoryDb.delete(categoryID);
    refreshUI(context);
  }

  @override
  Future<void> resetCategory() async {
    final categoryDb = await Hive.openBox<CategoryModel>(categoryDB);
    categoryDb.clear();
  }
}

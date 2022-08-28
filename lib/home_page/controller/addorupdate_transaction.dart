import 'package:flutter/material.dart';
import 'package:wallet_guard/category_page/model/db_model/category_model.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/home_page/model/db_function/transaction_db.dart';
import 'package:wallet_guard/home_page/model/db_model/transaction_db.dart';
import 'package:wallet_guard/widgets/bottom_nav.dart';

class AddorUpdateTransaction with ChangeNotifier {
  final notesEditController = TextEditingController();
  final amountEditController = TextEditingController();
  String counterText = '0';

  DateTime? selectedDate;
  DateTime? updatedDate;

  CategoryType? selectedCategoryType;
  CategoryModel? selectedCategory;

  String? categoryID;
    String? categoryIDup;

  String? selectedValue;

  addTransaction(context) async {
    final amountText = amountEditController.text;
    final notesText = notesEditController.text;
    if (amountText.isEmpty ||
        selectedDate == null ||
        selectedCategory == null ||
        selectedCategoryType == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Please Fill All Fields',
          textAlign: TextAlign.center,
        ),
        backgroundColor: deleteColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 3),
      ));
    } else {
      final parsedAmount = double.tryParse(amountText);
      if (parsedAmount == null) {
        return;
      } else if (parsedAmount == 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            'Enter Correct Amount',
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.yellow.shade200,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          duration: const Duration(seconds: 3),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Added Successfully',
            style: popupStyle,
            textAlign: TextAlign.center,
          ),
          backgroundColor: maincolor,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          duration: Duration(seconds: 3),
        ));
        final transactionModel = TransactionModel(
            amount: parsedAmount,
            notes: notesText,
            date: selectedDate!,
            categry: selectedCategory!,
            type: selectedCategoryType!,
            id: DateTime.now().millisecondsSinceEpoch.toString());
        TransactionDB.instance.addTransactionDetials(transactionModel, context);

      
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: ((context) => const NavigationScreen())),
            (route) => false);
            
      }
    }
    notifyListeners();
  }

  updateTransaction(context, String id) async {
    final amountText = amountEditController.text;
    final notesText = notesEditController.text;
    if (amountText.isEmpty ||
        updatedDate == null ||
        selectedCategory == null ||
        selectedCategoryType == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'Please Fill All Fields',
          textAlign: TextAlign.center,
        ),
        
        backgroundColor: deleteColor,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(10),
        duration: Duration(seconds: 3),
      ));
    } else {
      final parsedAmount = double.tryParse(amountText);
      if (parsedAmount == null) {
        return;
      } else if (parsedAmount == 0) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
            'Enter Correct Amount',
            style: TextStyle(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.yellow.shade200,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          duration: const Duration(seconds: 3),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            'Updated Successfully',
            style: popupStyle,
            textAlign: TextAlign.center,
          ),
          backgroundColor: maincolor,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          duration: Duration(seconds: 3),
        ));
        final transactionModel = TransactionModel(
            amount: parsedAmount,
            notes: notesText,
            date: updatedDate!,
            categry: selectedCategory!,
            type: selectedCategoryType!,
            id: id);
        // TransactionDB.instance.addTransactionDetials(transactionModel,context);
        TransactionDB.instance.updateDetails(transactionModel, context);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: ((context) => const NavigationScreen())),
            (route) => false);
      }
    }
    notifyListeners();
  }

  categoryId(String catId) {
    categoryID = catId;
    notifyListeners();
  }

    updatedCategory(String catId1) {
    categoryID = catId1;
    notifyListeners();
  }



  // selectDate(context) async {
  //   final tempDate = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime.now().subtract(const Duration(days: 30 * 5)),
  //       lastDate: DateTime.now());
  //   if (tempDate == null) {
  //     return;
  //   } 
  //     // setState(() {
  //     //   _selectedDate = selectedDate;
  //     // });
  //     updatedDate = tempDate;
  //   notifyListeners();
  // }
}

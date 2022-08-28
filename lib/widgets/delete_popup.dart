import 'package:flutter/material.dart';
import 'package:wallet_guard/category_page/model/db_functions/db_functions.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/home_page/model/db_function/transaction_db.dart';
import 'package:wallet_guard/widgets/bottom_nav.dart';

showDeletePopup(BuildContext context, {categoryId, id}) {
  // final selectedId = categoryId;
  // final tarnsactionId = id;
  showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          // backgroundColor: maincolor,
          title: const Text('Alert !!'),
          content: const Text('Are you sure to want to delete ??'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                if (id != null) {
                  TransactionDB.instance.deleteTransaction(id,context);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: ((context) => const  NavigationScreen())),
                      (route) => false);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                      'Deleted Successfully',
                      style: popupStyle,
                      textAlign: TextAlign.center,
                    ),
                    backgroundColor: deleteColor,
                    behavior: SnackBarBehavior.floating,
                    margin: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    duration: Duration(seconds: 1),
                  ));
                } else
                 if (categoryId != null) {
                  CategoryDB.instance.deleteCategory(categoryId,context);
                  Navigator.of(ctx).pop();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Category Deleted',
                        style: popupStyle,
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: deleteColor,
                      behavior: SnackBarBehavior.floating,
                      margin:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      duration: Duration(seconds: 1)));
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      });
}

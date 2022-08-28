import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wallet_guard/category_page/model/db_functions/db_functions.dart';
import 'package:wallet_guard/category_page/model/db_model/category_model.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/home_page/model/db_function/transaction_db.dart';
import 'package:wallet_guard/home_page/model/db_model/transaction_db.dart';
import 'package:wallet_guard/home_page/view/widgets/edit_transaction.dart';
import 'package:wallet_guard/widgets/controller/navigator_pro.dart';

// ignore: must_be_immutable
class TransactionDetails extends StatelessWidget {
TransactionModel transactionData;
  int index;
  TransactionDetails(
      {Key? key, required this.transactionData, required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
     WidgetsBinding.instance.addPostFrameCallback((_){
  TransactionDB.instance.refeshUI(context);
  CategoryDB.instance.refreshUI(context);
    });
    // TransactionDB.instance.refeshUI(context);
    return GestureDetector(
      onTap: (() {
        Sample.categoryName = transactionData.categry.name;
        // Navigator.of(context).push(MaterialPageRoute(
        //     builder: ((context) =>
        //         EditTransactionScreen(data: transactionData, index: index))));
        Provider.of<ScreenNavigator>(context,listen: false).push(context, EditTransactionScreen(data: transactionData, index: index));
      }),
      child: Card(
        elevation: 4,
        child: ListTile(
          leading: Container(
            width: 50,
            decoration: BoxDecoration(
              border: Border.all(
                  color: transactionData.type == CategoryType.income
                      ? incomecolor
                      : expensecolor),
            ),
            child: Text(
              parseDate(transactionData.date),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'mainFont',
                  fontSize: 20,
                  fontWeight: FontWeight.w400),
            ),
          ),
          title: Text( 
            transactionData.categry.name.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'categoryFont'),
          ),
          subtitle: Text(
            transactionData.notes,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: transactionData.type == CategoryType.income
              ? Text(
                  transactionData.amount.toString(),
                  style: const TextStyle(color: incomecolor, fontFamily: 'cardFont',letterSpacing: 1),
                )
              : Text(
                  transactionData.amount.toString(),
                  style: const TextStyle(color: expensecolor, fontFamily: 'cardFont',letterSpacing: 1),
                ),
        ),
        
      ),
    );
  }

  String parseDate(DateTime date) {
    final currentDate = DateFormat.MMMd().format(date);
    final splitdate = currentDate.split(' ');
    return '${splitdate.last}\n${splitdate.first}';
  }
}

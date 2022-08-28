import 'package:flutter/cupertino.dart';
import 'package:wallet_guard/category_page/model/db_model/category_model.dart';
import 'package:wallet_guard/home_page/model/db_model/transaction_db.dart';

class TransationConsumer with ChangeNotifier{

List<TransactionModel> allTransaction = [];
List<TransactionModel> incometransaction = [];
List<TransactionModel> expenseTransaction = [];

double incomeBalance = 0;
double expenseBalance = 0;
double totalBalance =0;

addTransation({required List<TransactionModel> transactionList}) async{
  allTransaction.clear();
  allTransaction.addAll(transactionList);
  totalBalance = 0;
  incomeBalance = 0;
  expenseBalance =0;
  
    await Future.forEach(transactionList, (TransactionModel model) {
      if (model.type == CategoryType.income) {
        incomeBalance =
            incomeBalance + model.amount;
      } else {
        expenseBalance =
            expenseBalance + model.amount;
      }
      totalBalance =
          incomeBalance - expenseBalance;

      if (model.type == CategoryType.income) {
        incometransaction.add(model);
      } else {
        expenseTransaction.add(model);
}});
notifyListeners();

}

String? selectedItem ;

changeValue( String selectedValue){
  selectedItem = selectedValue;

  notifyListeners();
}

String? selectedValue ;

changeItems( String selectedItem){
  selectedValue = selectedItem;

  notifyListeners();
}


}
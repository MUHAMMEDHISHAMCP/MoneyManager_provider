// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/home_page/controller/transaction_consumer.dart';
import 'package:wallet_guard/home_page/model/db_function/transaction_db.dart';
import 'package:wallet_guard/home_page/model/db_model/transaction_db.dart';
import 'package:wallet_guard/home_page/view/widgets/recent_transaction.dart';
import 'package:wallet_guard/home_page/view/widgets/view_all/sort_logic.dart';

// ignore: must_be_immutable
class AllTransactionList extends StatelessWidget {
  AllTransactionList({Key? key}) : super(key: key);

  DateTime? selectedDate;

  List<SortData> data =
      chatLogic(TransactionDB.instance.transactionNotifierchart.value);
  List<SortData> todayData =
      chatLogic(TransactionDB.instance.todayTransactionNotifierChart.value);
  List<SortData> yesterdayData =
      chatLogic(TransactionDB.instance.yesterdayTransactionNotifierChart.value);
  List<SortData> weeklyData =
      chatLogic(TransactionDB.instance.weeklyTransactionNotifierChart.value);
  List<SortData> monthlyData =
      chatLogic(TransactionDB.instance.monthlyTransactionNotifierChart.value);

  // String? selectedItem;
  final _items = ['All', 'Today', 'Yesterday', 'Last 7 Days', 'Last 30 Days'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Consumer<TransationConsumer>(
            builder: (context, value, child) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width / 2.5,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton(
                          alignment: Alignment.center,
                          isExpanded: true,
                          underline: const SizedBox(),
                          hint: const Text(
                            'All',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          value: value.selectedValue,
                          items: _items.map(buildMenuItems).toList(),
                          onChanged: (newValue) {
                            // setState(() {
                            //   _selectedItem = newValue.toString();
                            // });
                            // Provider.of<TransationConsumer>(context,listen: false).selectedItem = newValue.toString();
                            value.changeItems(newValue.toString());
                            // ignore: invalid_use_of_visible_for_testing_member
                            value.notifyListeners();
                          }),
                    ),
                  ),
                ),
                chartChecking(value.selectedValue).isEmpty
                    ? const Expanded(
                        child: Center(
                            child: Text(
                        'No Transaction Data',
                        style: emptyStyle,
                      )))
                    : Expanded(
                        child: ValueListenableBuilder(
                            valueListenable:
                                TransactionDB.instance.transactionNotifierchart,
                            builder: (BuildContext context,
                                List<TransactionModel> newlist, Widget? _) {
                              return newlist.isEmpty
                                  ? const Center(
                                      child: Text(
                                        'No Transaction Data',
                                        style: emptyStyle,
                                      ),
                                    )
                                  : ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: ((context, index) {
                                        final transactions = newlist[index];

                                        return TransactionDetails(
                                          transactionData: transactions,
                                          index: index,
                                        );
                                      }),
                                      itemCount:
                                          chartChecking(value.selectedValue)
                                              .length,
                                    );
                            }),
                      ),
              ],
            ),
          )),
    );
  }

  List<SortData> chartChecking(selectedItem) {
    if (selectedItem == "All") {
      return data;
    } else if (selectedItem == "Today") {
      return todayData;
    } else if (selectedItem == "Yesterday") {
      return yesterdayData;
    } else if (selectedItem == "Last 7 Days") {
      return weeklyData;
    } else if (selectedItem == "Last 30 Days") {
      return monthlyData;
    } else {
      return data;
    }
  }

  //   List<SortData> chartChecking() {
  //     // final selectedItem =  Provider.of<TransationConsumer>(context,listen: false);
  //   if (selectedItem == "All") {
  //     return data;
  //   } else if (selectedItem == "Today") {
  //     return todayData;
  //   } else if (selectedItem == "Yesterday") {
  //     return yesterdayData;
  //   } else if (selectedItem == "Last 7 Days") {
  //     return weeklyData;
  //   } else if (selectedItem == "Last 30 Days") {
  //     return monthlyData;
  //   } else {
  //     return data;
  //   }
  // }

  DropdownMenuItem<String> buildMenuItems(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

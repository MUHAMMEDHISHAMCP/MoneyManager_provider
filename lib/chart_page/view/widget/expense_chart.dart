// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wallet_guard/chart_page/view/widget/chart_logic.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/home_page/controller/transaction_consumer.dart';
import 'package:wallet_guard/home_page/model/db_function/transaction_db.dart';

class ExpenseChart extends StatelessWidget {
  ExpenseChart({Key? key}) : super(key: key);

  List<ChartData> data =
      chatLogic(TransactionDB.instance.expenseTransactionNotifier.value);
  List<ChartData> todayExpense = chatLogic(
      TransactionDB.instance.todayExpenseTransactionNotifierChart.value);
  List<ChartData> yesterdayExpense = chatLogic(
      TransactionDB.instance.yesterdayexpenseTransactionNotifierChart.value);
  List<ChartData> weeklyExpense = chatLogic(
      TransactionDB.instance.weeklyExpenseTransactionNotifierChart.value);
  List<ChartData> monthlyExpense = chatLogic(
      TransactionDB.instance.monthlyExpenseTransactionNotifierChart.value);

  final _lists = ['All', 'Today', 'Yesterday', 'Last 7 Days', 'Last 30 Days'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: data.isEmpty
            ? const Center(
                child: Text(
                  'No Transaction Data',
                  style: emptyStyle,
                ),
              )
            : Consumer<TransationConsumer>(
                builder: (context, value, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width / 2.5,
                        decoration: BoxDecoration(

                            // borderRadius: BorderRadius.circular(15.0)),
                            border: Border.all(color: Colors.black45)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton(
                              alignment: Alignment.bottomCenter,
                              isExpanded: true,
                              underline: const SizedBox(),
                              hint: const Text(
                                'All',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              value: value.selectedItem,
                              items: _lists.map(buildMenuItems).toList(),
                              onChanged: (newValue) {
                                // setState(() {
                                //   _selectedItem = newValue.toString();
                                // });
                                value.changeValue(newValue.toString());
                                // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                                value.notifyListeners();
                              }),
                        ),
                      ),
                    ),
                    chartChecking(value.selectedItem.toString()).isEmpty
                        ? const Expanded(
                            child: Center(
                                child: Text(
                            'No Transaction Data',
                            style: emptyStyle,
                          )))
                        : SfCircularChart(
                            legend: Legend(isVisible: true),
                            series: <CircularSeries>[
                              PieSeries<ChartData, String>(
                                dataLabelSettings: const DataLabelSettings(
                                  isVisible: true,
                                ),
                                dataSource: chartChecking(
                                    value.selectedItem.toString()),
                                xValueMapper: (ChartData data, _) =>
                                    data.categories,
                                yValueMapper: (ChartData data, _) =>
                                    data.amount,
                                explode: true,
                              )
                            ],
                          ),
                  ],
                ),
              ));
  }

  List<ChartData> chartChecking(String selectedItem) {
    if (selectedItem == "All") {
      return data;
    } else if (selectedItem == "Today") {
      return todayExpense;
    } else if (selectedItem == "Yesterday") {
      return yesterdayExpense;
    } else if (selectedItem == "Last 7 Days") {
      return weeklyExpense;
    } else if (selectedItem == 'Last 30 Days') {
      return monthlyExpense;
    } else {
      return data;
    }
  }

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

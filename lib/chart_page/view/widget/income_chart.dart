// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wallet_guard/chart_page/view/widget/chart_logic.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/home_page/controller/transaction_consumer.dart';
import 'package:wallet_guard/home_page/model/db_function/transaction_db.dart';

class IncomeChart extends StatelessWidget {
  IncomeChart({Key? key}) : super(key: key);

  List<ChartData> data =
      chatLogic(TransactionDB.instance.incomeTransactionNotifier.value);
  List<ChartData> todayData = chatLogic(
      TransactionDB.instance.todayInconeTransactionNotifierChart.value);
  List<ChartData> yesterdayData = chatLogic(
      TransactionDB.instance.yesterdayIncomeTransactionNotifierChart.value);
  List<ChartData> weeklyData = chatLogic(
      TransactionDB.instance.weeklyIncomeTransactionNotifierChart.value);
  List<ChartData> monthlyData = chatLogic(
      TransactionDB.instance.monthlyIncomeTransactionNotifierChart.value);

  final _lists = ['All', 'Today', 'Yesterday', 'Last 7 Days', 'Last 30 Days'];
  @override
  Widget build(BuildContext context) {
    //   final pro = Provider.of<TransationConsumer>(context,listen: false);

    //    List<ChartData> chartChecking() {
    //   if (pro.selectedItem == "All") {
    //     return data;
    //   } else if (pro.selectedItem == "Today") {
    //     return todayData;
    //   } else if (pro.selectedItem == "Yesterday") {
    //     return yesterdayData;
    //   } else if (pro.selectedItem == "Last 7 Days") {
    //     return weeklyData;
    //   } else if (pro.selectedItem == "Last 30 Days") {
    //     return monthlyData;
    //   } else {
    //     return data;
    //   }
    // }
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

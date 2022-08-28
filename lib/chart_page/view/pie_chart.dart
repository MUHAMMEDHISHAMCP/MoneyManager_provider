import 'package:flutter/material.dart';
import 'package:wallet_guard/category_page/model/db_functions/db_functions.dart';
import 'package:wallet_guard/chart_page/view/widget/expense_chart.dart';
import 'package:wallet_guard/chart_page/view/widget/income_chart.dart';
import 'package:wallet_guard/chart_page/view/widget/overview_chart.dart';
import 'package:wallet_guard/core/constant.dart';

class ChartScreen extends StatelessWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      CategoryDB.instance.refreshUI(context);
    });
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          title: const Text('Transactions'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(children: [
            Container(
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                unselectedLabelColor: Colors.black,
                indicator: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(10),
                ),
                tabs: const [
                  Tab(
                    text: 'All',
                  ),
                  Tab(
                    text: 'Income',
                  ),
                  Tab(
                    text: 'Expense',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    OverviewChart(),
                    IncomeChart(),
                    ExpenseChart(),
                    // ExpenseCategory(),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}

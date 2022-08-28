import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/home_page/view/widgets/search_page.dart';
import 'package:wallet_guard/home_page/view/widgets/view_all/all_transacction.dart';
import 'package:wallet_guard/home_page/view/widgets/view_all/expense_transaction.dart';
import 'package:wallet_guard/home_page/view/widgets/view_all/income_transaction.dart';
import 'package:wallet_guard/widgets/controller/navigator_pro.dart';

class ViewAllScreen extends StatelessWidget {
  const ViewAllScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          title: const Text('Transactions'),
          actions: [
            IconButton(
                onPressed: () {
                  Provider.of<ScreenNavigator>(context, listen: false)
                      .push(context, SearchScreen());
                },
                icon: const Icon(Icons.search_outlined))
          ],
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
                    AllTransactionList(),
                    IncomeTransactionList(),
                    ExpenseTransaction(),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}

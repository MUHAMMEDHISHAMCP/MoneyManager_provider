import 'package:flutter/material.dart';
import 'package:wallet_guard/category_page/model/db_functions/db_functions.dart';
import 'package:wallet_guard/category_page/view/widgets/expence.dart';
import 'package:wallet_guard/category_page/view/widgets/income.dart';
import 'package:wallet_guard/core/constant.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
       CategoryDB.instance.refreshUI(context);
    });
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: maincolor,
          title: const Text('CATEGORIES'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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
                    text: 'INCOME',
                  ),
                  Tab(
                    text: 'EXPENSE',
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    const IncomeCatogery(),
                    ExpenseCategory(),
                  ]),
            ),
          ]),
        ),
      ),
    );
  }
}

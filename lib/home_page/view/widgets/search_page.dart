import 'package:flutter/material.dart';
import 'package:wallet_guard/home_page/model/db_function/transaction_db.dart';
import 'package:wallet_guard/home_page/model/db_model/transaction_db.dart';
import 'package:wallet_guard/home_page/view/widgets/recent_transaction.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  List<TransactionModel> results =
      TransactionDB.instance.transactionNotifier.value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ValueListenableBuilder(
              valueListenable: TransactionDB.instance.transactionNotifier,
              builder: (BuildContext context,
                  List<TransactionModel> transactionList, Widget? _) {
                final dataList = transactionList;
                void _runFilter(String enteredKeyword) {
                  if (enteredKeyword.isEmpty) {
                    results = dataList;
                  } else {
                    results = dataList
                        .where((element) => element.categry.name
                            .toUpperCase()
                            .contains(enteredKeyword.toUpperCase()))
                        .toList();
                  }
                  // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
                  TransactionDB.instance.transactionNotifier.notifyListeners();
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (value) {
                          _runFilter(value);
                        },
                        decoration: const InputDecoration(
                            border:  OutlineInputBorder(),
                            hintText: 'Search transactions by category',
                            counterText: '',
                            suffixIcon: Icon(Icons.search_rounded)),
                        maxLength: 20,
                      ),
                    ),
                    Expanded(
                        child: results.isEmpty
                            ? const Center(
                                child: Text(
                                  'No results found',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(),
                                ),
                              )
                            : ListView.builder(
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                itemCount: results.length,
                                itemBuilder: (context, index) {
                                  final data = results[index];
                                  return TransactionDetails(
                                      transactionData: data, index: index);
                                }))
                  ],
                );
              })),
    );
  }
}

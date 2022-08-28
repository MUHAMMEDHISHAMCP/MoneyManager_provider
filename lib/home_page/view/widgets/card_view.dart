import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/home_page/controller/transaction_consumer.dart';
import 'package:wallet_guard/home_page/model/db_function/transaction_db.dart';

// ignore: must_be_immutable
class TrannsactionView extends StatelessWidget {
  TrannsactionView({Key? key}) : super(key: key);

  ValueNotifier<List<String>> userName = ValueNotifier([]);

  String name = '';

  getName() async {
    final pref = await SharedPreferences.getInstance();
    name = pref.getString('savedValue').toString();
  }

  // @override
  // void initState() {
  //   getName();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TransactionDB.instance.refeshUI(context);
      getName();
    });
    return Card(
      elevation: 5,
      semanticContainer: true,
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 48, 172, 160),
                    Color.fromARGB(255, 182, 180, 180),
                  ],
                  begin: FractionalOffset.bottomRight,
                  end: FractionalOffset.topLeft,
                  tileMode: TileMode.decal),
              borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7, left: 7),
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 5, left: 5, right: 3),
                        child: Text(
                          'Hello',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2),
                        ),
                      ),
                      Consumer<TransationConsumer>(
                        builder: (context, value, child) => Text(
                          name.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'categoryFont',
                              letterSpacing: 2),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'TOTAL BALANCE',
                  style: TextStyle(
                      fontSize: 20, fontFamily: 'extraFont', letterSpacing: 2),
                ),
                Consumer<TransationConsumer>(
                  builder: (context, value, child) => Text(
                    value.totalBalance >= 0
                        ? '₹ ${value.totalBalance}'
                        : '₹ 0.0',
                    style: const TextStyle(
                        fontSize: 25,
                        letterSpacing: 1,
                        fontFamily: 'cardFont',
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'INCOME',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'extraFont',
                                letterSpacing: 1),
                          ),
                          Consumer<TransationConsumer>(
                            builder: (context, value, child) => Text(
                              '₹${value.incomeBalance}',
                              style: const TextStyle(
                                  color: incomecolor,
                                  fontSize: 20,
                                  letterSpacing: 1,
                                  fontFamily: 'cardFont',
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Column(
                        children: [
                          const Text(
                            'EXPENSE',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'extraFont',
                                letterSpacing: 1),
                          ),
                          Consumer<TransationConsumer>(
                            builder: (context, value, child) => Text(
                              '₹ ${value.expenseBalance}',
                              style: const TextStyle(
                                  color: expensecolor,
                                  fontSize: 20,
                                  fontFamily: 'cardFont',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}

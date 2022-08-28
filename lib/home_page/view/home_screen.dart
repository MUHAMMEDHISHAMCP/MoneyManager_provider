import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/home_page/controller/transaction_consumer.dart';
import 'package:wallet_guard/home_page/model/db_function/transaction_db.dart';
import 'package:wallet_guard/home_page/view/widgets/add_screen.dart';
import 'package:wallet_guard/home_page/view/widgets/card_view.dart';
import 'package:wallet_guard/home_page/view/widgets/recent_transaction.dart';
import 'package:wallet_guard/home_page/view/widgets/view_all/transaction_overviw.dart';
import 'package:wallet_guard/widgets/controller/navigator_pro.dart';

class TransactionScreen extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  TransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TransactionDB.instance.refeshUI(context);
      // CategoryDB.instance.refreshUI(context);
    });
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: maincolor,
        shape: const BeveledRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          children: [
            TrannsactionView(),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Recent Transactions',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                TextButton(
                    onPressed: () {
                      Provider.of<ScreenNavigator>(context, listen: false)
                          .push(context, const ViewAllScreen());
                    },
                    child: const Text(
                      'View All ▶',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ))
              ],
            ),
            Expanded(child: Consumer<TransationConsumer>(
              builder: (context, value, child) {
                return value.allTransaction.isEmpty
                    ? GestureDetector(
                        onTap: (() {}),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                                'assets/undraw_add_files_re_v09g (1).svg',
                                width:
                                    MediaQuery.of(context).size.height / 4.5),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Add Transactions',
                              style: emptyStyle,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: ((context, index) {
                          final transactions = value.allTransaction[index];
                          return TransactionDetails(
                              transactionData: transactions, index: index);
                        }),
                        itemCount: (value.allTransaction.length <= 6)
                            ? value.allTransaction.length
                            : 5,
                      );
              },
            ))
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: ((context) => const AddTransactionScreen())));
            Provider.of<ScreenNavigator>(context, listen: false)
                .push(context, AddTransactionScreen());
          },
          backgroundColor: maincolor,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          child: const Icon(Icons.add),
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

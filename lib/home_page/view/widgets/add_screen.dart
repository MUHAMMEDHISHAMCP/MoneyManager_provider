// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:wallet_guard/category_page/controller/addordelete.dart';
import 'package:wallet_guard/category_page/model/db_functions/db_functions.dart';
import 'package:wallet_guard/category_page/model/db_model/category_model.dart';
import 'package:wallet_guard/category_page/view/widgets/add_popup.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/home_page/controller/addorupdate_transaction.dart';
import 'package:wallet_guard/home_page/model/db_function/transaction_db.dart';
// import 'package:wallet_guard/home_page/model/db_function/transaction_db.dart';

// ignore: must_be_immutable
class AddTransactionScreen extends StatelessWidget {
  AddTransactionScreen({Key? key}) : super(key: key);

  final notesEditController = TextEditingController();
  final amountEditController = TextEditingController();
  String counterText = '0';

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<AddorUpdateTransaction>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider.selectedCategoryType = CategoryType.income;
      provider.amountEditController.clear();
      provider.notesEditController.clear();
      provider.selectedDate = null;
      provider.categoryID = null;

      provider.notifyListeners();

      CategoryDB.instance.refreshUI(context);
    });
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.clear),
            color: optionalcolor,
          ),
          backgroundColor: subcolor,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: SingleChildScrollView(
              child: Consumer<AddorUpdateTransaction>(
                builder: (context, value, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/undraw_add_files_re_v09g (1).svg',
                      height: 170,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Add Transaction',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(
                              value: CategoryType.income,
                              groupValue: value.selectedCategoryType,
                              onChanged: (newValue) {
                                value.selectedCategoryType =
                                    CategoryType.income;
                                value.categoryID = null;
                                value.selectedCategory = null;
                                value.notifyListeners();
                              },
                              activeColor: maincolor,
                            ),
                            const Text('Income')
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              value: CategoryType.expense,
                              groupValue: value.selectedCategoryType,
                              onChanged: (newValue) {
                                value.selectedCategoryType =
                                    CategoryType.expense;
                                value.categoryID = null;
                                value.selectedCategory = null;
                                value.notifyListeners();
                              },
                              activeColor: Colors.teal.shade400,
                            ),
                            const Text('Expense')
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now()
                                .subtract(const Duration(days: 30 * 5)),
                            lastDate: DateTime.now());
                        if (selectedDate == null) {
                          return;
                        } else {
                          value.selectedDate = selectedDate;
                          value.notifyListeners();
                        }
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black45)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Icon(
                                  Icons.calendar_today,
                                  color: Colors.teal.shade400,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              value.selectedDate == null
                                  ? const Text(
                                      'Select Date',
                                      style: TextStyle(color: maincolor),
                                    )
                                  : Text('  ${value.selectedDate?.day} - '
                                      '${value.selectedDate?.month} - '
                                      '${value.selectedDate?.year}'),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: value.amountEditController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Amount',
                        counterText: '',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp("[0-9.]"))
                      ],
                      maxLength: 12,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black45)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: DropdownButton(
                                underline: const SizedBox(),
                                hint: const Text('Select Category'),
                                value: value.categoryID,
                                items: (value.selectedCategoryType ==
                                            CategoryType.income
                                        ? Provider.of<AddOrDeleteProvider>(
                                                context,
                                                listen: false)
                                            .incomeList
                                        : Provider.of<AddOrDeleteProvider>(
                                                context,
                                                listen: false)
                                            .expenseList)
                                    .map((e) {
                                  return DropdownMenuItem(
                                    value: e.id,
                                    child: Text(e.name),
                                    onTap: () {
                                      value.selectedCategory = e;
                                      value.notifyListeners();
                                    },
                                  );
                                }).toList(),
                                onChanged: (selectedValue) {
                                  // setState(() {
                                  //   _categoryID = selectedValue.toString();
                                  // });
                                  // providerSelecions.categoryId(selectedValue.toString());
                                  value.categoryId(selectedValue.toString());
                                  value.notifyListeners();
                                }),
                          ),
                          Container(
                            color: maincolor,
                            child: IconButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AddPopup(
                                          type: value.selectedCategoryType!,
                                        );
                                      }).then((newValue) {
                                    // setState(() {
                                    //   TransactionDB.instance.refeshUI(context);
                                    // });
                                    TransactionDB.instance.refeshUI(context);
                                    value.notifyListeners();
                                  });
                                },
                                icon: const Icon(Icons.add)),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: value.notesEditController,
                      decoration: const InputDecoration(
                        errorMaxLines: 5,
                        hintText: 'Notes',
                        // counterText: '',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                      // maxLength: 12,
                      minLines: 2,
                      maxLines: 5,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          //  addTransaction();
                          // Provider.of<AddorUpdateTransaction>(context,listen: false).addTransaction(context);

                          value.addTransaction(context);
                          value.selectedDate = null;
                          value.amountEditController.clear();
                          value.categoryID = null;
                          value.notesEditController.clear();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 30),
                          primary: maincolor,
                        ),
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

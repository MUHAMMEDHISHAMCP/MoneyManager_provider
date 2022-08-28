// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_guard/category_page/controller/addordelete.dart';
import 'package:wallet_guard/category_page/model/db_model/category_model.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/home_page/controller/addorupdate_transaction.dart';
import 'package:wallet_guard/home_page/model/db_model/transaction_db.dart';
import 'package:wallet_guard/widgets/delete_popup.dart';

// ignore: must_be_immutable
class EditTransactionScreen extends StatelessWidget {
  TransactionModel data;
  int index;
  EditTransactionScreen({Key? key, required this.data, required this.index})
      : super(key: key);

  // final notesEditController = TextEditingController();
  // final amountEditController = TextEditingController();

  // DateTime? currentDate;
  // // String? _categoryID;
  // String? selectedValue;

  // String counterText = '0';

  @override
  Widget build(BuildContext context) {
    final providerSelecions =
        Provider.of<AddorUpdateTransaction>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      providerSelecions.amountEditController.text = data.amount.toString();
      providerSelecions.notesEditController.text = data.notes;
      providerSelecions.updatedDate = data.date;
      providerSelecions.selectedCategoryType = data.type;
      providerSelecions.selectedCategory = data.categry;

      providerSelecions.notifyListeners();
    });

    return Scaffold(
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
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Consumer<AddorUpdateTransaction>(
                builder: (context, value, child) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'EDIT YOUR TRANSACTION',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
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
                          value.updatedDate = selectedDate;
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
                              Icon(
                                Icons.calendar_today,
                                color: Colors.teal.shade400,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              value.updatedDate == null
                                  ? const Text(
                                      'Select Date',
                                      style: TextStyle(color: maincolor),
                                    )
                                  : Text('${value.updatedDate?.day} - '
                                      '${value.updatedDate?.month} - '
                                      '${value.updatedDate?.year}'),
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownButton(
                            isExpanded: true,
                            underline: const SizedBox(),
                            hint: Text(
                              Sample.categoryName,
                              style: const TextStyle(color: Colors.black87),
                            ),
                            value: value.categoryID,
                            items: (value.selectedCategoryType ==
                                        CategoryType.income
                                    ? Provider.of<AddOrDeleteProvider>(context,
                                            listen: false)
                                        .incomeList
                                    : Provider.of<AddOrDeleteProvider>(context,
                                            listen: false)
                                        .expenseList)
                                .map((e) {
                              return DropdownMenuItem(
                                value: e.id,
                                child: Text(e.name),
                                onTap: () {
                                  value.selectedCategory = e;
                                },
                              );
                            }).toList(),
                            onChanged: (selectedValue) {
                              // _categoryID = selectedValue.toString();
                              value.categoryId(selectedValue.toString());
                            }),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: providerSelecions.notesEditController,
                      decoration: const InputDecoration(
                        hintText: 'Notes',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 5,
                      minLines: 2,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              showDeletePopup(context, id: data.id);
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(150, 30),
                              primary: expensecolor,
                            ),
                            child: const Text('Delete'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              value.updateTransaction(
                                  context, data.id.toString());
                              value.selectedDate = null;
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: const Size(150, 30),
                              primary: maincolor,
                            ),
                            child: const Text('Update'),
                          ),
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

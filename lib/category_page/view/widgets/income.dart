import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallet_guard/category_page/controller/addordelete.dart';
import 'package:wallet_guard/category_page/model/db_model/category_model.dart';
import 'package:wallet_guard/category_page/view/widgets/add_popup.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/widgets/delete_popup.dart';

class IncomeCatogery extends StatelessWidget {
  const IncomeCatogery({Key? key}) : super(key: key);
   final _type = CategoryType.income;
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_){
    //   Provider.of<AddOrDeleteProvider>(context,listen: false).incomeList;
    // });
    // TransactionDB.instance.refeshUI();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AddPopup(
                        type: _type,
                      );
                    }).then((value) {
                
                });
                
              },
              style: ElevatedButton.styleFrom(
                primary: optionalcolor,
              ),
              child: const Text('+ Add Category'),
            ),
            Expanded(
                child:Consumer<AddOrDeleteProvider>(builder: (context, value, child) => Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: value.incomeList.isEmpty
                            ? const Center(
                                child: Text(
                                'No Categories added',
                                style: emptyStyle,
                              ))
                            : GridView.builder(
                                itemCount: value.incomeList.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: MediaQuery.of(context)
                                                .size
                                                .width /
                                            (MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                5),
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 5,
                                        mainAxisSpacing: 5),
                                itemBuilder: (contex, index) {
                                  final catogery = value.incomeList[index];
                                  return InkWell(
                                    onLongPress: () {
                                      showDeletePopup(context,
                                          categoryId: catogery.id);
                                    },
                                    child: value.incomeList.isEmpty
                                        ? const Center(
                                            child: Text('No Categories added'))
                                        : Card(
                                            color: categorycolor,
                                            elevation: 3,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: FittedBox(
                                                  child: Text(
                                                    catogery.name.toUpperCase(),
                                                    style: const TextStyle(
                                                        color: incomecolor,
                                                        fontSize: 15,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontFamily:
                                                            'categoryFont'),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                  );
                                }),
                      ) ,)
                
                
                
                )
          ],
        ),
      ),
    );
  }
}

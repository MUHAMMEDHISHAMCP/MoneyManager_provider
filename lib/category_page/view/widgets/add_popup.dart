import 'package:flutter/material.dart';
import 'package:wallet_guard/category_page/model/db_functions/db_functions.dart';
import 'package:wallet_guard/category_page/model/db_model/category_model.dart';
import 'package:wallet_guard/core/constant.dart';

class AddPopup extends StatelessWidget {
  final CategoryType type;
   AddPopup({Key? key, required this.type}) : super(key: key);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _categoryNameController = TextEditingController();
  // CategoryModel? dd;
  @override
  Widget build(BuildContext context) {
    
    return SimpleDialog(
      backgroundColor: maincolor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      title: const Text(
        'Add Category',
        textAlign: TextAlign.center,
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formkey,
            child: TextFormField(
              controller: _categoryNameController,
              decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Category Name',
                  counterText: '',
                  border: OutlineInputBorder()),
              maxLength: 12,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter Category Name';
                } else {
                  return null;
                }
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: ElevatedButton(
              onPressed: () {
                final name = _categoryNameController.text;
                if (_formkey.currentState!.validate()) {
                    
                  final categoryName = CategoryModel(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      name: name,
                      type: type);

                  // TransactionDB.instance.refeshUI();
                 
                  CategoryDB.instance.insertcategory(categoryName,context);
                  Navigator.of(context).pop();
                   CategoryDB.instance.refreshUI(context);
                //  print(categoryName.name);

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                        'Category Added Successfully',
                        style: popupStyle,
                        textAlign: TextAlign.center,
                      ),
                      backgroundColor: maincolor,
                      behavior: SnackBarBehavior.floating,
                      margin:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      duration: Duration(seconds: 3)));
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              child: const Text('Add')),
        ),
      ],
    );
  }
}

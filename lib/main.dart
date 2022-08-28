import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:wallet_guard/category_page/controller/addordelete.dart';
import 'package:wallet_guard/category_page/model/db_model/category_model.dart';
import 'package:wallet_guard/home_page/controller/addorupdate_transaction.dart';
import 'package:wallet_guard/home_page/controller/transaction_consumer.dart';
import 'package:wallet_guard/home_page/model/db_model/transaction_db.dart';
import 'package:wallet_guard/widgets/controller/nav_provider.dart';
import 'package:wallet_guard/widgets/controller/navigator_pro.dart';
import 'package:wallet_guard/widgets/splash_screen.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(CategoryModelAdapter().typeId)) {
    Hive.registerAdapter(CategoryModelAdapter());
  }
  if (!Hive.isAdapterRegistered(CategoryTypeAdapter().typeId)) {
    Hive.registerAdapter(CategoryTypeAdapter());
  }
  if (!Hive.isAdapterRegistered(TransactionModelAdapter().typeId)) {
    Hive.registerAdapter(TransactionModelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NavProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddOrDeleteProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ScreenNavigator(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddorUpdateTransaction(),
        ),
        ChangeNotifierProvider(
          create: (context) => TransationConsumer(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: const SplashScreen()),
    );
  }
}

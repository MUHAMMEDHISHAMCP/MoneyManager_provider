import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wallet_guard/category_page/model/db_functions/db_functions.dart';
import 'package:wallet_guard/core/constant.dart';
import 'package:wallet_guard/home_page/model/db_function/transaction_db.dart';
import 'package:wallet_guard/widgets/controller/navigator_pro.dart';
import 'package:wallet_guard/widgets/splash_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TimeOfDay currentTime = TimeOfDay.now();
  bool isChanged = false;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'SETTINGS',
          style: appBarStyle,
        ),
        backgroundColor: maincolor,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 10),
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: optionalcolor,
                radius: 15,
                child: Icon(
                  Icons.notification_add,
                  color: Colors.white,
                ),
              ),
              title: const Text(
                'Set Reminder',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              trailing: IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (ctx) {
                          return AlertDialog(
                            elevation: 4,
                            title: const Text(
                              'Cancel Reminder !! ',
                              textAlign: TextAlign.center,
                            ),
                            content: const Text(
                              'Did you want cancel the reminder?',
                              textAlign: TextAlign.center,
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  //   NotificationApi.cancelNotification();
                                  Navigator.of(context).pop();
                                  setState(() {
                                    isChanged = false;
                                    // pref.setBool('isOn', isChanged);
                                  });
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        });
                  },
                  icon: const Icon(Icons.notifications_off_outlined)),
              onTap: () {
                //   timePicking(context: context);
              },
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: optionalcolor,
                radius: 15,
                child: Icon(
                  Icons.delete_outlined,
                  color: Colors.white,
                ),
              ),
              title: const Text(
                'Clear App Data',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        elevation: 4,
                        title: const Text('Alert !!'),
                        content: const Text(
                            'You will lose your all datas!! \n Are you sure to want to Clear? '),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No'),
                          ),
                          TextButton(
                            onPressed: () async {
                              final pref =
                                  await SharedPreferences.getInstance();
                              pref.remove('savedValue');
                              TransactionDB.instance.resetApp();
                              CategoryDB.instance.resetCategory();
                              //  NotificationApi.cancelNotification();
                              Provider.of<ScreenNavigator>(context,
                                      listen: false)
                                  .pushReplacment(
                                      context, const SplashScreen());
                            },
                            child: const Text(
                              'Yes',
                              style: TextStyle(color: expensecolor),
                            ),
                          ),
                        ],
                      );
                    });
              },
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: optionalcolor,
                radius: 15,
                child: Icon(
                  Icons.info_rounded,
                  color: Colors.white,
                ),
              ),
              title: const Text(
                'About App',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 3,
                        title: Column(
                          children: [
                            Image.asset('assets/abtlogo.png',
                                width: MediaQuery.of(context).size.height / 5),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Wallet Guard',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        content: const Text(
                          'Wallet Guard is a user friendly Money Managment app which allows you to keep track your transactions seamessly. it helps you to cetrgorize your spending, to create a budget and to stay within the limit by you, and also provides you a deatailed  analysiss of your spending habits ',
                          style: TextStyle(fontSize: 15),
                        ),
                      );
                    });
              },
            ),
            const Divider(
              thickness: 1,
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: optionalcolor,
                radius: 15,
                child: Icon(
                  Icons.share,
                  size: 17,
                  color: Colors.white,
                ),
              ),
              title: const Text(
                'Share This App',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              onTap: () {
                Share.share(
                    "https://play.google.com/store/apps/details?id=com.wallet_guard");
              },
            ),
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                  Text(
                    'v.1.0.1',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  )
                ]))
          ],
        ),
      ),
    );
  }

  // timePicking({required context}) async {
  //   final TimeOfDay? pickedTIme = await showTimePicker(
  //     initialEntryMode: TimePickerEntryMode.input,
  //     context: context,
  //     initialTime: currentTime,
  //   );
  //   if (pickedTIme != null && pickedTIme != currentTime) {
  //     setState(() {
  //       NotificationApi.showScheduledNotifications(
  //           title: "Wallet Guard",
  //           body: "Don't forget add your Transactions",
  //           scheduledTime: Time(pickedTIme.hour, pickedTIme.minute, 0));
  //       isChanged = true;
  //     });

  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         elevation: 0,
  //         content: Text(
  //           'You have set a reminder At ${pickedTIme.hour > 21 ? pickedTIme.hour - 12 : pickedTIme.hour > 12 ? '0${pickedTIme.hour - 12}' : pickedTIme.hour == 0 ? '12' : pickedTIme.hour < 10 ? '0${pickedTIme.hour}' : pickedTIme.hour}:${pickedTIme.minute < 10 ? '0${pickedTIme.minute}' : pickedTIme.minute} ${pickedTIme.hour < 12 ? 'AM' : 'PM'} ',
  //           style: popupStyle,
  //           textAlign: TextAlign.center,
  //         ),
  //         backgroundColor: Colors.white,
  //         behavior: SnackBarBehavior.floating,
  //         duration: Duration(seconds: 3)));
  //   }
  // }
}

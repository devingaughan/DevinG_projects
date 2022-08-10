import 'package:flutter/material.dart';
import 'package:testing/Utils/notificationservice.dart';
import 'package:testing/homepage.dart';
import 'package:testing/Utils/themes.dart';

/*
  main function
  Needed to run the app
  Had to make the function asynchronous to allow
  the app to wait on firebase to initialize.
 */

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const MyApp());
}

/*
 MyApp Class
 Class app launches from. Builds Material UI
 */

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Themes.lightMode(),
      darkTheme: Themes.darkMode(),
      themeMode: ThemeMode.system, // Uses phone theme
      home: const HomePage(),
      debugShowCheckedModeBanner: false, // Open Homepage upon app launch
    );
  }
}
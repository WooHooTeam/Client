import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myapp/Screens/Welcome/welcom_screen.dart';
import 'package:myapp/contants.dart';

void main() async {
  await initializeDateFormatting();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  //this widget is a root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter_Login",
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
    );
  }
}

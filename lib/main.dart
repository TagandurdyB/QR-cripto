import 'package:flutter/material.dart';
import 'Pages/MainPage.dart';
import 'Public.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,

        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Colors.grey[500]),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(60)),
              borderSide: BorderSide(color: Colors.purpleAccent)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(60)),
              borderSide: BorderSide(color: Colors.grey[500])),
        ),
          textTheme: TextTheme(
            bodyText1: TextStyle(),
            bodyText2: TextStyle(),
          ).apply(
            bodyColor: Colors.white,
          ),
        accentIconTheme: IconThemeData(color:Colors.white)

      ),
      home: MainPage(),
    );
  }
}

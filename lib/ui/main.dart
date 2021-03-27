import 'package:flutter/material.dart';
import 'package:flutter_app2/ui/authentication.dart';

void main() async {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDoList',
      theme: ThemeData(
        primaryColor: Color(0xff40e0d0),
        textTheme: Theme.of(context).textTheme.apply(
            fontFamily: 'Poppins'),
      ),
      home: Authentication(),
      debugShowCheckedModeBanner: false,
    );
  }
}
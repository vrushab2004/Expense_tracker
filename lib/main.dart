import 'package:expense_tracker/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(const ExpanseApp());
}

class ExpanseApp extends StatelessWidget {
  const ExpanseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
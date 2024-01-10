import 'package:expense_tracker/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main()
async{
 WidgetsFlutterBinding.ensureInitialized();
  final appDocumentsDirectory = await path_provider.getApplicationDocumentsDirectory();
   Hive.init(appDocumentsDirectory.path);
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
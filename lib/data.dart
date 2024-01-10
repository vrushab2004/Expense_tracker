import 'dart:io';
import 'package:hive/hive.dart';

class ExpenseData{
  double ammount;
  String reasons;
  ExpenseData({required this.ammount , required this.reasons});
}

class ExpenseTracker{
  static List expenseHistory = [];
  static Future<void> addData(ExpenseData data)async{
    expenseHistory.add(data);
    var box = await Hive.box('Expense');
    box.put("ExpenseList" , expenseHistory);
    await box.close();
  }
  static void removeItem(int index){
    expenseHistory.removeAt(index);
  }
}
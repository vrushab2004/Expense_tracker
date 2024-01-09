import 'dart:io';

class ExpenseData{
  String ammount;
  String reasons;
  ExpenseData({required this.ammount , required this.reasons});
}

class ExpenseTracker{
  static List expenseHistory = [];
  static void addData(ExpenseData data){
    expenseHistory.add(data);
  }
  static void removeItem(int index){
    expenseHistory.removeAt(index);
  }
}
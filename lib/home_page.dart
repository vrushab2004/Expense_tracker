import 'package:expense_tracker/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _ammountController = TextEditingController();
  TextEditingController _reasonController = TextEditingController();
  @override
  void dispose() {
    _ammountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(middle: Text('Hello')),
      floatingActionButton: CupertinoButton(onPressed: (){
        showDialog(context: context, builder: (context){
          return CupertinoAlertDialog(
            title: Text('Add money'),
            content: Container(height: 100,child: Column(children: [CupertinoTextField(placeholder: ('Enter money'),controller: _ammountController,),const SizedBox(height: 10,),CupertinoTextField(placeholder: ('Description'),controller: _reasonController,),],),),
            actions: [
              TextButton(child: Text("OK"),onPressed: (){setState(() {
                ExpenseTracker.addData(ExpenseData(ammount: _ammountController.text, reasons: _reasonController.text),);
                Navigator.pop(context);
              });},),
              TextButton(child: Text("CANCEL") , onPressed: (){Navigator.pop(context);},)
            ],
          );
        }
        );
      } , child: Icon(CupertinoIcons.add),),
      body: ListView.builder(itemBuilder: (context , index){
            return Center(
      child: Container(
        margin:const EdgeInsets.only(top: 10 , left: 10 , right: 10),
        child: Card(
          surfaceTintColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 10,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               ListTile(
                leading: Icon(Icons.attach_money , size: 30, color: Colors.black,),
                title: Text(ExpenseTracker.expenseHistory[index].ammount , style: GoogleFonts.varelaRound(color: Colors.black , fontSize: 24 , fontWeight: FontWeight.bold),),
                subtitle: Text(ExpenseTracker.expenseHistory[index].reasons , style: GoogleFonts.varelaRound(color: Colors.grey , fontSize: 17 , fontWeight: FontWeight.normal),),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    child:Icon(Icons.delete,size: 30,color: Colors.red.shade800,),
                    onPressed: () {setState(() {
                      ExpenseTracker.removeItem(index);
                    });},
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ],
          ),
        ),
      ),
    );
            
      },itemCount: ExpenseTracker.expenseHistory.length,),
    );
  }
}
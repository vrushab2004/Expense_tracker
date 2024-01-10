import 'package:expense_tracker/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _ammountController = TextEditingController();
  final TextEditingController _reasonController = TextEditingController();
  List data = [];
  @override
  void initState() async{
    var box = await Hive.box('Expense');
    data = await box.get("ExpenseList");
    box.close();
    super.initState();
  }
  @override
  void dispose() {
    _ammountController.dispose();
    _reasonController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:const CupertinoNavigationBar(middle: Text('Hello'),),
      floatingActionButton: CupertinoButton(onPressed: (){
        showDialog(context: context, builder: (context){
          return CupertinoAlertDialog(
            title:const Text('Add money'),
            content: SizedBox(height: 100,child: Column(children: [CupertinoTextField(placeholder: ('Enter money'),controller: _ammountController,),const SizedBox(height: 10,),CupertinoTextField(placeholder: ('Description'),controller: _reasonController,),],),),
            actions: [
              TextButton(child:const Text("OK"),onPressed: (){setState(() {
                ExpenseTracker.addData(ExpenseData(ammount: double.parse(_ammountController.text), reasons: _reasonController.text),);
                Navigator.pop(context);
                _ammountController.text = "";
                _reasonController.text = "";
              });},),
              TextButton(child:const Text("CANCEL") , onPressed: (){Navigator.pop(context);_ammountController.text = "";
                _reasonController.text = "";},),
            ],
          );
        }
        );
      } , child:const Icon(CupertinoIcons.add),),
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
                leading:const Icon(Icons.attach_money , size: 30, color: Colors.black,),
                title: Text("${data[index].ammount}" , style: GoogleFonts.varelaRound(color: Colors.black , fontSize: 24 , fontWeight: FontWeight.bold),),
                subtitle: Text(data[index].reasons, style: GoogleFonts.varelaRound(color: Colors.grey , fontSize: 17 , fontWeight: FontWeight.normal),),
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
            
      },itemCount: data.length,reverse: true,shrinkWrap: true,),
    );
  }
}
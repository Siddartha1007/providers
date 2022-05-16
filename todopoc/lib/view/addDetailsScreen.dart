import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todopoc/models/stuClass.dart';
import 'package:todopoc/controllers/stucontrollers.dart';
import 'package:todopoc/view/dashBoard.dart';
import 'package:todopoc/viewmodels/buttonWidget.dart';

class AddDetailsScreen extends StatefulWidget {
  const AddDetailsScreen({ Key? key }) : super(key: key);

  @override
  State<AddDetailsScreen> createState() => _AddDetailsScreenState();
}

class _AddDetailsScreenState extends State<AddDetailsScreen> {

  final StuController _stuController = Get.find();
  final _formKey = GlobalKey<FormState>();

  TextEditingController name = new TextEditingController();
  TextEditingController clgname = new TextEditingController();
  TextEditingController branch = new TextEditingController();
  TextEditingController year = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Todo")),
      body: Container(
        margin: EdgeInsets.only(top: 15, left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            children:[
                    SizedBox(height: 10),
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Enter Name"),
                        controller: name,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Enter College Name"),
                        controller: clgname,
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Enter Branch"),
                        controller: branch,
                     ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      child: TextFormField(
                        decoration: InputDecoration(hintText: "Enter Year"),
                        controller: year,
                      ),
                    ),
                    SizedBox(height: 8),
        
                    ButtonWidget(
                          label: 'Add Task',
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              final StuClass task = StuClass();
                              _addTaskToDB(task);
                              await _stuController.addToDb(task);
                              Get.back();
                            }
                          },
                    ),
                    SizedBox(height: 10),      
            ]
          ),
        ),
      )
    );
  }
  _addTaskToDB(StuClass task) {
    task.name = name.text;
    task.clgname = clgname.text;
    task.branch = branch.text;
    task.year = year.text;
  }
}

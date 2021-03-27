import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/model/task_model.dart';
import 'package:flutter_app2/net/database_helper.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddTask extends StatefulWidget {
  final Function updateTaskList;
  final Task task;
  AddTask({this.updateTaskList,this.task});

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {

  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _priority;
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');
  final List<String> _priorities = ['Low', 'Medium', 'High'];

  @override
  void initState(){
    super.initState();
    if(widget.task != null){
      _title = widget.task.title;
      _date = widget.task.date;
      _priority = widget.task.priority;
    }
    _dateController.text = _dateFormatter.format(_date);
  }

  @override
  void dispose(){
    super.dispose();
    _dateController.dispose();
  }

  _handleDatePicker() async{
    final DateTime date = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if(date != null && date != _date){
      setState(() {
        _date = date;
      });
      _dateController.text = _dateFormatter.format(date);
    }
  }

  _delete(){
    DatabaseHelper.instance.deleteTask(widget.task.id);
    widget.updateTaskList();
    Navigator.pop(context);
  }

_submit(){
    if(_formKey.currentState.validate()){
      _formKey.currentState.save();
      print('$_title, $_date, $_priority');
      //insert the task to our database
      Task task = Task(title: _title, date: _date, priority: _priority);
      if(widget.task == null){
        task.status = 0;
        DatabaseHelper.instance.insertTask(task);
      }else{
        task.id = widget.task.id;
        task.status = widget.task.status;
        DatabaseHelper.instance.updateTask(task);

      }
      widget.updateTaskList();
      // update

      Navigator.pop(context);
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40.0,vertical: 80.0,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(onTap: () =>Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios,
                size: 30.0,
                color: Colors.black,),
                ),
                SizedBox(height: 20.0,),
                Text(
                  widget.task == null ?'Add Task':'Update Task',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                ),
                ),
                SizedBox(height: 10.0,),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0,),
                        child: TextFormField(
                            style:TextStyle(fontSize: 18.0,),
                          decoration: InputDecoration(
                            labelText: 'Title',
                            labelStyle: TextStyle(
                              fontSize: 18.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (input) => input.trim().isEmpty ? 'Please enter a task title':null,
                          onSaved: (input) => _title = input,
                          initialValue: _title,
                        ),
                      ),
                      Padding(

                        padding: EdgeInsets.symmetric(vertical: 20.0,),
                        child: TextFormField(
                          readOnly: true,
                          controller: _dateController,
                          style:TextStyle(fontSize: 18.0,),
                          onTap: _handleDatePicker,
                          decoration: InputDecoration(
                            labelText: 'Date',
                            labelStyle: TextStyle(
                              fontSize: 18.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.0,),
                        child: DropdownButtonFormField(
                          isDense: true,
                          icon: Icon(Icons.arrow_drop_down_circle,),
                          iconSize: 22.0,
                          iconEnabledColor: Color(0xff40e0d0),
                          items: _priorities.map((String priority){
                            return DropdownMenuItem(
                              value: priority,
                              child: Text(
                                priority,
                                style: TextStyle(color: Colors.black,
                                fontSize: 18.0,
                                ),
                              ),
                            );
                          }).toList(),
                          style:TextStyle(fontSize: 18.0,),
                          decoration: InputDecoration(
                            labelText: 'Priority',
                            labelStyle: TextStyle(
                              fontSize: 18.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (input) => _priority == null
                              ? 'Please select a priority level'
                              :null,
                          onSaved: (input) => _priority = input,
                          onChanged: (value){
                            setState(() {
                              _priority = value;
                            });
                          },
                          value: _priority,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0,),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xff40e0d0),
                          borderRadius: BorderRadius.circular(30.0,),
                        ),
                        child: FlatButton(
                          child: Text(
                            widget.task == null ?'Add': 'Update',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                          ),
                          onPressed: _submit,
                        ),
                      ),
                      widget.task != null ? Container(
                        margin: EdgeInsets.symmetric(vertical: 20.0,),
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xff40e0d0),
                          borderRadius: BorderRadius.circular(30.0,),
                        ),
                        child: FlatButton(
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                            ),
                          ),
                          onPressed: _delete,
                        ),
                      ): SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

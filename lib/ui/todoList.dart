import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/net/database_helper.dart';
import 'package:intl/intl.dart';
import 'addTask.dart';
import 'package:flutter_app2/model/task_model.dart';


class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  Future <List<Task>> _taskList;
  final DateFormat _dateFormatter = DateFormat('MMM dd, yyyy');

  @override
  void initState(){
    super.initState();
    _updateTaskList();
  }

  _updateTaskList(){
    setState(() {
      _taskList = DatabaseHelper.instance.getTaskList();
    });
  }

  Widget _buildTask(Task task){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0 ),
      child: Column(
        children: [
          ListTile(
            title: Text(task.title , style: TextStyle(fontSize: 18.0,
            decoration: task.status == 0 ? TextDecoration.none: TextDecoration.lineThrough,
            ),
            ),
            subtitle: Text('${_dateFormatter.format(task.date)} - ${task.priority}',
              style: TextStyle(
                fontSize: 15.0,
                decoration: task.status == 0 ? TextDecoration.none: TextDecoration.lineThrough,
              ),
            ),
            trailing: Checkbox(onChanged: (value){
              task.status = value ? 1 : 0 ;
              DatabaseHelper.instance.updateTask(task);
              _updateTaskList();
            },
              activeColor: Color(0xff40e0d0),
              value: task.status == 1 ? true:false,
            ),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AddTask(
              updateTaskList: _updateTaskList,
              task: task,
            ),
            ),
            ),
          ),
          Divider(
            color: Colors.black,
            thickness: 0.25,
          ),
        ],
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff40e0d0),
      child: Icon(Icons.add),
        onPressed: (){
          Navigator.push(context,MaterialPageRoute(builder: (_) => AddTask(
            updateTaskList: _updateTaskList,
          ),
          ),
          );
        }
      ),
      body: FutureBuilder(
        future: _taskList,
        builder: (context,snapshot) {
          if(!snapshot.hasData){
            return Center(child:CircularProgressIndicator(),);
          }
        final int completedTaskCount = snapshot.data.where((Task task ) => task.status == 1).toList().length;
          return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 80.0),
          itemCount: 1 + snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('My Tasks',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 40.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text('$completedTaskCount of ${snapshot.data.length}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }
            return _buildTask(snapshot.data[index - 1]);
          },
        );
      },
      ),
    );
  }
}

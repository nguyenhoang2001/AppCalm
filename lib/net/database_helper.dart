import 'dart:io';
import 'package:flutter_app2/model/task_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper
{
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database _db;

  DatabaseHelper._instance();

  String tasksTables = 'task_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDate = 'date';
  String colPriority = 'priority';
  String colStatus = 'status';

//Task Table
//Id | Title | Date | Priority | Status
//0     ..      ..       ..        0
//2     ..      ..       ..        0
//3     ..      ..       ..        0

  Future<Database> get db async
  {
    if (_db == null)
    {
      _db = await _initDb();
    }
    return _db;
  }

  Future<Database> _initDb() async
  {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'todo_list.db';
    final todoListDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return todoListDb;
  }

  void _createDb (Database db, int version) async
  {
    await db.execute('CREATE TABLE $tasksTables($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDate TEXT, $colPriority TEXT, $colStatus INTEGER)',
    );

  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async
  {
    Database db = await this.db;
    final List<Map<String, dynamic>> result = await db.query(tasksTables);
    return result;
  }

  Future<List<Task>> getTaskList() async
  {
    final List<Map<String, dynamic>> taskMapList = await getTaskMapList();
    final List<Task> taskList = [];
    taskMapList.forEach((taskMap){
      taskList.add(Task.fromMap(taskMap));
    });
    taskList.sort((taskA, taskB) => taskA.date.compareTo(taskB.date));
    return taskList;
  }

  Future<int> insertTask(Task task) async
  {
    Database db = await this.db;
    final int result = await db.insert(tasksTables, task.toMap());
    return result;
  }

  Future<int> updateTask(Task task) async
  {
    Database db = await this.db;
    final int result = await db.update(
      tasksTables,
      task.toMap(),
      where: '$colId = ?',
      whereArgs: [task.id],
    );
    return result;
  }

  Future<int> deleteTask(int id) async
  {
    Database db = await this.db;
    final int result = await db.delete(
      tasksTables,
      where: '$colId = ?',
      whereArgs: [id],
    );
    return result;
  }

}
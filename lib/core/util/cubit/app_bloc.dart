import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';
import 'package:tasks_app/core/util/cubit/states.dart';

class AppBloc extends Cubit<AppStates> {
  AppBloc() : super(AppInitialState());

  Database? database;

  static AppBloc get(context) => BlocProvider.of<AppBloc>(context);

  void initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, 'tasks.db');

    debugPrint("AppDataBaseInitialized");
    openAppDatabase(
      path: path,
    );

    emit(AppDataBaseInitialized());
  }

  void openAppDatabase({
    required String path,
  }) async {
    openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute(
        'CREATE TABLE tasks ('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'title STRING, '
        'date STRING, '
        'startTime STRING, '
        'endTime STRING, '
        'remind INTEGER, '
        'repeat STRING, '
        'color INTEGER, '
        'status STRING) ',
      );

      debugPrint("Table created");
    }, onOpen: (Database db) {
      debugPrint("AppDatabaseOpened");
      database = db;
      getTasksData();
    });
  }
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController remindController = TextEditingController();
  TextEditingController repeatController = TextEditingController();
  int colorIndex = 0;

  void insertTaskData({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    required String remind,
    required String repeat,
    required int color,
    String status = 'new',
  }) {
    database?.transaction((txn) async {
      txn
          .rawInsert(
        'INSERT INTO tasks(title,date,startTime,endTime,remind,repeat,color,status) VALUES("$title","$date","$startTime","$endTime","$remind","$repeat","$color","$status")',
      )
          .then((value) {
        debugPrint('$value inserted done');
      }).catchError((error) {
      });

      getTasksData();
      emit(AppDataBaseTaskCreated());
    });
  }

  List<Map> tasks = [];
  List<Map> completedTasks = [];
  List<Map> unCompletedTasks = [];
  List<Map> favoriteTasks = [];

  void getTasksData() async {
    emit(AppDataBaseLoading());
    await database?.rawQuery("SELECT  * FROM tasks").then((value) {
      debugPrint("Tasks data fetched");
      tasks = value;
      value.forEach((element) {
        if (element['status'] == 'new') {
          unCompletedTasks.add(element);
        } else if (element['status'] == 'completed') {
          completedTasks.add(element);
        }
        if (element['status'] == 'favorite') {
          favoriteTasks.add(element);
        }
        debugPrint(element.toString());
      });
      debugPrint(tasks.toString());
      emit(AppDataBaseTasks());
    });
  }

  void updateTaskStatus(
      {required String taskStatus, required int taskId}) async {
    await database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ? ',
        [taskStatus, taskId]).then((value) {
      emit(TaskUpdateDone());
      print(tasks);
    });
  }

}

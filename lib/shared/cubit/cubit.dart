import 'package:flutter/material.dart';
import 'package:flutter_app6/Network/local/cache_helper.dart';
import 'package:flutter_app6/modules/archive_tasks/archive_tasks_screen.dart';
import 'package:flutter_app6/modules/done_tasks/done_tasks_screen.dart';
import 'package:flutter_app6/modules/new_tasks/new_tasks_screen.dart';
import 'package:flutter_app6/shared/compoments/Constants.dart';
import 'package:flutter_app6/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  var currentindex = 0;
  List<Widget> screens = [
    new_tasks_screen(),
    done_tasks_screen(),
    archived_tasks_screen(),
  ];
  late Database database;
  List<String> names = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void chagneindex(int index) {
    currentindex = index;
    emit(AppchangeBottomNabBarState());
  }

  //1.Create database
//2.Create tables
//3.Open database
//4.Insert to database
//5.Get data from database
//6.Update in database
//7.Delete from database
  void createDatabase() async {
    return openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'create table tasks(id INTEGER PRIMARY KEY,title text,date text,time text,status text)')
            .then((value) => {
                  print('table created'),
                })
            .catchError((error) {
          print('error ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database opened');
      },
    ).then((value) => {
          print('object'),
          emit(AppCreateDatabaseState()),
        });
  }

  // Insert some records in a transaction
  insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database
        .transaction((txn) async {
          int id1 = await txn.rawInsert(
              'INSERT INTO tasks(title,time,date) VALUES("$title","$time","$date"');
          print('inserted1: $id1');
        })
        .then((value) => {
              print('$value inserted successfully'),
              emit(AppInsertDatabaseState()),
            })
        .catchError((onError) {
          print('Error When Inserting New Record ${onError.toString()}');
        });
  }

// Get the records
  Future<List<Map>> getDataFromDatabase(datebase) async {
    return await database.rawQuery('SELECT * FROM tasks');
  }

  IconData fabicon = Icons.edit;
  bool isBottomSheetShown = false;

  void changebuttomsheetstate(IconData icon, bool ishow) {
    isBottomSheetShown = ishow;
    fabicon = icon;
    emit(AppChangebuttomNavBarState());
  }

  bool isDark = false;

  void changeMode({bool? fromShared}) {
    if (fromShared != null)
    {
      isDark = fromShared;
      emit(ChangeAppModestate());
    }
    else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', value: isDark)
          .then((value) => {emit(ChangeAppModestate())});
    }
  }
}

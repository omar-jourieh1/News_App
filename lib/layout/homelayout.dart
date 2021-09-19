import 'package:flutter/material.dart';
import 'package:flutter_app6/shared/compoments/Constants.dart';
import 'package:flutter_app6/shared/cubit/cubit.dart';
import 'package:flutter_app6/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class HomeLayout extends StatelessWidget {
  var titlecontroller = TextEditingController();
  var timecontroller = TextEditingController();
  var datecontroller = TextEditingController();

  @override
  var scaffolkey = GlobalKey<ScaffoldState>();
  var val = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffolkey,
            appBar: AppBar(
              title: Text(AppCubit.get(context)
                  .names[AppCubit.get(context).currentindex]),
            ),
            body: tasks.length == 0
                ? Center(child: CircularProgressIndicator())
                : AppCubit.get(context)
                    .screens[AppCubit.get(context).currentindex],
            floatingActionButton: FloatingActionButton(
                child: Icon(cubit.fabicon),
                onPressed: () {
                  if (cubit.isBottomSheetShown) {
                    if (val.currentState!.validate()) {}
                  } else {
                    scaffolkey.currentState!
                        .showBottomSheet(
                          (context) => SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Container(
                                color: Colors.grey[100],
                                child: Form(
                                  key: val,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: titlecontroller,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Type The Title of Task';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Task Title',
                                          prefixIcon:
                                              Icon(Icons.title_outlined),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: timecontroller,
                                        onTap: () {
                                          showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now())
                                              .then((value) => {
                                                    timecontroller.text = value!
                                                        .format(context)
                                                        .toString(),
                                                    print(value.toString()),
                                                  });
                                        },
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Type Time of Task';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Task Time',
                                          prefixIcon: Icon(Icons.cloud_circle),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: datecontroller,
                                        onTap: () {
                                          showDatePicker(
                                                  context: context,
                                                  initialDate: DateTime.now(),
                                                  firstDate: DateTime.now(),
                                                  lastDate: DateTime(2050))
                                              .then((value) => {
                                                    datecontroller.text =
                                                        DateFormat.yMMMd()
                                                            .format(value!),
                                                    print(DateFormat.yMMMd()
                                                        .format(value)),
                                                  });
                                        },
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Type Date of Task';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          labelText: 'Task Date',
                                          prefixIcon:
                                              Icon(Icons.date_range_outlined),
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          elevation: 20,
                        )
                        .closed
                        .then((value) =>
                            {cubit.changebuttomsheetstate(Icons.edit, false)});
                    cubit.changebuttomsheetstate(Icons.add, true);
                  }
                }),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: AppCubit.get(context).currentindex,
              onTap: (index) {
                AppCubit.get(context).chagneindex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Task'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive), label: 'Archive'),
              ],
            ),
          );
        },
        listener: (BuildContext context, AppStates state) {
          if (state is AppInsertDatabaseState) {
            AppCubit.get(context).insertDatabase(
                title: titlecontroller.text,
                time: timecontroller.text,
                date: datecontroller.text);
            AppCubit.get(context).changebuttomsheetstate(Icons.edit, false);
          }
        },
      ),
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app6/Network/local/cache_helper.dart';
import 'package:flutter_app6/Network/remote/dio_helper.dart';
import 'package:flutter_app6/layout/News/Cubit/cubit.dart';
import 'package:flutter_app6/layout/News/NewsAppHome.dart';
import 'package:flutter_app6/shared/bloc_observer.dart';
import 'package:flutter_app6/shared/cubit/cubit.dart';
import 'package:flutter_app6/shared/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  Dio_helper.init();
  await CacheHelper.init();
  bool? isDark = CacheHelper.getData(key: 'isDark');

  runApp(MyApp(true));
}

//Stateless
//Stateful

//class MyApp

class MyApp extends StatelessWidget {
  final bool isDark;
  MyApp(this.isDark);

  //constructor
  //build
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSport()
            ..getScience(),
        ),
        BlocProvider(
            create: (BuildContext context) => AppCubit()
              ..changeMode(
                fromShared: isDark,
              )),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              themeMode: AppCubit.get(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              darkTheme: ThemeData(
                  scaffoldBackgroundColor: HexColor('#212121'),
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.black,
                      statusBarIconBrightness: Brightness.light,
                    ),
                    elevation: 0.0,
                    iconTheme: IconThemeData(color: Colors.white),
                    titleTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    backgroundColor: HexColor('#212121'),
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      elevation: 50,
                      backgroundColor: HexColor('#212121')),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400))),
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                  scaffoldBackgroundColor: Colors.white,
                  appBarTheme: AppBarTheme(
                    titleSpacing: 20,
                    backwardsCompatibility: false,
                    systemOverlayStyle: SystemUiOverlayStyle(
                      statusBarColor: Colors.white,
                      statusBarIconBrightness: Brightness.dark,
                    ),
                    elevation: 0.0,
                    iconTheme: IconThemeData(color: Colors.black),
                    titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    backgroundColor: Colors.white,
                  ),
                  bottomNavigationBarTheme: BottomNavigationBarThemeData(
                      type: BottomNavigationBarType.fixed,
                      selectedItemColor: Colors.deepOrange,
                      elevation: 3,
                      backgroundColor: Colors.white),
                  textTheme: TextTheme(
                      bodyText1: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w400))),
              home: NewsAppHome());
        },
      ),
    );
  }
}

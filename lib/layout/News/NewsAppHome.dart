import 'package:flutter/material.dart';
import 'package:flutter_app6/layout/News/Cubit/cubit.dart';
import 'package:flutter_app6/layout/News/Cubit/states.dart';
import 'package:flutter_app6/layout/News/search.dart';
import 'package:flutter_app6/shared/cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsAppHome extends StatefulWidget {
  const NewsAppHome({Key? key}) : super(key: key);

  @override
  _NewsAppHomeState createState() => _NewsAppHomeState();
}

class _NewsAppHomeState extends State<NewsAppHome> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (conext, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('New App'),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Search()));
                    },
                    icon: Icon(Icons.search)),
                IconButton(
                    onPressed: () {
                      AppCubit.get(context).changeMode();
                    },
                    icon: Icon(Icons.brightness_4_outlined))
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentindex,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              items: cubit.bottom,
            ),
            body: cubit.Screens[cubit.currentindex],
          );
        });
  }
}

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app6/Network/remote/dio_helper.dart';
import 'package:flutter_app6/layout/News/Cubit/states.dart';
import 'package:flutter_app6/layout/News/search.dart';
import 'package:flutter_app6/modules/bussines_screen/bussines.dart';
import 'package:flutter_app6/modules/settings/settings_screen.dart';
import 'package:flutter_app6/science_screen/science.dart';
import 'package:flutter_app6/sport_screen/sport_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitiaState());

  static NewsCubit get(context) => BlocProvider.of(context);
  int currentindex = 0;
  List<BottomNavigationBarItem> bottom = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Bussines'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];

  List<Widget> Screens = [
    bussines(),
    sport(),
    science(),
  ];

  void changeBottomNavBar(int index) {
    currentindex = index;
    if (index == 1)
      getSport();
    else if (index == 2) getScience();
    emit(NewsBottomNavBarState());
  }

  List<dynamic> bussiness = [];
  void getBusiness() {
    emit(NewsGetLoadsState());
    //https://newsapi.org/v2/top-headlines?country=eg&apiKey=f491eb88a5cb41a4b2d8485ca422f37b
    Dio_helper.getData(url: 'v2/top-headlines', query: {
      'country': 'eg',
      'category': 'business',
      'apiKey': '7ea75621b7644ae6a278ed3463917370'
    })
        .then((value) => {
              print(value.data.toString()),
              bussiness = value.data['articles'],
              emit(NewsGetBusinessSuccessState()),
            })
        .catchError((onError) {
      print(onError.toString());
      emit(NewsGetBusinessErrorState(onError.toString()));
    });
  }

  List<dynamic> sports = [];
  void getSport() {
    emit(NewsGetLoadsState());
    if (sports.length == 0) {
      Dio_helper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': '7ea75621b7644ae6a278ed3463917370'
      })
          .then((value) => {
                print(value.data.toString()),
                sports = value.data['articles'],
                emit(NewsGetSportsSuccessState()),
              })
          .catchError((onError) {
        print(onError.toString());
        emit(NewsGetSportsErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
    //https://newsapi.org/v2/top-headlines?country=eg&apiKey=f491eb88a5cb41a4b2d8485ca422f37b
  }

  List<dynamic> Science = [];
  void getScience() {
    emit(NewsGetLoadsState());
    if (sports.length == 0) {
      //https://newsapi.org/v2/top-headlines?country=eg&apiKey=f491eb88a5cb41a4b2d8485ca422f37b
      Dio_helper.getData(url: 'v2/top-headlines', query: {
        'country': 'eg',
        'category': 'Science',
        'apiKey': '7ea75621b7644ae6a278ed3463917370'
      })
          .then((value) => {
                print(value.data.toString()),
                Science = value.data['articles'],
                emit(NewsGetScienceSuccessState()),
              })
          .catchError((onError) {
        print(onError.toString());
        emit(NewsGetScienceErrorState(onError.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> Search = [];

  void GetSearch(String value) {
  Search=[];
       emit(NewsGetLoadsState());
    //https://newsapi.org/v2/everything?q=tesla&apiKey=f491eb88a5cb41a4b2d8485ca422f37b
    Dio_helper.getData(url: 'v2/everything', query: {
      'q': '$value',
      'apiKey': '7ea75621b7644ae6a278ed3463917370'
    })
        .then((value) => {
              print(value.data.toString()),
              Search = value.data['articles'],
              emit(NewsSearchSuccessState()),
            })
        .catchError((onError) {
      print(onError.toString());
      emit(NewsGetSearchErrorState(onError.toString()));
    });
  }
}

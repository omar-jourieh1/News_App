import 'package:flutter/material.dart';
import 'package:flutter_app6/Network/remote/dio_helper.dart';
import 'package:flutter_app6/layout/News/Cubit/cubit.dart';
import 'package:flutter_app6/layout/News/Cubit/states.dart';
import 'package:flutter_app6/shared/compoments/Compoments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class bussines extends StatelessWidget {
  const bussines({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      builder: (context, state) {
        var list = NewsCubit.get(context).bussiness;
        if (list.length > 0) {
          return ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildArticleItem(list[index], context),
              separatorBuilder: (context, index) => SizedBox(
                    height: 20,
                  ),
              itemCount: 10);
        } else {
          return Center(
            child: CircularProgressIndicator(color: Colors.deepOrange),
          );
        }
      },
      listener: (context, state) {},
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_app6/layout/News/Cubit/cubit.dart';
import 'package:flutter_app6/layout/News/Cubit/states.dart';
import 'package:flutter_app6/shared/compoments/Compoments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Search extends StatefulWidget {
  Search({Key? key}) : super(key: key);

  @override
  _nameState createState() => _nameState();
}

class _nameState extends State<Search> {
  final formkey3 = GlobalKey<FormState>();
  var TextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).Search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formkey3,
                  child: TextFormField(
                      onChanged: (value) {
                        NewsCubit.get(context).GetSearch(value);
                      },
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Fill The Field';
                        return null;
                      },
                      onFieldSubmitted: (value) {
                        if (formkey3.currentState!.validate()) {
                        } else {}
                      },
                      cursorColor: Colors.orange,
                      keyboardType: TextInputType.text,
                      controller: TextController,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(50.0),
                              borderSide: BorderSide(
                                color: Colors.orange,
                              )),
                          prefix: Icon(
                            Icons.search,
                            color: Colors.orange,
                          ),
                          labelText: 'Search',
                          labelStyle: TextStyle(color: Colors.orangeAccent),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 200),
                              borderRadius: BorderRadius.circular(10)))),
                ),
              ),
              Expanded(child: articleBuilder(list, context,isSearch: false)),
            ],
          ),
        );
      },
    );
  }
}

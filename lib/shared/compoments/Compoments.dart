import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app6/modules/webview/webview.dart';

//1.timing
//2.refactor
//3.quality
//4.clean code

Widget defaultButton({
  required double width,
  required Color background,
  required Function function,
  double radius = 10,
  required String text,
}) =>
    Container(
        height: 40,
        width: width,
        decoration: BoxDecoration(
            color: background, borderRadius: BorderRadius.circular(radius)),
        child: MaterialButton(
            onPressed: function(),
            child: Text(
              text.toUpperCase(),
              style: TextStyle(fontSize: 18, color: Colors.white),
            )));

Widget defaulttextformfield({
  TextInputType? type,
  String? title,
  IconData? icon,
  required Function ontap,
}) =>
    TextFormField(
      onTap: ontap(),
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Type First';
        }
      },
      decoration: InputDecoration(
        labelText: title,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(),
      ),
    );
Widget fab() => FloatingActionButton(
      onPressed: () async {},
      child: Icon(Icons.add),
      backgroundColor: Colors.blue,
    );
Future<String> getName() async {
  return 'Omar Ali';
}

Widget buildTasksItem(Map model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${model['time']}'),
          ),
          SizedBox(
            width: 20,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '${model['date']}',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );

Widget buildArticleItem(article, context) => InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => webview_screen(article['url'],article['title'])));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: Container(
                height: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Text('${article['title']}',
                            maxLines: 4,
                            style: Theme.of(context).textTheme.bodyText1)),
                    Text(
                      '${article['publishedAt']}',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articleBuilder(list, context,{isSearch=true}) {
  if (list.length > 0) {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) => buildArticleItem(list[index], context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: list.length,
    );
  } else {
    return isSearch ? Container() :  Center(
        child: CircularProgressIndicator(
      color: Colors.orange,
    ));
  }
}

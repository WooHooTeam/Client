import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:myapp/Screens/HomeScreen/QT/QTInsertScreen.dart';
import 'package:myapp/Screens/HomeScreen/model/ServerProp.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Properties.dart' as prop;

class QTListScreen extends StatelessWidget {

  Future<List<Content>> items;
  QTListScreen() {
    items=fetchContent();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("게시글 목록")),
        floatingActionButton: OpenContainer(
          transitionDuration: Duration(milliseconds: 300),
          closedBuilder: (BuildContext c, VoidCallback action) => (FloatingActionButton(child: Icon(Icons.add),backgroundColor: Colors.purple)),
          openBuilder: (BuildContext c, VoidCallback action) => QTInertScreen(),
          tappable: true,
        ),
        body: FutureBuilder<List<Content>>(
            future: items,
            builder: (context,snapshot) {
              if (snapshot.hasData) {
                List<Content> posting = snapshot.data ?? [];
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: posting.length,
                    itemBuilder: (context, index) {
                      return new ListTile(
                        leading: Icon(Icons.wysiwyg),
                        title: Text(posting[index].title),
                        subtitle: Text(posting[index].writer),
                        trailing: Icon(Icons.arrow_forward_ios),
                      );
                    }
                );
              }
              else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              else return CircularProgressIndicator();
            }
        )
    );
  }
}

Future<List<Content>> fetchContent() async{
  ServerProp serverProp=ServerProp();
  final response = await http.get(Uri.parse('http://localhost:8078'+'/content/findAll'),headers: {'Authorization':prop.token});
  if(response.statusCode==200){
    return ContentImpl().fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  else{
    throw Exception('Failed to load post');
  }
}

class Content{
  final int contentId;
  final DateTime datetime;
  final String title;
  final String maintext;
  final String writer;

  Content({this.contentId,this.datetime,this.title,this.maintext,this.writer});
}
class ContentImpl{

  List<Content> fromJson(List<dynamic> json){
    List<Content> contentList = [];
    for(int i=0;i<json.length;i++){
      contentList.add(Content(contentId:json[i]['contentId'],datetime:DateTime.parse(json[i]['datetime'].toString().substring(0,10)),title: json[i]['title'],maintext: json[i]['maintext'],writer: json[i]['writer']));
    }
    return contentList;
  }
}
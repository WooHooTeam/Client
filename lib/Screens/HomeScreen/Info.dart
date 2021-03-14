import 'dart:convert';

import 'package:myapp/Screens/HomeScreen/model/ServerProp.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HeaderTile extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Container(
      child: Image.network("https://t1.daumcdn.net/thumb/R720x0/?fname=https://t1.daumcdn.net/brunch/service/user/1YN0/image/ak-gRe29XA2HXzvSBowU7Tl7LFE.png")
          ,);
  }
}

class Info extends StatelessWidget {
  Future<List<Post>> postList;
  @override
  Widget build(BuildContext context) {
    postList = fetchPost();

    return Scaffold(
      appBar:
          AppBar(title: Text('교사 정보'),
            backgroundColor: Color(0xFF6CD8F0),
      ),
      body:
      /*Center(child: FutureBuilder<List<Post>>(
        future: postList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(snapshot.data[0].name);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // 기본적으로 로딩 Spinner를 보여줍니다.
          return CircularProgressIndicator();
        },
      ))*/
      FutureBuilder<List<Post>>(
        future: postList,
        builder: (context,snapshot) {
          if (snapshot.hasData) {
            List<Post> posting = snapshot.data ?? [];
            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: posting.length + 1,
                itemBuilder: (context, index) {
                  if (index == 0) return HeaderTile();
                  return new ListTile(
                    leading: Icon(Icons.person),
                    title: Text(posting[index - 1].name),
                    subtitle: Text(posting[index - 1].birthday),
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
      /*ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: 8
    )*/
    );
  }



}

Future<List<Post>> fetchPost() async{
  ServerProp serverProp=ServerProp();
  final response = await http.get(serverProp.server+'/teacher/all');//http.get('http://localhost:8080/example/all');

  if(response.statusCode==200){
    print(response.body);
    return PostImpl().fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  else{
    throw Exception('Failed to load post');
  }
}

class Post{
  final String name;
  final String birthday;
  final String classname;
  Post({this.name,this.birthday,this.classname});
/*
  factory Post.fromJson(Map<String,dynamic> json){
    return Post(
        name: json['name'],
        birthday: json['birthday']
    );
  }*/

  /*factory Post.fromJson(List<dynamic> json){
    List<Post> peopleList = List<Post>();
    print(json[1]['name']);
    for(int i=0;i<json.length;i++){
      peopleList.add(Post(name:json[i]['name'],birthday: json[i]['birthday']));
    }
    return peopleList[0];
  }*/

}
class PostImpl{
  List<Post> peopleList = List<Post>();

  List<Post> fromJson(List<dynamic> json){
    List<Post> peopleList = List<Post>();
    for(int i=0;i<json.length;i++){
      peopleList.add(Post(name:json[i]['teacherName'],birthday: json[i]['birthday'],classname: json[i]['className']));
    }
    return peopleList;
  }
}



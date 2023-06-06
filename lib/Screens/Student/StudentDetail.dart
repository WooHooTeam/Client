import 'package:flutter/material.dart';
import 'StudentList.dart';
import 'package:myapp/Screens/HomeScreen/model/ServerProp.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Properties.dart' as prop;
import 'dart:convert';

class StudentDetail extends StatelessWidget {
  final StudentInf student;

  const StudentDetail({Key key, this.student}) : super(key: key);

  void _onVerticalDrag(DragUpdateDetails details,
      BuildContext context,) {
    if (details.primaryDelta > 3.0) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Future<List<Diary>> diaries = fetchDiary(student.studentId);
    return Scaffold(
      body: FutureBuilder(
        future: diaries,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                GestureDetector(
                  onVerticalDragUpdate: (details) =>
                      _onVerticalDrag(details, context),
                  child: Hero(
                    tag: student.studentName,
                    child: Image.network(
                      student.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ...List.generate((snapshot.data.length), (index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(avatars.last),
                        radius: 15,
                      ),
                      title: Text(snapshot.data[index].teacherName),
                      subtitle: Text(snapshot.data[index].comments),
                    ),
                  );
                })
              ],
            );
          }
          else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          else
            return CircularProgressIndicator();
        }
      )
    );
  }
}


class Diary {
  final String insertTime;
  final String comments;
  final String studentName;
  final String teacherName;

  Diary({this.insertTime,this.comments, this.studentName, this.teacherName});
}


Future<List<Diary>> fetchDiary(int studentNo) async{
  ServerProp serverProp=ServerProp();
  final response = await http.get(Uri.parse(serverProp.server+'/diary/search/'+studentNo.toString()),headers: {'Authorization':prop.token});
  if(response.statusCode==200){
    return DiaryImpl().fromJson(json.decode(utf8.decode(response.bodyBytes))['data']);
  }
  else if(response.statusCode==401){
    showDialog(builder : (BuildContext context){
      return AlertDialog(
          content:new Text("로그인 시간이 만료되었습니다."),
          actions:<Widget>[
            new TextButton(
                child: new Text("확인"),
                onPressed: (){
                  Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                }
            )
          ]
      );
    });
  }
  else{
    throw Exception('Failed to load post');
  }
}

class DiaryImpl{
  List<Diary> fromJson(List<dynamic> json){
    List<Diary> diaryList = [];
    for(int i=0;i<json.length;i++){
      diaryList.add(Diary(insertTime:json[i]['insertTime'],comments:json[i]['comments'],studentName:json[i]['studentName'],teacherName: json[i]['teacherName']));
    }
    return diaryList;
  }
}
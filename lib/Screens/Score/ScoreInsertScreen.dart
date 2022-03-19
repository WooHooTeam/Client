
import 'package:flutter/material.dart';
import 'package:myapp/Screens/HomeScreen/model/ServerProp.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/Properties.dart' as prop;
import 'dart:convert';

class ScoreInsertScreen extends StatefulWidget{
  @override
  _ScoreInsertScreen createState() => _ScoreInsertScreen();
}

class _ScoreInsertScreen extends State<ScoreInsertScreen>{

  Future<List<StudentInf>> items;
  final scoreEditController = TextEditingController();

  @override
  void initState() {
    items=fetchStudent();
  }

  @override
  void dispose() {
    scoreEditController.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("학생 점수 등록"),
            actions:<Widget>[
              new IconButton(
                  icon: new Icon(Icons.refresh),
                  onPressed: (){
                    setState((){
                      items=fetchStudent();
                    });
                  }
              )
            ]
        ),
        body: FutureBuilder<List<StudentInf>>(
            future: items,
            builder: (context,snapshot) {
              if (snapshot.hasData) {
                List<StudentInf> posting = snapshot.data ?? [];
                return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: posting.length,
                    itemBuilder: (context, index) {
                      return new ListTile(
                        leading: Icon(Icons.wysiwyg),
                        title: Text(posting[index].studentName),
                        subtitle: Text('${posting[index].score}'+' 점'),
                        trailing: Icon(Icons.accessibility),
                        onTap: ()=> {
                          _showAddScoreDialog(context,index,posting)
                        }
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

  _showAddScoreDialog(BuildContext context,int index,List<StudentInf> posting) => showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Add Score"),
        content: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: scoreEditController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'Enter Score',
                      icon: Icon(Icons.note_add)),
                )
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text("등록"),
            onPressed: () {
              setState(() {
                posting[index].score = int.parse(scoreEditController.text);
              });
              scoreEditController.clear();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: new Text("취소"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}


class StudentInf {
  final int studentId;
  final String studentName;
  final String birthday;
  final String className;
  int score;

  StudentInf({this.studentId,this.studentName, this.birthday, this.className,this.score});
}

Future<List<StudentInf>> fetchStudent() async{
  ServerProp serverProp=ServerProp();
  final response = await http.get(Uri.parse(serverProp.server+'/student/all'),headers: {'Authorization':prop.token});
  if(response.statusCode==200){
    return StudentInfImpl().fromJson(json.decode(utf8.decode(response.bodyBytes)));
  }
  else{
    throw Exception('Failed to load post');
  }
}

class StudentInfImpl{

  List<StudentInf> fromJson(List<dynamic> json){
    List<StudentInf> studentList = [];
    for(int i=0;i<json.length;i++){
      studentList.add(StudentInf(studentId:json[i]['studentNo'], studentName:json[i]['studentName'],birthday:json[i]['birthday'],className: json[i]['className'],score: 0));
    }
    return studentList;
  }
}
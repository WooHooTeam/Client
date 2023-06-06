import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/Properties.dart' as prop;
import 'package:myapp/Screens/HomeScreen/QT/QTListScreen.dart';
import '../model/ServerProp.dart';

class QTInertScreen extends StatelessWidget{
  final formKey = GlobalKey<FormState>();
  Map data = {'datetime': DateTime, 'title': String, 'maintext': String};
  QTInsertScreen() {
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
        AppBar(title: Text("게시글 추가"),
          automaticallyImplyLeading: false,
            actions: <Widget>[
              new IconButton(
                icon: new Icon(Icons.save),
                  onPressed: () => {
                  if (formKey.currentState.validate()) {
                    formKey.currentState.save(),
                    insertData().whenComplete((){
                      Navigator.pop(context);
                    })
                        .onError((error, stackTrace) =>
                        showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          content: new Text("문제가 발생했습니다. 다시 시도해 주세요."),
                          actions: <Widget>[
                            new TextButton(
                              child: new Text("확인"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        );
                      },
                    )
                    )}
                  }
              ),
              new IconButton(
                icon: new Icon(Icons.delete),
                onPressed: () => {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                // return object of type Dialog
                    return AlertDialog(
                      content: new Text("게시글 작성을 취소하시겠어요?"),
                      actions: <Widget>[
                        new TextButton(
                          child: new Text("예"),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                        new TextButton(
                          child: new Text("아니오"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                )
                },
              ),
            ]
        ),
      body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Form(
              key: formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return '제목을 입력해주세요.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: '제목'),
                      onSaved: (input) => data['title'] = input,
                    ),
                    TextFormField(
                        decoration: InputDecoration(labelText: '본문'),
                        onSaved: (input) => data['maintext'] = input,
                        maxLines: 15,
                        minLines: 7
                    )
                  ]),
            ),
          )
      ),
    );
  }
  Future<http.Response> insertData() async{
    ServerProp serverProp = ServerProp();
    DateTime _selectedDay = DateTime.now();
    String ss = _selectedDay.toString().substring(0,10);
    _selectedDay = DateTime.parse(ss);
    data['datetime']=_selectedDay;
    final msg = jsonEncode({'datetime':DateFormat('yyyy-MM-dd').format(data['datetime']),'title':data['title'],'maintext':data['maintext']});
    return http.post(Uri.parse(serverProp.contentserver+'/content/insert'),headers:{'content-type':'application/json','Authorization':prop.token},body: msg);
  }
}
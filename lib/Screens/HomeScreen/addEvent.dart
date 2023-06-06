import 'package:myapp/Screens/HomeScreen/model/ServerProp.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
//import 'package:provider/provider.dart';
import 'HomePage.dart';
//import 'navbar.dart';
import 'package:http/http.dart' as http;
import 'calendar.dart';
import 'package:myapp/Properties.dart' as prop;

class addEvent extends StatelessWidget{
  static const String id = 'settings_screen';
  ServerProp serverProp=ServerProp();
  final formKey = GlobalKey<FormState>();

  Map data = {'Date': DateTime, 'title': String, 'description': String};

  addEvent(DateTime date){
    data['Date']=date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomNavigationBar: Navbar(),
      appBar: AppBar(title: Text('Adding Event')),
      body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Form(
              key: formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    /*TextFormField(
                      decoration: InputDecoration(labelText: 'Date'),
                      //onSaved: (input) => data['Date'] = input,
                      //initialValue: data['Date'],
                    ),*/
                    Text(DateFormat('yyyy-MM-dd').format(data['Date'])
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return '제목을 입력해주세요.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'title'),
                      onSaved: (input) => data['title'] = input,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'description'),
                      onSaved: (input) => data['description'] = input,
                        maxLines: 5,
                        minLines: 3
                    ),
                    TextButton(
                      onPressed: () async {if (formKey.currentState.validate()) {

                        formKey.currentState.save();
                        await insertData();
                        Navigator.pop(context, true);
                      }},
                      child: Text('Save Complete!')
                    )
                  ]),
            ),
          )
      ),
    );
  }
  void insertData() async {
    final msg = jsonEncode({'moment':DateFormat('yyyy-MM-dd').format(data['Date']),'title':data['title'],'description':data['description']});
    await http.post(Uri.parse(serverProp.server+'/schedule/insertEvent'),headers:{'content-type':'application/json','Authorization':prop.token},body: msg);
    //http.get(serverProp.local+'/schedule/insertEvent?moment='+DateFormat('yyyy-MM-dd').format(data['Date'])+'&title='+data['title']+'&description='+data['description']);
  }
//적힌 데이터들을 이제 spring 서버를 통해 DB로 Post 방식으로 insert할 것이다.


}
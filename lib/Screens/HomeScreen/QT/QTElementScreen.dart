
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:myapp/Screens/HomeScreen/QT/QTListScreen.dart';
import 'package:myapp/Properties.dart' as prop;
import 'package:http/http.dart' as http;
import '../model/ServerProp.dart';

class QTElementScreen extends StatelessWidget{

  Content currentContent;
  QTElementScreen(Content content){
    currentContent = content;
  }

  @override
  Widget build(BuildContext context) {

    Color color = Theme.of(context).primaryColor;
    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(Colors.purple, Icons.person, 'INFO',context),
          _buildButtonColumn(Colors.purpleAccent, Icons.near_me, 'ROUTE',context),
          _buildButtonColumn(Colors.deepPurple, Icons.delete, 'DELETE',context),
        ],
      ),
    );

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    currentContent.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  currentContent.writer,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          /*3*/
          Icon(
            Icons.star,
            color: Colors.red[500],
          ),
          Text('41'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        currentContent.maintext,
        softWrap: true,
      ),
    );

    return Scaffold(
      appBar: AppBar(title: Text("게시글")),
        body: Column(
          children: <Widget>[
            titleSection,
            buttonSection,
            textSection
          ],
        )
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label,BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(icon:Icon(icon), color: color,onPressed: ()=>_onSearchButtonPressed(label,context),),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
  void _onSearchButtonPressed(String label,BuildContext context) {
    if(label=="DELETE"){
      if(prop.userid==currentContent.username){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              content: new Text("게시글을 삭제하시겠어요?"),
              actions: <Widget>[
                new TextButton(
                  child: new Text("예"),
                  onPressed: () {
                    delete_list(currentContent.contentId).whenComplete(
                            // () => Navigator.popUntil(context, ModalRoute.withName("QTList"))
                        () {
                          Navigator.pop(context);
                          Navigator.pop(context,"refresh");
                        }
                    );
                  }),
                new TextButton(
                  child: new Text("아니오"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
      else{
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              content: new Text("삭제할 권한이 없습니다."),
              actions: <Widget>[
                new TextButton(
                  child: new Text("닫기"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    }
    // else if(label=="INFO"){
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         content: ,
    //       )
    //     }
    //   )
    // }
  }

  Future<Response> delete_list(int contentId) async{
    ServerProp serverProp=ServerProp();
    final msg = jsonEncode({'contentId':contentId});
    return http.post(Uri.parse(serverProp.contentserver+'/content/delete'),headers:{'content-type':'application/json','Authorization': prop.token},body: msg);//.whenComplete(() => null);
  }
}
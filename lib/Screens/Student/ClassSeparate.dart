import 'package:flutter/material.dart';
import 'StudentList.dart';

class ClassSeparate extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //leading: Icon(Icons.menu),
        title: Text('반 선택'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              child: Text('중등부 학생'),
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => StudentList(className:"중등부")));},
            ),
            ElevatedButton(
              child: Text('고등부 학생'),
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => StudentList(className:"고등부")));},
            ),
          ],
        ),
      ),
    );
  }
}
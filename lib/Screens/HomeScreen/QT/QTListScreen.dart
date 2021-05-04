import 'package:flutter/material.dart';

class QTListScreen extends StatelessWidget {

  List<String> items;

  QTListScreen() {
    items = List<String>.generate(20, (index) {
      return "Item - $index";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("큐티 목록")),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            physics:BouncingScrollPhysics(),
            itemCount: items.length ,
            itemBuilder: (context,index){
              String item = items[index];
              return ListTile(
                title: Text(item),
                subtitle: Text("dd"),
          );
        })
    );
  }
  /*List<String> people;
  QTListScreen(){
    people = List<String>.generate(10, (index){
      return "Item-$index";
    });
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: people.length + 1,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(title: Text("Item-$index"),);
      },
    );
  }*/
}
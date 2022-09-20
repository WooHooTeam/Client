import 'package:myapp/Screens/HomeScreen/QT/QTListScreen.dart';
import 'package:myapp/Screens/HomeScreen/calendar.dart';
//import 'package:myapp/Screens/HomeScreen/map.dart';
import 'package:myapp/Screens/HomeScreen/model/aliment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/Screens/HomeScreen/Info.dart';
import 'package:myapp/Screens/Student/StudentList.dart';
import 'package:myapp/Screens/Student/ClassSeparate.dart';

class AlimentWidget extends StatelessWidget {
  final LinearGradient theme;
  final Aliment aliment;
  final VoidCallback increment;
  final VoidCallback decrement;

  AlimentWidget({
    @required this.aliment,
    @required this.theme,
    this.increment,
    this.decrement
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SvgPicture.asset(
          aliment.image,
          width: 70.0,
          height: 70.0,
        ),
        Container(
          child: Column(
            children: <Widget>[
              /*Text(aliment.name,
                  style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Qwigley')),*/
              Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Text("• " + aliment.subtitle + " •",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontFamily: 'cute',
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(/*
              decoration: BoxDecoration(
                  color: theme.colors[0]
              ),
              width: 70,
              height: 1.0,*/
            ),
            Container(
              child: OutlinedButton(
                onPressed: (){
                  if(aliment.name=="Teacher") {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Info()));
                  }
                  else if(aliment.name=="Student"){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ClassSeparate()));//TravelConceptPage()));
                  }
                  else if(aliment.name=="Calendar"){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  }
                  else if(aliment.name=="Map"){
                    /*Navigator.push(context,
                        MaterialPageRoute(builder: (context) => map()));*/
                    print("dddd");
                  }
                  else if(aliment.name=="QT"){
                    print("gggg");
                    Navigator.push(context, MaterialPageRoute(builder: (context) => QTListScreen(),settings: RouteSettings(name:"QTList")));
                  }
                },
                child: SizedBox(
                  width: 56.0,
                  height: 45.0,
                  child: Center(
                      child: Text(/*'${aliment.totalCalories.toInt()}' + "cal"*/"Go!",
                          style: TextStyle(
                              color: theme.colors[0],
                              fontSize: 17.0,
                              fontWeight: FontWeight.w400
                          ),
                          textAlign: TextAlign.center)),
                ),
              ),
            ),
            Container(
              /*decoration: BoxDecoration(
                  color: theme.colors[0]
              ),
              width: 67,
              height: 1.0,*/
            ),
          ],
        ),
        Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/images/running.svg",
                      width: 30.0,
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('${aliment.runTime.toInt()}' + " min"),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/images/bicycle.svg",
                      width: 30.0,
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('${aliment.bikeTime.toInt()}' + " min"),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/images/swim.svg",
                      width: 30.0,
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('${aliment.swimTime.toInt()}' + " min"),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    SvgPicture.asset(
                      "assets/images/workout.svg",
                      width: 30.0,
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text('${aliment.workoutTime.toInt()}' + " min"),
                    ),
                  ],
                ),
              ],
            )
        ),
      ],
    );
  }
}
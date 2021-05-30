import 'package:myapp/Screens/HomeScreen/Info.dart';
import 'package:myapp/Screens/HomeScreen/model/aliment.dart';
import 'package:flutter/material.dart';

class Aliments {
  static List<Aliment> aliments = [
    Aliment(
        name: "Calendar",
        background: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [const Color(0xFFFD8183), const Color(0xFFFB425A)],
        ),
        subtitle: "학생부 일정",
        image: "assets/images/donut.svg",
        bottomImage: "assets/images/bottom_donut.svg",
        totalCalories: 420.0,
        runTime: 47.0,
        bikeTime: 45.0,
        swimTime: 41.0,
        workoutTime: 52.0
    ),
    Aliment(
        name: "Student",
        background: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [const Color(0xFFF8C08E), const Color(0xFFFDA65B)],
        ),
        subtitle: "학생 정보",
        image: "assets/images/burger.svg",
        bottomImage: "assets/images/bottom_burger.svg",
        totalCalories: 560.0,
        runTime: 112.0,
        bikeTime: 69.0,
        swimTime: 61.0,
        workoutTime: 101.0),
    Aliment(
        name: "Teacher",
        background: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [const Color(0xFF6CD8F0), const Color(0xFF6AD89D)],
        ),
        subtitle: "교사 정보",
        image: "assets/images/ice_cream.svg",
        bottomImage: "assets/images/bottom_ice_cream.svg",
        totalCalories: 210.0,
        runTime: 36.0,
        bikeTime: 31.0,
        swimTime: 25.0,
        workoutTime: 41.0),
    Aliment(
        name: "Map",
        background: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [const Color(0xFFEE0979), const Color(0xFFFF6A00)],
        ),
        subtitle: "지도",
        image: "assets/images/pizza.svg",
        bottomImage: "assets/images/bottom_pizza.svg",
        totalCalories: 238.0,
        runTime: 40.0,
        bikeTime: 35.0,
        swimTime: 30.0,
        workoutTime: 50.0),
    Aliment(
        name: "QT",
        background: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [const Color(0xFFFBD3E9), const Color(0xFFBB377D)],
        ),
        subtitle: "게시판",
        image: "assets/images/cake.svg",
        bottomImage: "assets/images/bottom_cake.svg",
        totalCalories: 195.0,
        runTime: 33.0,
        bikeTime: 29.0,
        swimTime: 24.0,
        workoutTime: 39.0),
  ];
}
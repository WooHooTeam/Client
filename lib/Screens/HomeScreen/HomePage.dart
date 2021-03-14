import 'package:flutter/material.dart';
// Example holidays
import 'package:myapp/Screens/HomeScreen/model/aliments.dart';
import 'package:myapp/Screens/HomeScreen/widgets/aliment.dart';
import 'package:myapp/Screens/HomeScreen/widgets/card_item.dart';
import 'package:myapp/Screens/HomeScreen/widgets/page.dart' as b;
import 'package:myapp/Screens/HomeScreen/widgets/pager.dart';
import 'package:flutter/services.dart';

class HomePage extends StatelessWidget {
  HomePage() {
    SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: MenuPager(
          children: Aliments.aliments
              .map(
                (aliment) => b.Page(
              title: "이천교회 학생부",
              background: aliment.background,
              icon: aliment.bottomImage,
              child: CardItem(
                child: AlimentWidget(
                  aliment: aliment,
                  theme: aliment.background,
                ),
              ),
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}
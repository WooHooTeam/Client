import 'package:flutter/material.dart';
import 'package:myapp/Screens/HomeScreen/model/aliments.dart';
import 'package:myapp/Screens/HomeScreen/widgets/aliment.dart';
import 'package:myapp/Screens/HomeScreen/widgets/card_item.dart';
import 'package:myapp/Screens/HomeScreen/widgets/page.dart' as b;
import 'package:myapp/Screens/HomeScreen/widgets/pager.dart';
import 'package:flutter/services.dart';
import 'package:myapp/Properties.dart' as prop;

class HomePage extends StatelessWidget {
  HomePage() {
    SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child : Scaffold(
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
        )
    );
  }
}
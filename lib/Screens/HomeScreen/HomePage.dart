import 'package:myapp/Screens/HomeScreen/calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:myapp/Screens/HomeScreen/HomePage.dart';
import 'package:myapp/Screens/HomeScreen/Info.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter_svg/parser.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/Components/Rounded_Button.dart';
import 'package:myapp/Screens/Welcome/components/Background.dart';
import 'package:myapp/Screens/login/login_screen.dart';
import 'package:myapp/contants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Providing Total screen size
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome ICN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            RoundedButton(
              text: "LOGIN",
              textColor: Colors.black,
              color: Colors.pink,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            RoundedButton(
              text: "SIGN UP",
              color: Colors.cyan,//kPrimaryLightColor,
              textColor: Colors.black,
              press: () {},
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/Components/Rounded_Button.dart';
import 'package:myapp/Components/Rounded_input_field.dart';
import 'package:myapp/Components/already_hava_an_account_check.dart';
import 'package:myapp/Components/rounded_password_field.dart';
import 'package:myapp/Components/text_field_container.dart';
import 'package:myapp/Screens/HomeScreen/HomePage.dart';
import 'package:myapp/Screens/login/components/Background.dart';
import 'package:myapp/contants.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:myapp/auth.dart';
import 'package:myapp/Properties.dart' as prop;
import 'package:jwt_decode/jwt_decode.dart';

class Body extends StatelessWidget {
  String id="";
  String pass="";
  Body({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //final _roundedInputField = RoundedInputField(hintText: "Your Email");
    //final _roundedPasswordField = RoundedPasswordField();
    Size size = MediaQuery.of(context).size;
    return Background(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "LOGIN",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: size.height * 0.03),
        SvgPicture.asset(
          "assets/icons/login.svg",
          height: size.height * 0.35,
        ),
        SizedBox(height: size.height * 0.03),
        RoundedInputField(
          hintText: "Your Email",
          onchanged: (value) {
            id = value;
          },
        ),
        RoundedPasswordField(
          onchanged: (value) {
            pass = value;
          },
        ),
        //_roundedInputField,
        //_roundedPasswordField,
        RoundedButton(
          text: "LOGIN",
          textColor: Colors.black,
          color: Colors.blue,
          press: () {
            Auth auth = new Auth();
            Future<String> result=auth.insertData(id,pass);
            result.then((value) {
              if(value=="Error"){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("서버 에러"),
                      content: new Text("인증을 진행하던 중 에러가 발생했습니다. 다시 시도해주세요."),
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
              else if(value=="UNAUTHORIZED"){
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialog(
                      title: new Text("로그인 에러"),
                      content: new Text("계정 정보를 확인해주세요"),
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
              else{
                print(value);
                Map<String, dynamic> payload = Jwt.parseJwt(value);
                prop.koreanname=payload['korean_name'];
                prop.token=value;
                prop.userid=id;
                showDialog(context: context,
                    builder: (BuildContext context){
                      return AlertDialog(
                        title: new Text("로그인 성공"),
                        content: new Text("환영합니다. "+prop.koreanname + "님!"),
                        actions: <Widget>[
                          new TextButton(onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => HomePage()));
                            }, child: new Text("확인"))
                        ],
                      );
                    });
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => HomePage()));

              }
            });
          },
        ),
        SizedBox(height: size.height * 0.03),
        AlreadyHaveAnAccountCheck(
          press: () {},
        ),
      ],
    ));
  }
}

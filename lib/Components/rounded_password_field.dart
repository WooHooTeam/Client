import 'package:flutter/material.dart';
import 'package:myapp/Components/text_field_container.dart';
import 'package:myapp/contants.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onchanged;
  const RoundedPasswordField({
    Key key,
    this.onchanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        obscureText: true,
        onChanged: onchanged,
        decoration: InputDecoration(
            hintText: "Password",
            icon: Icon(
              Icons.lock,
              color: kPrimaryColor,
            ),
            suffixIcon: Icon(
              Icons.visibility,
              color: kPrimaryColor,
            ),
            border: InputBorder.none),
      ),
    );
  }
}

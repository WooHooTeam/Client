import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:myapp/Properties.dart' as prop;

class Auth {
  Future<String> insertData(String id, String pass) async {
    final msg = {
      'grant_type': prop.grant_type,
      'client_id': prop.client_id,
      'client_secret': prop.client_secret,
      'scope': prop.scope,
      'username': id,
      'password': pass
    };
    print("fff");
    final response = await http.post(
        'http://' +
            prop.client_id +
            ':' +
            prop.client_secret +
            '@' +
            prop.authServer,
        headers: {'content-type': 'application/x-www-form-urlencoded'},
        body: msg);
    if (response.statusCode == 200) {
      // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
      print(json.decode(response.body));
      print(json.decode(response.body)["access_token"]);
      return json.decode(response.body)["access_token"];
    } else {
      // 만약 응답이 OK가 아니면, 에러를 던집니다.
      return "Error";
      throw Exception('Failed to load post');
    }
  }
}

import 'dart:convert';
import 'package:flutter_task/constants/constants.dart';
import 'package:flutter_task/models/login_model.dart';
import 'package:http/http.dart' as http;

class LoginApi {
  static Future<LoginModel?> fetchData(String email, String password) async {
    var url = Uri.parse('${apiPath}login');
    var response = await http.post(
      url,
      body: {'email': email, 'password': password},
    );
    if (response.statusCode == 200) {
      LoginModel data = LoginModel.fromJson(jsonDecode(response.body));
      return data;
    } else {
      return LoginModel(
        message: 'Try again',
      );
    }
  }
}

import 'dart:developer';
import 'package:flutter_task/constants/constants.dart';
import 'package:http/http.dart' as http;
import '../models/get_properties_model.dart';

class GetPropertiesApi {
  static Future<GetPropertiesModel?> getData(String token) async {
    try {
      var url = Uri.parse('${apiPath}get-properties');
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      GetPropertiesModel data = getPropertiesModelFromJson(response.body);
      return data;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

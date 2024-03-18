import 'dart:developer';
import 'package:flutter_task/constants/constants.dart';
import 'package:flutter_task/models/get_inspection_detail.dart';
import 'package:http/http.dart' as http;

class GetInspectionDetailApi {
  static Future<GetInspectionModel?> getData(String token, String id) async {
    try {
      var url = Uri.parse('${apiPath}get-inspection/$id');
      var response = await http.get(url, headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });
      GetInspectionModel data = getInspectionModelFromJson(response.body);
      return data;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

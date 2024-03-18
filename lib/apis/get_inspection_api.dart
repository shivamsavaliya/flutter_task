import 'dart:developer';
import 'package:flutter_task/constants/constants.dart';
import 'package:flutter_task/models/get_inspection_model.dart';
import 'package:http/http.dart' as http;

class GetInspectionApi {
  static Future<GetInspectionListModel?> getData(String token) async {
    try {
      var url = Uri.parse('${apiPath}get-inspections');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      GetInspectionListModel data =
          getInspectionListModelFromJson(response.body);
      return data;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}

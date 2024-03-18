import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import '../constants/constants.dart';
import '../models/add_inspection_model.dart';

class AddInspectionApi {
  static Future<AddInspectionModel?> sendData(
    String token,
    String propertyId,
    String name,
    String note,
    String discription,
    String date,
    File? signature,
    File? oneFile,
    File? twoFile,
    File? threeFile,
    File? fourFile,
    File? fiveFile,
    File? sixFile,
    File? sevenFile,
    File? eightFile,
    File? nineFile,
    File? tenFile,
  ) async {
    try {
      var request = http.MultipartRequest(
        'post',
        Uri.parse("${apiPath}add-inspection"),
      );
      var payload = {
        "property_id": propertyId,
        "name": name,
        "note": note,
        "discription": discription,
        "date": date,
      };

      Map<String, String> headers = {
        "Content-type": "application/json",
        'x-access-token': token,
      };
      if (signature != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'signature',
          signature.readAsBytesSync(),
          filename: signature.path,
          contentType: MediaType("signature", "jpg"),
        ));
      }
      if (oneFile != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image1',
          oneFile.readAsBytesSync(),
          filename: oneFile.path,
          contentType: MediaType("image", "jpg"),
        ));
      }
      if (twoFile != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image2',
          twoFile.readAsBytesSync(),
          filename: twoFile.path,
          contentType: MediaType("image", "jpg"),
        ));
      }
      if (threeFile != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image3',
          threeFile.readAsBytesSync(),
          filename: threeFile.path,
          contentType: MediaType("image", "jpg"),
        ));
      }
      if (fourFile != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image4',
          fourFile.readAsBytesSync(),
          filename: fourFile.path,
          contentType: MediaType("image", "jpg"),
        ));
      }
      if (fiveFile != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image5',
          fiveFile.readAsBytesSync(),
          filename: fiveFile.path,
          contentType: MediaType("image", "jpg"),
        ));
      }
      if (sixFile != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image6',
          sixFile.readAsBytesSync(),
          filename: sixFile.path,
          contentType: MediaType("image", "jpg"),
        ));
      }
      if (sevenFile != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image7',
          sevenFile.readAsBytesSync(),
          filename: sevenFile.path,
          contentType: MediaType("image", "jpg"),
        ));
      }
      if (eightFile != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image8',
          eightFile.readAsBytesSync(),
          filename: eightFile.path,
          contentType: MediaType("image", "jpg"),
        ));
      }
      if (nineFile != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image9',
          nineFile.readAsBytesSync(),
          filename: nineFile.path,
          contentType: MediaType("image", "jpg"),
        ));
      }
      if (tenFile != null) {
        request.files.add(http.MultipartFile.fromBytes(
          'image10',
          tenFile.readAsBytesSync(),
          filename: tenFile.path,
          contentType: MediaType("image", "jpg"),
        ));
      }

      request.fields.addAll(payload);
      request.headers.addAll(headers);

      var res = await request.send();
      var resposeData = await res.stream.toBytes();
      var result = String.fromCharCodes(resposeData);

      AddInspectionModel data = addInspectionModelFromJson(result);
      return data;
    } catch (e) {
      log('Error while making API request in upload: $e');
      return null;
    }
  }
}

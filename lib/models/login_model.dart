import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  final String? success;
  final Data? data;
  final String? message;

  LoginModel({
    this.success,
    this.data,
    this.message,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  final int? id;
  final String? name;
  final dynamic firstname;
  final dynamic lastname;
  final String? password;
  final String? token;

  Data({
    this.id,
    this.name,
    this.firstname,
    this.lastname,
    this.password,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        firstname: json["firstname"],
        lastname: json["lastname"],
        password: json["password"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "firstname": firstname,
        "lastname": lastname,
        "password": password,
        "token": token,
      };
}

LoginErrorModel loginErrorModelFromJson(String str) =>
    LoginErrorModel.fromJson(json.decode(str));

String loginErrorModelToJson(LoginErrorModel data) =>
    json.encode(data.toJson());

class LoginErrorModel {
  final String? error;
  final List<dynamic>? data;
  final String? message;

  LoginErrorModel({
    this.error,
    this.data,
    this.message,
  });

  factory LoginErrorModel.fromJson(Map<String, dynamic> json) =>
      LoginErrorModel(
        error: json["error"],
        data: json["data"] == null
            ? []
            : List<dynamic>.from(json["data"]!.map((x) => x)),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "message": message,
      };
}

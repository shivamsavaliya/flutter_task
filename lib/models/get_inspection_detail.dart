import 'dart:convert';

GetInspectionModel getInspectionModelFromJson(String str) =>
    GetInspectionModel.fromJson(json.decode(str));

String getInspectionModelToJson(GetInspectionModel data) =>
    json.encode(data.toJson());

class GetInspectionModel {
  final bool? success;
  final Data? data;
  final String? message;
  final int? code;

  GetInspectionModel({
    this.success,
    this.data,
    this.message,
    this.code,
  });

  factory GetInspectionModel.fromJson(Map<String, dynamic> json) =>
      GetInspectionModel(
        success: json["success"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
        "message": message,
        "code": code,
      };
}

class Data {
  final int? id;
  final int? uid;
  final int? propertyId;
  final String? name;
  final String? note;
  final String? discription;
  final String? signature;
  final String? image1;
  final String? image2;
  final String? image3;
  final String? image4;
  final String? image5;
  final String? image6;
  final String? image7;
  final String? image8;
  final String? image9;
  final String? image10;
  final DateTime? date;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Data({
    this.id,
    this.uid,
    this.propertyId,
    this.name,
    this.note,
    this.discription,
    this.signature,
    this.image1,
    this.image2,
    this.image3,
    this.image4,
    this.image5,
    this.image6,
    this.image7,
    this.image8,
    this.image9,
    this.image10,
    this.date,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        uid: json["uid"],
        propertyId: json["property_id"],
        name: json["name"],
        note: json["note"],
        discription: json["discription"],
        signature: json["signature"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        image4: json["image4"],
        image5: json["image5"],
        image6: json["image6"],
        image7: json["image7"],
        image8: json["image8"],
        image9: json["image9"],
        image10: json["image10"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "uid": uid,
        "property_id": propertyId,
        "name": name,
        "note": note,
        "discription": discription,
        "signature": signature,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "image4": image4,
        "image5": image5,
        "image6": image6,
        "image7": image7,
        "image8": image8,
        "image9": image9,
        "image10": image10,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

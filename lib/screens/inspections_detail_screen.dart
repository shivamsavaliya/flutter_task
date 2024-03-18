import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_task/apis/get_inspection_detail.dart';
import 'package:flutter_task/constants/constants.dart';

class InspectionsDetailScreen extends StatefulWidget {
  final String id;
  const InspectionsDetailScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<InspectionsDetailScreen> createState() =>
      _InspectionsDetailScreenState();
}

class _InspectionsDetailScreenState extends State<InspectionsDetailScreen> {
  String tokenKey = '';
  String id = '';
  String note = '';
  String date = '';
  String name = '';
  String photo = '';
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokenKey = prefs.getString('token').toString();
      id = prefs.getString('id').toString();
    });
    GetInspectionDetailApi.getData(tokenKey, id).then((value) {
      setState(() {
        note = value!.data!.note.toString();
        date = value.data!.date.toString();
        name = value.data!.name.toString();
        photo = value.data!.image1.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("App Name"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Inspection Note",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              Text(
                note,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const Text(
                "Inspection photo",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Text(
                photo,
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              const Text(
                "Date",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
              Text(
                date,
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const Text(
                "Name",
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              Text(
                name,
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_task/apis/get_inspection_api.dart';
import 'package:flutter_task/constants/constants.dart';
import 'package:flutter_task/models/get_inspection_model.dart';
import 'package:flutter_task/screens/inspections_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveaddInspectionScreen extends StatefulWidget {
  const SaveaddInspectionScreen({super.key});

  @override
  State<SaveaddInspectionScreen> createState() =>
      _SaveaddInspectionScreenState();
}

class _SaveaddInspectionScreenState extends State<SaveaddInspectionScreen> {
  String tokenKey = '';
  List<Datum> allData = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokenKey = prefs.getString('token').toString();
    });

    GetInspectionApi.getData(tokenKey).then((value) {
      setState(() {
        allData = value!.data!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Saved Inspections"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      body: ListView.separated(
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                prefs.setString('id', allData[index].id.toString());
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InspectionsDetailScreen(
                          id: allData[index].id.toString()),
                    ));
              },
              child: Card(
                elevation: 4,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(Icons.person, color: primaryColor),
                          ),
                          Text(allData[index].name.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child: Icon(Icons.location_on, color: primaryColor),
                          ),
                          Text(allData[index].note.toString()),
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 5),
                            child:
                                Icon(Icons.calendar_month, color: primaryColor),
                          ),
                          Text("Start Date: ${allData[index].date.toString()}"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: allData.length),
    );
  }
}

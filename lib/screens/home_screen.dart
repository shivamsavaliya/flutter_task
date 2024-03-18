import 'package:flutter/material.dart';
import 'package:flutter_task/apis/get_properties_api.dart';
import 'package:flutter_task/constants/constants.dart';
import 'package:flutter_task/models/get_properties_model.dart';
import 'package:flutter_task/screens/inspection_data_screen.dart';
import 'package:flutter_task/screens/save_inspection_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    GetPropertiesApi.getData(tokenKey).then((value) {
      setState(() {
        allData = value!.data!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: const Text("App Name"),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SaveaddInspectionScreen(),
                    ));
              },
              child: Ink(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
                child: const Text(
                  "SAVED INSPECTIONS",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InspectionDataScreen(),
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
                              child:
                                  Icon(Icons.location_on, color: primaryColor),
                            ),
                            Text(allData[index].address.toString()),
                          ],
                        ),
                        Row(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(Icons.calendar_month,
                                  color: primaryColor),
                            ),
                            Text("Start Date: ${allData[index].startdate}"),
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
      ),
    );
  }
}

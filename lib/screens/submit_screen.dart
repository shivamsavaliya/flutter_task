import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_task/apis/add_inspection_api.dart';
import 'package:flutter_task/screens/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:signature/signature.dart';
import '../constants/constants.dart';
import '../widgets/custom_button.dart';

class SubmitScreen extends StatefulWidget {
  final String note;
  final List<File> imgList;
  const SubmitScreen({
    Key? key,
    required this.note,
    required this.imgList,
  }) : super(key: key);

  @override
  State<SubmitScreen> createState() => _SubmitScreenState();
}

class _SubmitScreenState extends State<SubmitScreen> {
  String tokenKey = '', pId = '';
  DateTime selectedDate = DateTime.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  Future<void> submitData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tokenKey = prefs.getString('token').toString();
      pId = prefs.getString('pid').toString();
    });
    File imgFile = File(_controller.toString());
    if (nameController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        _controller.isNotEmpty) {
      AddInspectionApi.sendData(
        tokenKey,
        pId,
        nameController.text,
        widget.note,
        'description',
        dateController.text,
        imgFile,
        widget.imgList[0],
        widget.imgList[1],
        widget.imgList[2],
        widget.imgList[3],
        widget.imgList[4],
        widget.imgList[5],
        widget.imgList[6],
        widget.imgList[7],
        widget.imgList[8],
        widget.imgList[9],
      ).then((value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false);
      });
    }
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Date",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: dateController,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      value = dateController.text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter date";
                      }
                      return null;
                    },
                    onTap: () async {
                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2024),
                        lastDate: DateTime(2050),
                      );
                      if (pickedDate != selectedDate) {
                        setState(() {
                          selectedDate = pickedDate!;
                          String formatedDate =
                              DateFormat('dd/MM/yyyy').format(selectedDate);
                          dateController.text = formatedDate;
                        });
                      }
                    },
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(fontSize: 0, height: 2),
                      hintText: "Pick Date",
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Add Name",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextFormField(
                    controller: nameController,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      value = nameController.text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Add Name";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(fontSize: 0, height: 2),
                      hintText: "Add Name",
                      errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.red)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Signature",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: primaryColor,
                      width: 1,
                    ),
                  ),
                  child: Signature(
                    controller: _controller,
                    backgroundColor: Colors.white,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    _controller.clear();
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(double.maxFinite, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                      side: const BorderSide(
                        color: primaryColor,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Clear",
                    style: TextStyle(color: primaryColor),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomButton(
            title: "Submit",
            onPressed: () {
              submitData();
            },
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_task/screens/submit_screen.dart';
import 'package:flutter_task/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/constants.dart';

class InspectionDataScreen extends StatefulWidget {
  const InspectionDataScreen({super.key});

  @override
  State<InspectionDataScreen> createState() => _InspectionDataScreenState();
}

class _InspectionDataScreenState extends State<InspectionDataScreen> {
  TextEditingController noteController = TextEditingController();
  String selectedValue = '';
  List<File> selectedImages = List.filled(10, File(''));

  Future<void> _pickImage(int index) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        selectedImages[index] = File(pickedFile.path);
      });
    }
  }

  void nextScreen() async {
    if (selectedValue.isNotEmpty &&
        selectedImages.isNotEmpty &&
        noteController.text.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubmitScreen(
              note: noteController.text.toString(),
              imgList: selectedImages,
            ),
          ));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Fill all fields")));
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
                    "Inspection Note",
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
                    controller: noteController,
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      value = noteController.text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter note";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      errorStyle: TextStyle(fontSize: 0, height: 2),
                      hintText: "Type Comment",
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
                const SizedBox(height: 25),
                Row(
                  children: [
                    Radio<String>(
                      visualDensity: const VisualDensity(vertical: -2),
                      activeColor: Colors.red,
                      value: 'Quick Inspection',
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                    ),
                    const Expanded(child: Text("Quick Inspection")),
                    Radio<String>(
                      visualDensity: const VisualDensity(vertical: -2),
                      activeColor: Colors.red,
                      value: 'Variation',
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                    ),
                    const Expanded(child: Text("Variation")),
                    Radio<String>(
                      visualDensity: const VisualDensity(vertical: -2),
                      activeColor: Colors.red,
                      value: 'Snag',
                      groupValue: selectedValue,
                      onChanged: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                      },
                    ),
                    const Text("Snag"),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Inspection Photo",
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _pickImage(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: primaryColor),
                        ),
                        child: selectedImages[index].path.isNotEmpty
                            ? Image.file(selectedImages[index])
                            : const Icon(Icons.image),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomButton(
            title: "Sign",
            onPressed: () {
              nextScreen();
            },
          ),
        ),
      ),
    );
  }
}

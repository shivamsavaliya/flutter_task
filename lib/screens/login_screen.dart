import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/apis/login_api.dart';
import 'package:flutter_task/constants/constants.dart';
import 'package:flutter_task/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isVisible = true;
  final _key = GlobalKey<FormState>();

  void loginData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_key.currentState!.validate()) {
      LoginApi.fetchData(emailController.text, passController.text)
          .then((value) {
        if (value!.success == '1') {
          prefs.setString('token', value.data!.token.toString());
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Login successful")));
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false,
          );
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.message.toString())));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 80,
                ),
                SvgPicture.asset('assets/Home.svg'),
                const SizedBox(
                  height: 40,
                ),
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Email",
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
                          controller: emailController,
                          cursorColor: Colors.black,
                          onChanged: (value) {
                            value = emailController.text;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Email";
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            hintText: "Enter Email",
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
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Password",
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
                          controller: passController,
                          obscureText: isVisible,
                          cursorColor: Colors.black,
                          onChanged: (value) {
                            value = passController.text;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: isVisible
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off),
                            ),
                            hintText: "Enter Password",
                            errorBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.red)),
                            border: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            disabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                  title: "Login",
                  onPressed: () {
                    loginData();
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

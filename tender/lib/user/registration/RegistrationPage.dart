import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tender/db/UserAuth.dart';

import '../login/LoginPage.dart';

class RegistrationPage extends StatefulWidget {
  @override
  RegistrationPageState createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool isHiddenPassword = true;
  bool isHiddenConfirmPassword = true;

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  void toggleConfirmPasswordView() {
    setState(() {
      isHiddenConfirmPassword = !isHiddenConfirmPassword;
    });
  }

  static const creationSuccessful = SnackBar(
    content: Text('Account Created! Redirecting.....'),
  );

  // final RoundedLoadingButtonController registerButton =
  //     RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: body(context),
    );
  }

  SingleChildScrollView body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 150,
            height: 150,
            child: Image.asset('assets/logo/2.png' //to display the image
                ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 0),
            child: TextField(
              controller: firstnameController,
              //Text Field for username/email
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.person),
                labelText: 'First Name',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 0),
            child: TextField(
              controller: lastnameController,
              //Text Field for username/email
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.person),
                labelText: 'Last Name',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 0),
            child: TextField(
              controller: usernameController,
              //Text Field for username/email
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                icon: Icon(Icons.person),
                labelText: 'Username',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 40, right: 40, top: 15, bottom: 0),
            child: TextField(
              controller: emailController,
              //Text Field for username/email
              decoration: InputDecoration(
                  focusColor: Colors.black,
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.mail),
                  labelText: 'Email',
                  hintText: 'example@gmail.com'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 15, bottom: 0),
            child: TextField(
              controller: passwordController,
              //Text Field for password
              obscureText: isHiddenPassword, //to hide text (password field)
              decoration: InputDecoration(
                focusColor: Colors.black,
                icon: Icon(Icons.lock),
                border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(244, 4, 4, 255))),
                labelText: 'Password',
                hintText:
                    'Password must have at least 6 alphanumeric characters',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.visibility,
                  ),
                  onPressed: () {
                    togglePasswordView();
                    setState(
                      () {
                        isHiddenPassword;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 15, bottom: 0),
            child: TextField(
              controller: confirmPasswordController,
              //Text Field for password
              obscureText:
                  isHiddenConfirmPassword, //to hide text (password field)
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                labelText: 'Confirm Password',
                hintText:
                    'Password must have at least 6 alphanumeric characters',
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.visibility,
                  ),
                  onPressed: () {
                    toggleConfirmPasswordView();
                    setState(
                      () {
                        isHiddenConfirmPassword;
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 40.0, right: 40.0, top: 20, bottom: 30),
            child: MaterialButton(
              color: Color.fromARGB(255, 244, 4, 4),
              onPressed: () async {
                if (emailController.text.isEmpty ||
                    passwordController.text.isEmpty ||
                    firstnameController.text.isEmpty ||
                    lastnameController.text.isEmpty ||
                    usernameController.text.isEmpty ||
                    confirmPasswordController.text.isEmpty ||
                    emailController.text.isEmpty) {
                  return;
                } else if (passwordController.text.length <= 6) {
                  Timer(
                      Duration(seconds: 2),
                      () => ScaffoldMessenger.of(context)
                          .hideCurrentMaterialBanner());

                  return;
                } else if (passwordController.text !=
                    confirmPasswordController.text) {
                  return;
                } else {
                  User? user = await registerWithEmailPassword(
                      firstnameController.text.trim(),
                      lastnameController.text.trim(),
                      usernameController.text.trim(),
                      emailController.text.trim(),
                      passwordController.text.trim());

                  if (user != null) {
                    Timer(
                        Duration(seconds: 1),
                        () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginPage())));
                    print(user);
                    ScaffoldMessenger.of(context)
                        .showSnackBar(creationSuccessful);
                    // ignore: use_build_context_synchronously
                  } else if (!emailController.text.characters.contains('@')) {
                    return;
                  } else {
                    return;
                  }
                }
              },
              child: Text(
                'Register',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.grey,
      centerTitle: true,
      title: Text(
        'Register',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
    );
  }
}

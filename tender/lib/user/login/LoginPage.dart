import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../db/UserAuth.dart';
import '../registration/RegistrationPage.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  bool isHidden = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //main scaffold
      appBar: appBar(),
      body: body(context),
    );
  }

  AppBar appBar() {
    return AppBar(
      toolbarHeight: 20,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.grey,
    );
  }

  Center body(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 250,
              height: 250,
              child: Image.asset('assets/logo/1.png' //to display the image
                  ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: TextField(
                controller: emailController,
                //Text Field for username/email
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.mail),
                    labelText: 'Email',
                    hintText: 'example@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 40.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                //Text Field for password
                obscureText: isHidden, //to hide text (password field)
                decoration: InputDecoration(
                  icon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
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
                          isHidden;
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
            // TextButton(
            //   onPressed: () {
            //     Navigator.push(context,
            //         MaterialPageRoute(builder: (_) => ForgotPasswordPage()));
            //   },
            //   child: Text(
            //     'Forgot Password?',
            //     style: TextStyle(color: Colors.black, fontSize: 15),
            //   ),
            // ),
            MaterialButton(onPressed: () async {
              if (emailController.text.isEmpty) {
                return;
              } else if (passwordController.text.isEmpty) {
                return;
              } else {
                User? user = await signInWithEmailPassword(
                    emailController.text.toString(),
                    passwordController.text.toString());

                if (user != null) {
                  if (user.email == 'admin@admin.com') {
                    // loginButton.success();
                    // Timer(
                    //   Duration(seconds: 1),
                    //   () => Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (_) => AdminPage(),
                    //     ),
                    //   ),
                    // );
                    // return;

                    print(user);
                    // ignore: use_build_context_synchronously
                    // Timer(
                    //     Duration(seconds: 1),
                    //     () => Navigator.push(context,
                    //         MaterialPageRoute(builder: (_) => HomePage())));
                  } else if (!emailController.text.contains('@')) {
                    // ignore: use_build_context_synchronously
                  } else {
                    // ignore: use_build_context_synchronously

                    print(FirebaseAuth.instance);
                  }
                }
              }
              Text(
                'Login',
                style: TextStyle(color: Colors.white, fontSize: 25),
              );
            }),
            Padding(
              padding: const EdgeInsets.only(
                  left: 40.0, right: 40.0, top: 10, bottom: 0),
              child: MaterialButton(
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => RegistrationPage()));
                },
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

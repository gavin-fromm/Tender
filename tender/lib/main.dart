import 'package:flutter/material.dart';
import 'package:tender/FirebaseConfig.dart';
import 'package:firebase_core/firebase_core.dart';

import 'user/login/LoginPage.dart';
import 'user/registration/RegistrationPage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(242, 255, 255, 255)),
      debugShowCheckedModeBanner: false,
      initialRoute: 'LoginPage',
      routes: {
        'registration_page': (context) => RegistrationPage(),
        'LoginPage': (context) => LoginPage(),
        // 'home_page': (context) => HomePage(),
        // 'forgot_pasword_page': (context) => ForgotPasswordPage(),
        // 'help_page': (context) => HelpPage(),
      },
    );
  }
}

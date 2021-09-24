import 'package:flutter/material.dart';
import 'package:whatsapp_ui_clone/pages/chat_detail_page.dart';
import 'package:whatsapp_ui_clone/pages/chat_page.dart';
import 'package:whatsapp_ui_clone/pages/home_page.dart';
import 'pages/welcome_screen.dart';
import 'pages/login_screen.dart';
import 'pages/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WhatsApp',
        theme: ThemeData(
          primaryColor: Color(0xff075e54),
          accentColor: Color(0xff25d366),
        ),
        initialRoute: WelcomeScreen.id,
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          ChatPage.id: (context) => ChatPage(),
          MyHomePage.id: (context) => MyHomePage(),
        });
  }
}

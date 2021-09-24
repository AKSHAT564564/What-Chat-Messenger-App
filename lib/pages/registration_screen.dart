import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_ui_clone/pages/home_page.dart';
import 'login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String email = '', password = '', userName = ' ';
  bool veri = false;
  Map<String, String> userSignupData = {
    "username": "",
    "email": "",
    "password": ""
  };
  void addUser() {
    FirebaseFirestore.instance.collection("userData").add({
      "userName": userName,
      "email": email,
    });

    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        _auth.signOut();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('SignUp Screen'),
      ),
      body: Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    child: Image.network(
                      'https://cdn.pixabay.com/photo/2017/05/15/13/56/sign-up-2314914_1280.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: 'User Name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'User Name Required';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      userName = value;
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(labelText: 'Password'),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      try {
                        final newUser =
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);

                        addUser();
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

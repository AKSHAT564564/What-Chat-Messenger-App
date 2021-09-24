import 'package:flutter/material.dart';
import 'package:whatsapp_ui_clone/pages/call_page.dart';
import 'package:whatsapp_ui_clone/pages/chat_page.dart';
import 'package:whatsapp_ui_clone/pages/status_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:whatsapp_ui_clone/pages/chat_detail_page.dart';

class MyHomePage extends StatefulWidget {
  static String id = 'home_page';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final _auth = FirebaseAuth.instance;
  String userEmail = "";
  final List<Tab> topTabs = <Tab>[
    Tab(
      icon: Icon(Icons.camera_alt_outlined),
    ),
    Tab(
      text: 'Chats',
    ),
    Tab(
      text: 'status',
    ),
    Tab(
      text: 'Calls',
    )
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _tabController = TabController(vsync: this, length: 4, initialIndex: 1);
  }

  void getCurrentUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        userEmail = user.email!;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () async {
              await _auth.signOut();
              Navigator.popUntil(
                  context, (Route<dynamic> route) => route.isFirst);
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.lightGreenAccent,
          tabs: topTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Text('Camera'),
          ChatPage(),
          StatusPage(),
          CallPage(),
        ],
      ),
      floatingActionButton: _getFab(),
    );
  }

  _getFab() {
    if (_tabController.index == 1) {
      return FloatingActionButton(
          child: Icon(Icons.message), onPressed: () => print('Pressed'));
    } else if (_tabController.index == 2) {
      return FloatingActionButton(
          child: Icon(Icons.camera_alt), onPressed: () => print('Pressed'));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:whatsapp_ui_clone/pages/call_page.dart';
import 'package:whatsapp_ui_clone/pages/chat_page.dart';
import 'package:whatsapp_ui_clone/pages/status_page.dart';
import 'chat_page.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {


  final List<Tab> topTabs = <Tab> [
    Tab(icon: Icon(Icons.camera_alt_outlined),),
    Tab(text: 'Chats',),
    Tab(text: 'status',),
    Tab(text: 'Calls',)
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4,initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
        actions: [
          IconButton(onPressed: (){print('Clicked');}, icon: Icon(Icons.search),),
          IconButton(onPressed: (){print('Clicked');}, icon: Icon(Icons.more_vert ),),
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
    ],),
      floatingActionButton: _getFab(),
    );
  }
  _getFab(){
    if(_tabController.index == 1)
      {
        return FloatingActionButton(
          child: Icon(Icons.message),
            onPressed: ()=>print('Pressed'));
      }
    else if(_tabController.index == 2)
    {
      return FloatingActionButton(
          child: Icon(Icons.camera_alt),
          onPressed: ()=>print('Pressed'));
    }
  }
}
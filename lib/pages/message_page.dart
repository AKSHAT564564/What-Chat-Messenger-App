import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:cloud_firestore/cloud_firestore.dart ';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  // static const styleReciever = BubbleStyle(
  //   margin: BubbleEdges.only(top: 10),
  //   alignment: Alignment.topRight,
  //   nip: BubbleNip.rightTop,
  //   color: Color.fromRGBO(225, 255, 199, 1.0),
  // );

  // static const styleSender = BubbleStyle(
  //   margin: BubbleEdges.only(top: 10),
  //   alignment: Alignment.topLeft,
  //   nip: BubbleNip.leftTop,
  // );

  ScrollController _myScrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _myScrollController.jumpTo(_myScrollController.position.maxScrollExtent);
    });
    return Container(
      child: ListView(controller: _myScrollController, children: [
        // Bubble(
        //   alignment: Alignment.center,
        //   color: Color.fromRGBO(212, 234, 244, 1.0),
        //   child: Text('TODAY', textAlign: TextAlign.center, style: TextStyle(fontSize: 11.0)),
        // ),
        // Bubble(
        //  style: styleReciever,
        //   child: Text('Hello, World!', textAlign: TextAlign.right),
        // ),
        // Bubble(
        //   style: styleSender,
        //   child: Text('Hi, developer!'),
        // ),
      ]),
    );
  }
}

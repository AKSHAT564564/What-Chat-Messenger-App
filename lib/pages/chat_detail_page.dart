import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'message_page.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({Key? key}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              print('Clicked');
            },
            icon: Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {
              print('Clicked');
            },
            icon: Icon(Icons.phone),
          ),
          IconButton(
            onPressed: () {
              print('Clicked');
            },
            icon: Icon(Icons.more_vert),
          ),
        ],
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('images/24516.jpg'),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Text(
                'Akshat',
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: MessagePage()),
          Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    minLines: 1,
                    maxLines: 5,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                        borderSide: BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      hintText: 'Type a Message',
                      suffixIcon: Icon(Icons.mic),
                      prefixIcon: Icon(Icons.emoji_emotions_outlined) ,

                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

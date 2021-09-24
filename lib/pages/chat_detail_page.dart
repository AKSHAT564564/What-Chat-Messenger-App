import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bubble/bubble.dart';
import 'package:random_string/random_string.dart';
import 'package:whatsapp_ui_clone/services/databaseMethods.dart';

class ChatDetailPage extends StatefulWidget {
  final String userName, userEmail, myUserName;
  const ChatDetailPage(
      {Key? key,
      required this.userName,
      required this.userEmail,
      required this.myUserName})
      : super(key: key);
  static String id = 'chat_detail_page';

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  String myUserEmail = "", chatRoomId = "", messageId = "", message = "";
  Stream? messageStream;

  void initState() {
    super.initState();

    doOnLoad();
  }

  doOnLoad() {
    getCurrentUser();
    chatRoomId = getChatRoomIdByUsernames(widget.userName, widget.myUserName);
    getAndSetMessages();
    print("$chatRoomId");
  }

  void getCurrentUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        myUserEmail = user.email!;
      }
    } catch (e) {
      print(e);
    }
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  addMessage(bool sendClicked) {
    if (textController.text != "") {
      String message = textController.text;
      var lastMessageTs = DateTime.now();

      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": widget.myUserName,
        "ts": lastMessageTs,
      };
      //messageId
      if (messageId == "") {
        messageId = randomAlphaNumeric(12);
      }

      DatabaseMethods()
          .addMessage(chatRoomId, messageId, messageInfoMap)
          .then((value) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageTs": lastMessageTs,
          "lastMessageSendBy": widget.myUserName
        };
        DatabaseMethods().updateLastMessageSend(chatRoomId, lastMessageInfoMap);
        if (sendClicked) {
          textController.text = "";
          messageId = "";
        }
      });
    }
  }

  Widget chatMessageTile(String message, bool sendByMe) {
    return Row(
      mainAxisAlignment:
          sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  bottomRight:
                      sendByMe ? Radius.circular(0) : Radius.circular(24),
                  topRight: Radius.circular(24),
                  bottomLeft:
                      sendByMe ? Radius.circular(24) : Radius.circular(0),
                ),
                color: sendByMe ? Colors.blue : Colors.lightGreen,
              ),
              padding: EdgeInsets.all(16),
              child: Text(
                message,
                style: TextStyle(color: Colors.black),
              )),
        ),
      ],
    );
  }

  Widget chatMessages() {
    return StreamBuilder(
      stream: messageStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                padding: EdgeInsets.only(bottom: 70, top: 16),
                itemCount: (snapshot.data! as QuerySnapshot).docs.length,
                reverse: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds =
                      (snapshot.data! as QuerySnapshot).docs[index];
                  return chatMessageTile(
                      ds["message"], widget.myUserName == ds["sendBy"]);
                })
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  getAndSetMessages() async {
    messageStream = FirebaseFirestore.instance
        .collection("chatrooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy("ts", descending: true)
        .snapshots();

    setState(() {});
  }

  final TextEditingController textController = new TextEditingController();

  static const styleReciever = BubbleStyle(
    margin: BubbleEdges.only(top: 10),
    alignment: Alignment.topRight,
    nip: BubbleNip.rightTop,
    color: Color.fromRGBO(225, 255, 199, 1.0),
  );

//  getChatRoomIdByUsernames(String a, String b) {
//     if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
//       return "$b\_$a";
//     } else {
//       return "$a\_$b";
//     }
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () async {},
            icon: Icon(Icons.phone),
          ),
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.popUntil(
                  context, (Route<dynamic> route) => route.isFirst);
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
                widget.userName,
                style: TextStyle(fontSize: 15.0),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            chatMessages(),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.black.withOpacity(0.8),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      controller: textController,
                      onChanged: (value) {
                        addMessage(false);
                      },
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "type a message",
                          hintStyle:
                              TextStyle(color: Colors.white.withOpacity(0.6))),
                    )),
                    GestureDetector(
                      onTap: () {
                        addMessage(true);
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

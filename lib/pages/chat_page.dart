import 'package:flutter/material.dart';
import 'package:whatsapp_ui_clone/services/databaseMethods.dart';
import 'chat_detail_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);
  static String id = 'chat_page';
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final firestoreInstance = FirebaseFirestore.instance;

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('userData').snapshots();
  String userEmail = '', myUserName = "";
  void initState() {
    super.initState();

    getCurrentUser();
    getUserName();
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

  getUserName() async {
    QuerySnapshot<Map<String, dynamic>> query = await FirebaseFirestore.instance
        .collection('userData')
        .where('email', isEqualTo: userEmail)
        .get();

    myUserName = "${query.docs[0]["userName"]}";
  }

  getChatRoomIdByUsernames(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  Widget checkUserName(bool isItMe, String userName, String userEmail) {
    if (isItMe == true) {
      return Container(
        alignment: Alignment.topCenter,
        child: Center(
          child: ListTile(
            title: Text(
              "Logged In user",
              style: TextStyle(color: Colors.blueGrey, fontSize: 24.0),
            ),
            subtitle: Text(
              "$userName",
              style: TextStyle(color: Colors.blueAccent, fontSize: 18.0),
            ),
          ),
        ),
      );
    } else {
      return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blueGrey,
            backgroundImage: AssetImage('images/24516.jpg'),
          ),
          title: Text(
            userName,
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
          subtitle: Text(
            userEmail,
            style: TextStyle(color: Colors.grey, fontSize: 15.0),
          ),
          onTap: () {
            var chatRoomId = getChatRoomIdByUsernames(myUserName, userName);

            Map<String, dynamic> chatRoomInfoMap = {
              "users ": [
                myUserName,
                userName,
              ]
            };

            DatabaseMethods().createChatRoom(chatRoomId, chatRoomInfoMap);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatDetailPage(
                          userName: userName,
                          userEmail: userEmail,
                          myUserName: myUserName,
                        )));
          });
    }
  }

  Widget usersDetail() {
    return StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return checkUserName(ds["userName"] == myUserName,
                      ds["userName"], ds["email"]);
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(
            height: 10.0,
          ),
          Expanded(child: usersDetail()),
        ],
      ),
    );
  }
}

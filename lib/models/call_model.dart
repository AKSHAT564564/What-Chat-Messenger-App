import 'package:flutter/material.dart';

class CallModel {
  late String name;
  late String date;
  late String avatar;
  late Icon callType;
  CallModel(
      {required String n,
      required String d,
      required String a,
      required Icon c}) {
    name = n;
    date = d;
    avatar = a;
    callType = c;
  }
  static Icon callReceived = Icon(
    Icons.call_received,
    size: 18,
    color: Colors.grey,
  );
  static Icon callMissed = Icon(
    Icons.call_missed,
    size: 18,
    color: Colors.grey,
  );
}

List<CallModel> callData = [
  CallModel(
      n: "Akshat", d: "time", a: "images/24516.jpg", c: CallModel.callReceived),
  CallModel(
      n: "Hritik",
      d: "Time kharab",
      a: "images/24526.jpg",
      c: CallModel.callReceived),
  CallModel(
      n: "Hritik",
      d: "Time kharab",
      a: "images/24526.jpg",
      c: CallModel.callMissed),
  CallModel(
      n: "Hritik",
      d: "Time kharab",
      a: "images/24526.jpg",
      c: CallModel.callReceived),
];

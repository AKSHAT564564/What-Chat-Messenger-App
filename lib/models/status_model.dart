class StatusModel {
  late String name;
  late String time;
  late String avatar;

  StatusModel({
    required String n,
    required String d,
    required String a,
  }){
    name=n;
    time =d;
    avatar =a;
  }
}

List<StatusModel> statusData = [
  StatusModel(
    n: "Rahul",
    d: "10:20",
    a: "images/24516.jpg",
  ),
];

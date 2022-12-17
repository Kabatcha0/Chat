class GetChat {
  late String text;
  late String dateTime;
  late String receiveId;
  late String senderId;
  // GetChat({
  //   required this.text,
  //   required this.dateTime,
  //   required this.receiveId,
  // });
  GetChat.fromJson(Map<String, dynamic> json) {
    text = json["text"];
    dateTime = json["dateTime"];
    receiveId = json["receiveId"];
    senderId = json["senderId"];
  }
}

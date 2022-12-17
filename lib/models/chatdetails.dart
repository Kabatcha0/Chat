class ChatDetails {
  late String senderId;
  late String receiveId;
  late String text;
  late String dateTime;
  ChatDetails({
    required this.text,
    required this.senderId,
    required this.receiveId,
    required this.dateTime,
  });
  Map<String, dynamic> toMap() {
    return {
      "text": text,
      "senderId": senderId,
      "receiveId": receiveId,
      "dateTime": dateTime
    };
  }
}

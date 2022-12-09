class ChatMessage {
  String? textmsg;
  String? senderId;
  String? receiverId;
  String? datetime;

  ChatMessage({
    required this.textmsg,
    required this.senderId,
    required this.receiverId,
    required this.datetime,
  });

  ChatMessage.fromjson(Map<String, dynamic>? json) {
    textmsg = json?["textmsg"];
    senderId = json?["senderId"];
    receiverId = json?["receiverId"];
    datetime = json?["datetime"];
  }

  Map<String, dynamic> toMap() {
    return {
      "textmsg": textmsg,
      "senderId": senderId,
      "receiverId": receiverId,
      "datetime": datetime,
    };
  }
}

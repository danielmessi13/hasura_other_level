class Message {
  String user;
  String friend;
  String text;
  String createdAt;

  Message({this.user, this.friend, this.text, this.createdAt});

  Message.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    friend = json['friend'];
    text = json['text'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['friend'] = this.friend;
    data['text'] = this.text;
    data['created_at'] = this.createdAt;
    return data;
  }
}
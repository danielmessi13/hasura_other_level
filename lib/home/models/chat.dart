class ChatModel {
  String user;
  String id;
  String friend;

  ChatModel({this.user, this.id, this.friend});

  ChatModel.fromJson(Map<String, dynamic> json) {
    user = json['user'];
    id = json['id'];
    friend = json['friend'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user'] = this.user;
    data['id'] = this.id;
    data['friend'] = this.friend;
    return data;
  }
}

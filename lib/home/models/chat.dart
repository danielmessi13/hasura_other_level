class Chat {
  String user;
  String id;
  String friend;

  Chat({this.user, this.id, this.friend});

  Chat.fromJson(Map<String, dynamic> json) {
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

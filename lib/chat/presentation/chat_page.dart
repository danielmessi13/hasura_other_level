import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hasura_other_level/chat/store/chat_store.dart';

import '../../home/models/chat.dart';

class ChatPage extends StatelessWidget {
  final ChatModel chat;
  final chatController = Chat();

  ChatPage({
    Key key,
    @required this.chat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sala: " + chat.id),
      ),
      body: Observer(
        builder: (_) => ListView.builder(
          itemBuilder: (_, index) => Container(
            child: Text(chatController.messages[index]),
          ),
          itemCount: chatController.messages.length,
        ),
      ),
    );
  }
}

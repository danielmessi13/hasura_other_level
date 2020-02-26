import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hasura_other_level/core/core_store.dart';
import 'package:hasura_other_level/home/home_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'chat_store.dart';
import 'widgets/card_message.dart';
import 'widgets/text_field_custom.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  final _listController = ScrollController();
  Home _homeController;
  Chat _chatController;
  Core _coreController;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _homeController = Provider.of<Home>(context);
    _coreController = Provider.of<Core>(context);
    _chatController = Chat(
      _homeController.chatModel,
      _coreController.hasuraConnect,
    );

    reaction((_) => _chatController.messages, (_) {
      _listController.jumpTo(_listController.position.maxScrollExtent + 300);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = _coreController.hasuraConnect.headers['x-hasura-user-id'];
    Timer(
      Duration(milliseconds: 100),
      () =>
          _listController.jumpTo(_listController.position.maxScrollExtent + 10),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("Sala: " + _homeController.chatModel.id),
      ),
      body: Observer(
        builder: (_) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    controller: _listController,
                    itemBuilder: (_, index) {
                      if (_chatController.messages.isEmpty &&
                          _chatController.loading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (_chatController.messages[index].user != user) {
                        return CardMessage(
                          sender: _chatController.messages[index].user,
                          message: _chatController.messages[index].text,
                          received: true,
                        );
                      } else {
                        return CardMessage(
                          sender: _chatController.messages[index].user,
                          message: _chatController.messages[index].text,
                          received: false,
                        );
                      }
                    },
                    itemCount: _chatController.messages.length,
                  ),
                ),
                Provider(
                  create: (context) => _chatController,
                  child: TextFieldCustom(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

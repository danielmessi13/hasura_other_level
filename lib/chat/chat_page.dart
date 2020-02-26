import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hasura_other_level/core/core_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../home/home_page.dart';
import '../home/models/chat.dart';
import 'chat_store.dart';
import 'widgets/card_message.dart';
import 'widgets/text_field_custom.dart';

class ChatPage extends StatefulWidget {
  final ChatModel chatModel;

  const ChatPage({Key key, @required this.chatModel}) : super(key: key);
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageController = TextEditingController();
  final _listController = ScrollController(initialScrollOffset: 0);
  Chat _chatController;
  Core _coreController;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    _coreController = Provider.of<Core>(context);
    _chatController = Chat(
      widget.chatModel,
      _coreController.hasuraConnect,
    );

    reaction((_) => _chatController.messages, (_) {
      _listController.jumpTo(0);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = _coreController.hasuraConnect.headers['x-hasura-user-id'];

    return Scaffold(
      appBar: AppBar(
        title: Text("Sala: " + widget.chatModel.id),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          )
        ],
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
                    reverse: true,
                    itemCount: _chatController.messages.length,
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

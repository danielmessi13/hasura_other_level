import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hasura_other_level/chat/chat_page.dart';
import 'package:hasura_other_level/core/core_store.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import 'home_store.dart';
import 'models/chat.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Home homeController;
  final nameController = TextEditingController();
  final chatController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  ReactionDisposer reactionChat;
  ReactionDisposer reactionError;

  @override
  void didChangeDependencies() {
    homeController = Provider.of<Home>(context);

    reactionChat = reaction(
      (_) => homeController.chatModel,
      (ChatModel a) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              chatModel: a,
            ),
          ),
        );
      },
    );

    reactionError = reaction(
      (_) => homeController.message,
      (_) => _scaffoldKey.currentState
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(homeController.message),
          ),
        ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final coreController = Provider.of<Core>(context);

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Hasura Zap"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Observer(builder: (_) {
          if (homeController.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Column(
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Nome",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: chatController,
                decoration: InputDecoration(
                  labelText: "Código do chat",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => homeController.initChat(
          context: context,
          hasuraConnect: coreController.hasuraConnect,
          name: nameController.text,
          chat: chatController.text,
        ),
        tooltip: 'Entrar na conversa',
        child: Icon(Icons.chat),
      ),
    );
  }
}

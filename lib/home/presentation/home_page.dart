import 'package:flutter/material.dart';
import 'package:hasura_other_level/core/core_store.dart';
import 'package:hasura_other_level/home/store/home_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final homeController = Home();
  final nameController = TextEditingController(text: "danielmessi13");
  final chatController = TextEditingController(text: '123');

  @override
  Widget build(BuildContext context) {
    final coreController = Provider.of<Core>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Hasura Zap"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => homeController.initChat(
          hasuraConnect: coreController.hasuraConnect,
          name: nameController.text,
          chat: chatController.text,
        ),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

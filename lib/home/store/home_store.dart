import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:mobx/mobx.dart';

part 'home_store.g.dart';

class Home = _HomeBase with _$Home;

abstract class _HomeBase with Store {
  String getChats = '''subscription {
  user {
    chats {
      user
      id
      friend
    }
  }
}''';

  @action
  initChat({
    @required HasuraConnect hasuraConnect,
    @required String name,
    @required String chat,
  }) async {
    try {
      hasuraConnect.addHeader("x-hasura-user-id", name);
      Snapshot snapshot = hasuraConnect.subscription(getChats);
      snapshot.listen((data) {
        print(data);
      }).onError((err) {
        print(err);
      });
    } catch (e) {
      hasuraConnect.removeHeader("name");
      print(e);
    }
  }
}

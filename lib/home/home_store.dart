import 'package:flutter/material.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:mobx/mobx.dart';

import 'models/chat.dart';

part 'home_store.g.dart';

class Home = _HomeBase with _$Home;

abstract class _HomeBase with Store {
  String _getUser = '''
  query GetUser {
    user {
      name
    }
  }
  ''';

  String _createUser = '''
  mutation CreateUser {
    insert_user(objects: {}) {
      affected_rows
      returning {
        name
      }
    }
  }
  ''';

  String _getChat = """
  query GetChat (\$chat: String!){
    chat(where: {id: {_eq: \$chat}}) {
      friend
      id
      user
    }
  }
  """;

  String _createChat = """
  mutation CreateChat (\$id: String!){
    insert_chat(objects: {id: \$id}) {
      affected_rows
      returning {
        id
        friend
        user
      }
    }
  }
  """;

  String _enterChat = """
  mutation EnterChat (\$id: String!){
    update_chat(where: {id: {_eq: \$id}}) {
      affected_rows
      returning {
        user
        friend
        id
      }
    }
  }

  """;

  @observable
  ChatModel chatModel;

  @observable
  String message;

  @observable
  bool isLoading = false;

  @action
  Future<void> initChat({
    @required BuildContext context,
    @required HasuraConnect hasuraConnect,
    @required String name,
    @required String chat,
  }) async {
    isLoading = true;
    message = null;
    dynamic _chat;
    try {
      await createOrGet(hasuraConnect, name);

      final _response = await hasuraConnect.query(
        _getChat,
        variables: {"chat": chat},
      );

      _chat = _response['data']['chat'];

      if (_chat.isNotEmpty) {
        final _chatModel = ChatModel.fromJson(_chat[0]);

        if (_chatModel.friend == null) {
          if (_chatModel.user != name) {
            final _response = await hasuraConnect.mutation(
              _enterChat,
              variables: {"id": chat},
            );

            _chat = _response['data']['update_chat']['returning'];
          }
        }

        this.chatModel = ChatModel.fromJson(_chat[0]);

        isLoading = false;
      } else {
        final _response = await hasuraConnect.mutation(
          _createChat,
          variables: {"id": chat},
        );

        _chat = _response['data']['insert_chat']['returning'];
        this.chatModel = ChatModel.fromJson(_chat[0]);
        isLoading = false;
      }
    } on HasuraError catch (e) {
      isLoading = false;
      e.message.contains("chat_id_key")
          ? this.message = "Escolha outra sala na qual não esteja sendo usada"
          : null;
    } catch (e) {
      isLoading = false;
    }
  }

  Future<void> createOrGet(HasuraConnect hasuraConnect, String user) async {
    try {
      hasuraConnect.addHeader("x-hasura-user-id", user);
      final _response = await hasuraConnect.query(_getUser);
      List<dynamic> _user = _response['data']['user'];
      _user.isEmpty ? await hasuraConnect.mutation(_createUser) : null;
    } catch (e) {
      hasuraConnect.removeHeader("name");
      throw e;
    }
  }
}

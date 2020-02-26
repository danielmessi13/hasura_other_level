import 'package:hasura_connect/hasura_connect.dart';
import 'package:hasura_other_level/chat/models/message.dart';
import 'package:hasura_other_level/home/models/chat.dart';
import 'package:mobx/mobx.dart';
part 'chat_store.g.dart';

class Chat = _ChatBase with _$Chat;

abstract class _ChatBase with Store {
  final ChatModel _chatModel;
  final HasuraConnect _hasuraConnect;

  _ChatBase(this._chatModel, this._hasuraConnect) {
    getMessages();
  }

  String _getMessagesSubscription = '''
    subscription GetMessages (\$chatId : String!) {
      chat(where: {id: {_eq: \$chatId}}) {
        messages (order_by: {created_at: asc}){
          user
          friend
          text
          created_at
        }
      } 
    }
  ''';

  String _sendMessage = '''
  mutation SendMessage (\$chatId: String!, \$msg: String!, \$friend: String!){
    insert_message(objects: {chat_id: \$chatId, text: \$msg, friend: \$friend}) {
      affected_rows
    }
  }
  ''';

  @observable
  List<Message> messages = [];

  @observable
  bool loading = false;

  @action
  Future<bool> sendMessage(String message) async {
    try {
      await _hasuraConnect.mutation(_sendMessage, variables: {
        "msg": message,
        "chatId": _chatModel.id,
        "friend": _chatModel.friend,
      });
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @action
  void getMessages() {
    loading = true;
    try {
      _hasuraConnect.subscription(
        _getMessagesSubscription,
        variables: {"chatId": _chatModel.id},
        
      ).listen((event) {
        loading = false;
        messages = (event['data']['chat'][0]['messages'] as List)
            .map((i) => Message.fromJson(i))
            .toList();
      });
    } catch (e) {
      print(e);
      loading = false;
    }
  }
}

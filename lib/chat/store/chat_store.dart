import 'package:mobx/mobx.dart';
part 'chat_store.g.dart';

class Chat = _ChatBase with _$Chat;

abstract class _ChatBase with Store {
  @observable
  List<String> messages = [];

  @action
  Future<bool> sendMessage() async {
    return true;
  }
}

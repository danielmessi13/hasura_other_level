// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Chat on _ChatBase, Store {
  final _$messagesAtom = Atom(name: '_ChatBase.messages');

  @override
  List<String> get messages {
    _$messagesAtom.context.enforceReadPolicy(_$messagesAtom);
    _$messagesAtom.reportObserved();
    return super.messages;
  }

  @override
  set messages(List<String> value) {
    _$messagesAtom.context.conditionallyRunInAction(() {
      super.messages = value;
      _$messagesAtom.reportChanged();
    }, _$messagesAtom, name: '${_$messagesAtom.name}_set');
  }

  final _$sendMessageAsyncAction = AsyncAction('sendMessage');

  @override
  Future<bool> sendMessage() {
    return _$sendMessageAsyncAction.run(() => super.sendMessage());
  }

  @override
  String toString() {
    final string = 'messages: ${messages.toString()}';
    return '{$string}';
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Home on _HomeBase, Store {
  final _$chatModelAtom = Atom(name: '_HomeBase.chatModel');

  @override
  ChatModel get chatModel {
    _$chatModelAtom.context.enforceReadPolicy(_$chatModelAtom);
    _$chatModelAtom.reportObserved();
    return super.chatModel;
  }

  @override
  set chatModel(ChatModel value) {
    _$chatModelAtom.context.conditionallyRunInAction(() {
      super.chatModel = value;
      _$chatModelAtom.reportChanged();
    }, _$chatModelAtom, name: '${_$chatModelAtom.name}_set');
  }

  final _$messageAtom = Atom(name: '_HomeBase.message');

  @override
  String get message {
    _$messageAtom.context.enforceReadPolicy(_$messageAtom);
    _$messageAtom.reportObserved();
    return super.message;
  }

  @override
  set message(String value) {
    _$messageAtom.context.conditionallyRunInAction(() {
      super.message = value;
      _$messageAtom.reportChanged();
    }, _$messageAtom, name: '${_$messageAtom.name}_set');
  }

  final _$isLoadingAtom = Atom(name: '_HomeBase.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.context.enforceReadPolicy(_$isLoadingAtom);
    _$isLoadingAtom.reportObserved();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.context.conditionallyRunInAction(() {
      super.isLoading = value;
      _$isLoadingAtom.reportChanged();
    }, _$isLoadingAtom, name: '${_$isLoadingAtom.name}_set');
  }

  final _$initChatAsyncAction = AsyncAction('initChat');

  @override
  Future<void> initChat(
      {@required BuildContext context,
      @required HasuraConnect hasuraConnect,
      @required String name,
      @required String chat}) {
    return _$initChatAsyncAction.run(() => super.initChat(
        context: context,
        hasuraConnect: hasuraConnect,
        name: name,
        chat: chat));
  }

  @override
  String toString() {
    final string =
        'chatModel: ${chatModel.toString()},message: ${message.toString()},isLoading: ${isLoading.toString()}';
    return '{$string}';
  }
}

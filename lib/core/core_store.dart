import 'package:hasura_connect/hasura_connect.dart';
import 'package:mobx/mobx.dart';

part 'core_store.g.dart';

class Core = _CoreBase with _$Core;

abstract class _CoreBase with Store {
  _CoreBase() {
    hasuraConnect = HasuraConnect(
      "https://flutter-other-level.herokuapp.com/v1/graphql",
      headers: {
        'x-hasura-role': 'user',
        'x-hasura-admin-secret': 'adminadmin',
      },
    );
  }

  HasuraConnect hasuraConnect;
}

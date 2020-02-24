import 'package:flutter/material.dart';
import 'package:hasura_other_level/core/core_store.dart';
import 'package:provider/provider.dart';

import 'home/presentation/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => Core(),
      child: MaterialApp(
        title: 'Hasura Zap',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: HomePage(),
      ),
    );
  }
}

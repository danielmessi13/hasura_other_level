import 'package:flutter/material.dart';
import 'package:hasura_other_level/core/core_store.dart';
import 'package:provider/provider.dart';

import 'home/home_page.dart';
import 'home/home_store.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => Core()),
        Provider(create: (context) => Home()),
      ],
      child: MaterialApp(
        title: 'Hasura Zap',
        theme: ThemeData(
          primaryColor:  Color(0xFF6938F1),
          buttonColor:  Color(0xFF6938F1),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor:  Color(0xFF6938F1),
          ),
        ),
        home: HomePage(),
      ),
    );
  }
}

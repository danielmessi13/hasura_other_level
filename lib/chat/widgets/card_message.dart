import 'package:flutter/material.dart';

class CardMessage extends StatelessWidget {
  const CardMessage({
    Key key,
    @required this.message,
    @required this.sender,
    @required this.received,
  }) : super(key: key);

  final String message;
  final String sender;
  final bool received;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: received ? Colors.grey : Theme.of(context).primaryColor,
      margin: received
          ? EdgeInsets.only(right: 40, bottom: 10)
          : EdgeInsets.only(left: 40, bottom: 10),
      child: ListTile(
        title: Text(
          message,
          textAlign: received ? TextAlign.right : TextAlign.left,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width * 0.050,
          ),
        ),
      
      ),
    );
  }
}

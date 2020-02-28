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
    final double radius = 35;

    return Column(
      crossAxisAlignment:
          received ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: <Widget>[
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.6,
          ),
          decoration: BoxDecoration(
            color: received ? Colors.white : Color(0xFF4208C4),
            gradient: !received
                ? LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF4208C4),
                      Color(0xFF6938F1),
                      Color(0xFF7C59F9),
                    ],
                  )
                : null,
            borderRadius: received
                ? BorderRadius.only(
                    bottomRight: Radius.circular(radius),
                    topRight: Radius.circular(radius),
                  )
                : BorderRadius.only(
                    bottomLeft: Radius.circular(radius),
                    topLeft: Radius.circular(radius),
                  ),
          ),
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment:
                  received ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  message,
                  style: TextStyle(
                    color: received ? Colors.black : Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

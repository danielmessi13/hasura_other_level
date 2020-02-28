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
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        !received
            ? Expanded(
                child: Container(),
              )
            : Container(),
        Expanded(
          flex: message.length > 20 ? 3 : 1,
          child: Container(
            decoration: BoxDecoration(
              color:
                  received ? Colors.grey[200] : Theme.of(context).primaryColor,
              gradient: !received
                  ? LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor,
                        Theme.of(context).primaryColor.withOpacity(0.8),
                        Theme.of(context).primaryColor.withOpacity(0.6),
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
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              title: Text(
                sender,
                textAlign: received ? TextAlign.left : TextAlign.right,
                // style: TextStyle(
                //   fontSize: MediaQuery.of(context).size.width * 0.040,
                // ),
              ),
              subtitle: Text(
                message,
                textAlign: received ? TextAlign.left : TextAlign.right,
                // style: TextStyle(
                //   fontSize: MediaQuery.of(context).size.width * 0.050,
                // ),
              ),
            ),
          ),
        ),
        received
            ? Expanded(
                child: Container(),
              )
            : Container(),
      ],
    );
  }
}

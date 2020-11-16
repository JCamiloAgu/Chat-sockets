import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String texto;
  final String uid;
  final AnimationController animationController;

  const ChatMessage(
      {@required this.texto,
      @required this.uid,
      @required this.animationController});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: uid == '123' ? _myMessage() : _theirMessage(),
        ),
      ),
    );
  }

  Widget _myMessage() => Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(
            right: 5,
            bottom: 5,
            left: 50,
          ),
          child: Text(
            texto,
            style: TextStyle(color: Colors.white),
          ),
          decoration: BoxDecoration(
              color: Color(0xff4D9EF6),
              borderRadius: BorderRadiusDirectional.circular(20)),
        ),
      );

  Widget _theirMessage() => Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(
            left: 5,
            bottom: 5,
            right: 50,
          ),
          child: Text(
            texto,
            style: TextStyle(color: Colors.black87),
          ),
          decoration: BoxDecoration(
              color: Color(0xffE4E5E8),
              borderRadius: BorderRadiusDirectional.circular(20)),
        ),
      );
}

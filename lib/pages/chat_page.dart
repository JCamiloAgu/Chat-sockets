import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/chat_message.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();

  final _focusNode = FocusNode();

  bool _estaEscribiendo = false;

  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          children: [
            CircleAvatar(
              child: Text(
                'Te',
                style: TextStyle(fontSize: 12),
              ),
              backgroundColor: Colors.blue[100],
              maxRadius: 14,
            ),
            SizedBox(
              height: 3,
            ),
            Text('Melissa Flores',
                style: TextStyle(color: Colors.black87, fontSize: 12))
          ],
        ),
        centerTitle: true,
        elevation: 1,
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
                child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, i) => _messages[i],
              itemCount: _messages.length,
              reverse: true,
            )),
            Divider(
              height: 1,
            ),
            _chatInput()
          ],
        ),
      ),
    );
  }

  Widget _chatInput() => SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmit,
                  onChanged: (String texto) => setState(
                      () => _estaEscribiendo = texto.trim().length > 0),
                  decoration:
                      InputDecoration.collapsed(hintText: 'Enviar mensaje'),
                  focusNode: _focusNode,
                ),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: Platform.isIOS
                      ? CupertinoButton(
                          child: Text('Enviar'),
                          onPressed: _estaEscribiendo
                              ? () => _handleSubmit(_textController.text)
                              : null,
                        )
                      : Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: IconTheme(
                            data: IconThemeData(color: Colors.blue[400]),
                            child: IconButton(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              icon: Icon(Icons.send),
                              onPressed: _estaEscribiendo
                                  ? () => _handleSubmit(_textController.text)
                                  : null,
                            ),
                          ),
                        ))
            ],
          ),
        ),
      );

  void _handleSubmit(String texto) {
    if (texto.length == 0) return;

    print(texto);
    _textController.clear();
    _focusNode.requestFocus();

    final newChatMessage = ChatMessage(
      uid: '123',
      texto: texto,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 300)),
    );

    _messages.insert(0, newChatMessage);
    newChatMessage.animationController.forward();

    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    for (ChatMessage chatMessage in _messages) {
      chatMessage.animationController.dispose();
    }

    super.dispose();
  }
}

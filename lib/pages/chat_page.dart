import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat/components/chat_bubble.dart';
import 'package:minimal_chat/components/my_text_fields.dart';
import 'package:minimal_chat/services/auth/auth_service.dart';
import 'package:minimal_chat/services/chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiveEmail;
  final String receiverId;

  ChatPage({super.key, required this.receiveEmail, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //chat controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth service
  final AuthService _authService = AuthService();

  final ChatService _chatService = ChatService();

  //for text field focus


  //send message
  void sendMessage() async {
    //if there is somethin inside the text field
    if (_messageController.text.isNotEmpty) {
      //send message
      await ChatService().sendMessage(widget.receiverId, _messageController.text);

      //clear the controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiveEmail),
      ),
      body: Column(
        children: [
          //all message list
          Expanded(
            child: _buildMessageList(),
          ),

          //user message input
          _buildMessageInput()
        ],
      ),
    );
  }

  //build message list
  Widget _buildMessageList() {
    String senderId = AuthService().getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverId, senderId),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("Error");
          }

          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading....");
          }

          //return list view
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    //if current user
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;

    //align right if sender is current user
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child:
            ChatBubble(message: data["message"], isCurrentUser: isCurrentUser));
  }

  //build message input
  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          //text field
          Expanded(
              child: MyTextField(
                  hintText: 'Type here',
                  obsecureFlag: false,
                  controller: _messageController)),
          //send button
          IconButton(
              onPressed: sendMessage,
              icon: const Icon(
                Icons.send,
                size: 40,
                color: Colors.green,
                
              ))
        ],
      ),
    );
  }
}

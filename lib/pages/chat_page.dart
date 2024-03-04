import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chat/components/my_text_fields.dart';
import 'package:minimal_chat/services/auth/auth_service.dart';
import 'package:minimal_chat/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiveEmail;
  final String receiverId;

  ChatPage({super.key, required this.receiveEmail, required this.receiverId});

  //chat controller
  final TextEditingController _messageController = TextEditingController();

  //chat and auth service
  final AuthService _authService = AuthService();
  final ChatService _chatService = ChatService();

  //send message
  void sendMessage() async {
    //if there is somethin inside the text field
    if (_messageController.text.isNotEmpty) {
      //send message
      await ChatService().sendMessage(receiverId, _messageController.text);

      //clear the controller
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(receiveEmail),
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
        stream: _chatService.getMessages(receiverId, senderId),
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
    return Text(data["message"]);
  }

  //build message input
  Widget _buildMessageInput() {
    return Row(
      children: [
        //text field
        Expanded(
            child: MyTextField(
                hintText: 'Type here',
                obsecureFlag: false,
                controller: _messageController)),
        //send button
        IconButton(onPressed: sendMessage, icon: const Icon(Icons.send))
      ],
    );
  }
}

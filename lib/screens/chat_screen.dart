import 'package:chat_app/constans.dart';
import 'package:chat_app/models/message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  ChatScreen({super.key});
  static String id = "ChatScreen";

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();
  ScrollController listController = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessageCollection);

  @override
  Widget build(BuildContext context) {
    String email = ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messageList = [];
            snapshot.data!.docs.forEach((text) {
              messageList.add(Message.fromjason(text));
            });
            return Scaffold(
                appBar: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: kPrimaryColor,
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        kLogo,
                        height: 50,
                      ),
                      Text("Scholer")
                    ],
                  ),
                ),
                body: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          reverse: true,
                          itemCount: messageList.length,
                          itemBuilder: (context, index) {
                            return chatBubble(
                              message: messageList[index],
                            );
                          },
                          controller: listController),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextField(
                        controller: controller,
                        onSubmitted: (value) {
                          messages.add({
                            kMessageText: value,
                            kCreatedAt: DateTime.now(),
                            'id': email
                          });
                          controller.clear();
                          listController.animateTo(0,
                              duration: Duration(microseconds: 500),
                              curve: Curves.easeIn);
                        },
                        decoration: InputDecoration(
                            suffixIcon: Icon(
                              Icons.send,
                              color: kPrimaryColor,
                            ),
                            hintText: "Send Message",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16)),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: kPrimaryColor),
                                borderRadius: BorderRadius.circular(16))),
                      ),
                    )
                  ],
                ));
          } else {
            print(snapshot.error);
            return Text("loading....");
          }
        });
  }
}

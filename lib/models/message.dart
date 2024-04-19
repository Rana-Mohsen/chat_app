import '../constans.dart';

class Message {
  final String? message;

  Message(this.message);

  factory Message.fromjason(text) {
    return Message(text[kMessageText]);
  }
}

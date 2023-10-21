import 'package:cloud_firestore/cloud_firestore.dart';

import '../Consts.dart';

class Message {
  final String message;
  final String email;
  final Timestamp messageDate;
  Message(this.message, this.email, this.messageDate);

  factory Message.fromJson(var jsonData) {
    return Message(
        jsonData[KMessages], jsonData[KEmail], jsonData[KCreatedAt]);
  }
}

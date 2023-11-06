import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Consts.dart';
import '../models/MessagesModel.dart';
import 'Colors.dart';

class ChatBubbleMajor extends StatelessWidget {
  ChatBubbleMajor({super.key, required this.message});
  final Message message;
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollection);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(left: 15, top: 5, right: 120, bottom: 5),
        padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
        decoration: const BoxDecoration(
            color: PrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: TextStyle(
                color: WhiteColor,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              DateFormat('hh:mm a')
                  .format(message.messageDate.toDate())
                  .toString(),
              style: TextStyle(color: WhiteColor, fontSize: 12),
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }
}

class ChatBubbleSubsidiary extends StatelessWidget {
  ChatBubbleSubsidiary({super.key, required this.message});
  final Message message;
  final CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollection);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(left: 120, top: 5, right: 15, bottom: 5),
        padding: EdgeInsets.only(left: 15, top: 15, right: 15, bottom: 5),
        decoration: const BoxDecoration(
            color: Color(0xff006f93),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.message,
              style: TextStyle(
                color: WhiteColor,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              DateFormat('hh:mm a')
                  .format(message.messageDate.toDate())
                  .toString(),
              style: TextStyle(color: WhiteColor, fontSize: 12),
              textAlign: TextAlign.left,
            )
          ],
        ),
      ),
    );
  }
}

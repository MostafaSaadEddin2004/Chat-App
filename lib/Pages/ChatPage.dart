import 'package:chat_app/Components/Colors.dart';
import 'package:chat_app/models/MessagesModel.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Components/ChatBubble.dart';
import '../Consts.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});

  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  void initState() {
    // TODO: implement initState
    bool isBottomShapwUp = false;
    super.initState();
    Stream.periodic(Duration(seconds: 5)).listen((event) {
      isBottomShapwUp = !isBottomShapwUp;
      setState(() {});
    });
  }

  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollection);

  TextEditingController controller = TextEditingController();

  var scrollController = ScrollController();

  String? messageContent;

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(KCreatedAt, descending: false).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> MessagesList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            MessagesList.add(Message.fromJson(snapshot.data!.docs[i]));
          }
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text('Schoolar Chat'),
                backgroundColor: PrimaryColor,
              ),
              body: Column(children: [
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemCount: MessagesList.length,
                    itemBuilder: (context, index) {
                      return MessagesList[index].email == email
                          ? ChatBubbleMajor(
                              message: MessagesList[index],
                            )
                          : ChatBubbleSubsidiary(message: MessagesList[index]);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  decoration: BoxDecoration(color: Colors.transparent),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        KMessages: data,
                        KCreatedAt: Timestamp.now(),
                        KEmail: email
                      });
                      controller.clear();
                      scrollController.animateTo(
                          scrollController.position.maxScrollExtent,
                          duration: Duration(seconds: 1),
                          curve: Curves.easeIn);
                    },
                    onChanged: (data) {
                      messageContent = data;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      suffixIcon: IconButton(
                        onPressed: () {
                          messages.add({
                            KMessages: messageContent,
                            KCreatedAt: Timestamp.now(),
                            KEmail: email
                          });
                          controller.clear();
                          scrollController.animateTo(
                              scrollController.position.maxScrollExtent,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn);
                        },
                        icon: Icon(Icons.send_rounded),
                        color: PrimaryColor,
                      ),
                      hintText: 'Type a message',
                      contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                ),
              ]));
        } else {
          return Scaffold(
              body: Center(
                  child: Text(
            'Refreshing...',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )));
        }
      },
    );
  }
}

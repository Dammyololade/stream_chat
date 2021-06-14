import 'package:flutter/material.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_sample/channel_list_sccreen.dart';
import 'package:stream_chat_sample/home_screen.dart';
import 'package:stream_chat_sample/user.dart';

class ChatApp extends StatefulWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  @override
  void initState() {
    super.initState();
    _initialiseClient();
  }

  late StreamChatClient client;

  Future<void> _initialiseClient() async {
    final apiKey = "536cym64bygn";
    try {
      client = StreamChatClient(apiKey, logLevel: Level.INFO);
      final chatUser = UserProvider.user;
      await client.connectUser(
          User(id: chatUser.id, extraData: {"image": chatUser.image}),
          client.devToken(chatUser.id));
      final channel = client.channel(
        "messaging",
        id: "devengine",
        extraData: {
          "name": "Founder Chat",
          "image": "http://bit.ly/2O35mws",
          "members": ["tbd-1", "tbd-2"],
        },
      );
      await channel.watch();
      // await channel.sendMessage(Message(text: "Just saying hi over"));
    }  catch (e) {
      print("Error initialising client $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamChat(client: client, child: ChannelListScreen());
  }
}

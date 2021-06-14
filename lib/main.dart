import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stream_chat/stream_chat.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_sample/channel_list_sccreen.dart';
import 'package:stream_chat_sample/chat_app.dart';
import 'package:stream_chat_sample/constants.dart';
import 'package:stream_chat_sample/user.dart';

Future main() async {
  runApp(MyApp(ChatUser(
      name: "dammy",
      id: "tbd-2",
      image:
          "https://i.picsum.photos/id/979/200/300.jpg?hmac=VPyKJONiCJZ0uDkMSUYGHAmGqBjjH307k7K8AOmqQSM")));
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  ChatUser user;

  MyApp(this.user);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ChatUser get chatUser => widget.user;

  late StreamChatClient client;

  @override
  void initState() {
    super.initState();
    _initialiseClient();
  }

  Future<void> _initialiseClient() async {
    try {
      client = StreamChatClient(Constants.API_KEY, logLevel: Level.INFO);
      await client.connectUser(
          User(id: chatUser.id, extraData: {"image": chatUser.image}),
          client.devToken(chatUser.id));
      final channel = client.channel(
        "messaging",
        id: "devengine",
        extraData: {
          "name": "Favourite Chat",
          "image": "http://bit.ly/2O35mws",
          "members": ["tbd-1", "tbd-2"],
        },
      );
      await channel.watch();
      final sechannel = client.channel(
        "messaging",
        id: "secchanny",
        extraData: {
          "name": "Honey bank",
          "image":
              "https://i.picsum.photos/id/510/200/200.jpg?hmac=1FeO80NQwx3Om4VsFCOgUaY6aIbQqaEDLKymcdZD1AQ",
          "members": ["tbd-1", "tbd-2"],
        },
      );
      await sechannel.watch();
      final thchannel = client.channel(
        "messaging",
        id: "thereytjo",
        extraData: {
          "name": "Voice training",
          "image":
              "https://i.picsum.photos/id/426/200/200.jpg?hmac=5auPuax0L2lXSIX0eJ2Qxa3HzmGUHCrGDPIEMAWgw7o",
          "members": ["tbd-1", "tbd-2"],
        },
      );
      await thchannel.watch();
    } catch (e) {
      print("Error initialising client $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eagle Chat',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        scaffoldBackgroundColor: Color(0xff16162D),
      ),
      themeMode: ThemeMode.dark,
      builder: (ct, child) => StreamChat(
        client: client,
        child: child!,
        streamChatThemeData: StreamChatThemeData(
          brightness: Brightness.dark,
          colorTheme: ColorTheme.dark(),
        ),
      ),
      home: ChannelListScreen(),
    );
  }
}

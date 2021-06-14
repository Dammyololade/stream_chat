import 'package:flutter/material.dart';
import 'package:stream_chat_sample/user.dart';

import 'main.dart';

Future main() async {
  runApp(MyApp(ChatUser(
      name: "Lekan",
      id: "tbd-1",
      image:
          "https://i.picsum.photos/id/522/200/300.jpg?hmac=6-KFAVAX70eulRbHj_faT1bRFPGrXhPiDHXe6zPaH-4")));
}

import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

import 'chat_app.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  late TextEditingController _controller;
  late ScrollController _scrollController;
  final messageListController = MessageListController();

  @override
  void initState() {
    _controller = TextEditingController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final channel = StreamChannel.of(context).channel;
    return Scaffold(
      appBar: ChannelHeader(

      ),
      body: Column(
        children: [
          Expanded(
            child: MessageListView(
              messageBuilder: (context, message, list) {
                final isMyMessage =
                    message.message.user?.id == StreamChat.of(context).user?.id;
                return MessageWidget(
                  showThreadReplyIndicator: false,
                  showInChannelIndicator: false,
                  showReplyMessage: true,
                  showResendMessage: isMyMessage,
                  showThreadReplyMessage: false,
                  showCopyMessage: true,
                  showDeleteMessage: isMyMessage,
                  showEditMessage: true,
                  message: message.message,
                  reverse: isMyMessage,
                  showUsername: !isMyMessage,
                  padding: const EdgeInsets.all(8.0),
                  showSendingIndicator: true,
                  borderRadiusGeometry: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(2),
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  textPadding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 16.0,
                  ),
                  onMessageTap: (Message mess) {

                  },
                  borderSide: isMyMessage ? BorderSide.none : null,
                  showUserAvatar: isMyMessage ? DisplayWidget.gone : DisplayWidget.show,
                  messageTheme: isMyMessage
                      ? StreamChatTheme.of(context).ownMessageTheme
                      : StreamChatTheme.of(context).otherMessageTheme,
                  onReturnAction: (action) {
                    switch (action) {
                      case ReturnActionType.none:
                        break;
                      case ReturnActionType.reply:
                        FocusScope.of(context).unfocus();
                        break;
                    }
                  },
                );
              },
            ),
          ),
          // Expanded(
          //     child: LazyLoadScrollView(
          //         onEndOfPage: () async {
          //           messageListController.paginateData!();
          //         },
          //         child: MessageListCore(
          //           emptyBuilder: (BuildContext context) {
          //             return Center(
          //               child: Text('Nothing here yet'),
          //             );
          //           },
          //           loadingBuilder: (BuildContext context) {
          //             return Center(
          //               child: SizedBox(
          //                 height: 100.0,
          //                 width: 100.0,
          //                 child: CircularProgressIndicator(),
          //               ),
          //             );
          //           },
          //           messageListBuilder: (ct, List<Message> messages) {
          //             return ListView.builder(
          //                 controller: _scrollController,
          //                 itemCount: messages.length,
          //                 reverse: true,
          //                 itemBuilder: (BuildContext context, int index) {
          //                   final item = messages[index];
          //                   final client = StreamChatCore.of(context).client;
          //                   if (item.user?.id == client.uid) {
          //                     return Align(
          //                       alignment: Alignment.centerRight,
          //                       child: Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: Text("${item.text}"),
          //                       ),
          //                     );
          //                   } else {
          //                     return Align(
          //                       alignment: Alignment.centerLeft,
          //                       child: Padding(
          //                         padding: const EdgeInsets.all(8.0),
          //                         child: Text("${item.text}"),
          //                       ),
          //                     );
          //                   }
          //                 });
          //           },
          //           errorWidgetBuilder: (BuildContext context, error) {
          //             print(error.toString());
          //             return Center(
          //               child: SizedBox(
          //                 height: 100.0,
          //                 width: 100.0,
          //                 child: Text(
          //                     'Oh no, an error occured. Please see logs.'),
          //               ),
          //             );
          //           },
          //         ))),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: MessageInput()
            // Row(
            //   children: [
            //     Expanded(
            //       child: TextField(
            //         controller: _controller,
            //         decoration: const InputDecoration(
            //           hintText: 'Enter your message',
            //         ),
            //       ),
            //     ),
            //     Material(
            //       type: MaterialType.circle,
            //       color: Colors.blue,
            //       clipBehavior: Clip.hardEdge,
            //       child: InkWell(
            //         onTap: () async {
            //           if (_controller.value.text.isNotEmpty) {
            //             await channel.sendMessage(
            //               Message(text: _controller.value.text),
            //             );
            //             _controller.clear();
            //             _updateList();
            //           }
            //         },
            //         child: const Padding(
            //           padding: EdgeInsets.all(8.0),
            //           child: Center(
            //             child: Icon(
            //               Icons.send,
            //               color: Colors.white,
            //             ),
            //           ),
            //         ),
            //       ),
            //     )
            //   ],
            // ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _updateList() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }
}

extension on StreamChatClient {
  /// Fetches the current user id.
  String get uid => state.user!.id;
}

extension on Channel {
  /// Fetches the name of the channel by accessing [extraData] or [cid].
  String get name {
    final _channelName = extraData['name'];
    if (_channelName != null) {
      return _channelName;
    } else {
      return cid!;
    }
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:stream_chat_sample/message_screen.dart';

class ChannelListScreen extends StatelessWidget {
  ChannelListScreen({Key? key}) : super(key: key);
  final channelListController = ChannelListController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff16162D),
      appBar: ChannelListHeader(
        leading: SizedBox(),
      ),
      body: ChannelsBloc(
        child: ChannelListView(
          onChannelTap: (channel, child) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => StreamChannel(
                  channel: channel,
                  child: MessageScreen(),
                ),
              ),
            );
          },
        ),
        // ChannelListCore(
        //     channelListController: channelListController,
        //     // filter: Filter.raw(value: {
        //     //   'type': 'messaging',
        //     //   'members': {
        //     //     r'$in': [
        //     //       StreamChatCore.of(context).user?.id,
        //     //     ]
        //     //   }
        //     // }),
        //     emptyBuilder: (BuildContext context) {
        //       return Center(
        //         child: Text('Looks like you are not in any channels'),
        //       );
        //     },
        //     loadingBuilder: (BuildContext context) {
        //       return Center(
        //         child: SizedBox(
        //           height: 30.0,
        //           width: 30.0,
        //           child: CircularProgressIndicator(),
        //         ),
        //       );
        //     },
        //     errorBuilder: (BuildContext context, dynamic error) {
        //       return Center(
        //         child: Text(
        //             'Oh no, something went wrong. Please check your config. $error'),
        //       );
        //     },
        //     listBuilder: (ct, List<Channel> channels) => LazyLoadScrollView(
        //       onEndOfPage: () async {
        //         channelListController.paginateData!();
        //       },
        //       child: ListView.builder(
        //           itemCount: channels.length,
        //           padding: EdgeInsets.symmetric(vertical: 20),
        //           itemBuilder: (BuildContext context, int index) {
        //             final _item = channels[index];
        //             return ListTile(
        //               leading: CircleAvatar(
        //                 radius: 40,
        //                 backgroundImage: NetworkImage(_item.extraData["image"]),
        //               ),
        //               title: Text(_item.extraData["name"], style: TextStyle(
        //                 color: Colors.white
        //               ),),
        //               subtitle: StreamBuilder<Message>(
        //                 // stream: _item.state!.lastMessageStream,
        //                 initialData: _item.state?.lastMessage ?? Message(),
        //                 builder: (context, snapshot) {
        //                   if (snapshot.hasData) {
        //                     return Text(snapshot.data?.text ?? "No data available",
        //                       style: TextStyle(
        //                         color: Colors.white70
        //                       ),
        //                     );
        //                   }
        //                   return SizedBox();
        //                 },
        //               ),
        //               onTap: (){
        //
        //               },
        //             );
        //           }),
        //     ))
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_next/components/scheduled_tile.dart';
import 'package:whats_next/model/message.dart';
import 'package:whats_next/model/scheduled_manager.dart';

/** Pantalla donde se listan los mensajes aun sin enviar*/
class ScheduledScreen extends StatelessWidget {
  ScheduledScreen({Key? key, required this.manager}) : super (key: key);
  final ScheduledMessagesManager manager;

  @override
  Widget build(BuildContext context) {
    final ScheduledMessages = manager.scheduledMessages;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: ListView.separated(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: 1,
          separatorBuilder: (context, index){
            return Divider(
                height: 1,
                color: Colors.grey,
                thickness: 4.0,
            );
          },
          itemBuilder: (context, index){
            final msg = ScheduledMessages[index];
            return singleScheduledMessageWidget(manager: manager,);
          },
        ),
      ),
    );
  }
}

class singleScheduledMessageWidget extends StatelessWidget{
  const singleScheduledMessageWidget({
    Key? key,
    // required this.message,
    required this.manager
  }) : super(key: key);

  final ScheduledMessagesManager manager;//

  @override
  Widget build(BuildContext context){
    final scheduledMessages = manager.scheduledMessages;
    return ListView.separated(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: scheduledMessages.length,
        separatorBuilder: (context, index) {
          return Divider(
            height: 4,
            thickness: 1.0,
          );
        },
        itemBuilder: (context, index){
          final message = scheduledMessages[index];
          return scheduledTile(
              message: message
          );
        },
      );
  }
}

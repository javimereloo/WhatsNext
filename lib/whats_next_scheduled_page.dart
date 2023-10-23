import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whats_next/model/scheduled_manager.dart';
import 'package:whats_next/screens/empty_scheduled_screen.dart';
import 'package:whats_next/screens/program_message_screen.dart';
import 'package:whats_next/screens/scheduled_messages_screen.dart';

/** Pantalla que se lanza en la pestaña SCHEDULED de la TabBar*/
class ScheduledPage extends StatelessWidget{
  ScheduledPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        DeviceOrientation.values.toList()
    );
    return Scaffold(
      body: buildScheduledScreen(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 10,
        onPressed: () {
          final manager = Provider.of<ScheduledMessagesManager>(context, listen: false,);
          Navigator.push( context,
            MaterialPageRoute(
              builder: (context) {
                return programMessageScreen(
                  onCreate: (msg) {
                    manager.addMessage(msg);
                    Navigator.pop(context);
                  },
                  onUpdate: (msg) {
                    manager.updateMessage(msg, msg.index);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          );
        },
      ),
    );

  }

  Widget buildScheduledScreen(){
    return Consumer<ScheduledMessagesManager>(
        builder: (context, manager, child){
          if (manager.scheduledMessages.isNotEmpty){
            return ScheduledScreen(
              manager: manager
            );
          }else{
            return const EmptyScheduledScreen();
          }
        }
    );
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whats_next/screens/empty_sent_screen.dart';

/** Pantalla que se lanza en la pestaña SENT de la TabBar*/
class SentPage extends StatelessWidget{
  SentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        DeviceOrientation.values.toList()
    );
    return Scaffold(
      body: const EmptySentScreen(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 10,
        onPressed: () {

        },
      ),
    );

  }

}
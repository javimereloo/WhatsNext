import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptySentScreen extends StatelessWidget{
  const EmptySentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'No sent messages yet',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16.0),
            Text(
              'Tap the + button to schedule a new one!',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );

  }


}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyScheduledScreen extends StatelessWidget {
  const EmptyScheduledScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'No scheduled messages yet',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16.0,),
            Text(
                  'Tap the + button to schedule a new one!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:whats_next/whats_next_theme.dart';
import 'whats_next_home_page.dart';
import 'package:whats_next/model/scheduled_manager.dart';


class Whats_Next extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        DeviceOrientation.values.toList()
    );
      return MaterialApp(
        title:  "What's Next",
        theme: WhatsNextTheme.light(),
        darkTheme: WhatsNextTheme.dark(),
        themeMode: ThemeMode.system,
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (context) => ScheduledMessagesManager()
            ),
          ],
          child: const MainPage(title: "What's Next"),
        ),
        debugShowCheckedModeBanner: false, //TODO PARA LA ENTREGA
      );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whats_next/whats_next_scheduled_page.dart';
import 'package:whats_next/whats_next_sent_page.dart';

/** Pantalla principal de la aplicación*/
class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{
  static int numOfPages = 2;
  int _selectedIndex = 0;

  late TabController controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(
        length: numOfPages,
        initialIndex: _selectedIndex,
        vsync: this
    );
    controller.addListener(() {
      setState(() {
        _selectedIndex = controller.index;
      });
    });
  }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  static List<Widget> pages = <Widget>[
    ScheduledPage(),
    SentPage(),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        DeviceOrientation.values.toList()
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title
          ),
          actions: [PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(child: Text('Settings')),
                const PopupMenuItem(child: Text('Help')),
              ];
            },
          ),],
          bottom: TabBar(
            controller: controller,
              tabs: [
                Tab(
                  child: Text('SCHEDULED',),
                ),
                Tab(
                  child: Text('SENT',),
                ),
              ]),
        ),
        body: TabBarView (
          controller: controller,
          children: pages, )
    );
  }
}
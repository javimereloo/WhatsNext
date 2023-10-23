import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:whats_next/model/my_contacts.dart';

class listContactScreen extends StatefulWidget{
  @override
  _listContactScreenState createState() => _listContactScreenState();
}
class _listContactScreenState extends State<listContactScreen> {
  Iterable<Contact> _contacts = Iterable.empty();

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      appBar: AppBar(
        title: (Text('Select a contact')),
        elevation: 0.0,
      ),
      body: _contacts.isNotEmpty ? ListView.builder(
        //Build a list view of all contacts, displaying their avatar and display name
      itemCount: _contacts.length ,
        itemBuilder: (BuildContext context, int index) {
          Contact contact = _contacts.elementAt(index);
          return ListTile(
            onTap: () async {
              if(contact.avatar == null || contact.avatar!.isEmpty ){
                ByteData bytes = await rootBundle.load("assets/user.png") ;
                contact.avatar = bytes.buffer.asUint8List();
              }
              Navigator.pop(context, new myContact(
                  name: '${contact.displayName}',
                  number: '${contact.phones}',
                   imageURL: contact.avatar!  ));
            },
            contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 18),
            leading: (contact.avatar != null && contact.avatar!.isNotEmpty) ?
            CircleAvatar(
              backgroundImage: MemoryImage(contact.avatar!),
            )
                :
            CircleAvatar(
              child: Text(contact.initials(), style: Theme.of(context).textTheme.headline1,),
              backgroundColor: Colors.grey,
            ),
            title: Text(contact.displayName ?? '', ),
          );
        },
      ): Center(
          child: const CircularProgressIndicator(
            color:  Color.fromARGB(255, 90, 224, 192),
          )
      ),
    );
  }

}
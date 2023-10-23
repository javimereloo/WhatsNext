
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:whats_next/model/my_contacts.dart';
import 'package:whats_next/model/message.dart';
import 'package:whats_next/screens/list_contact_screen.dart';

/** Pantalla donde se añaden y editan los mensajes programados */
class programMessageScreen extends StatefulWidget{
  final Function(Message) onCreate;
  final Function(Message) onUpdate;
  final Message? originalMessage;
  final bool isUpdating;

  const programMessageScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalMessage,
  }) : isUpdating = (originalMessage != null),
        super(key: key);

  @override
  _programMessageScreenState createState() =>  _programMessageScreenState();


}

class _programMessageScreenState extends State<programMessageScreen>{
  final _contentController = TextEditingController();
  myContact? _recipient ;
  final Status _status = Status.scheduled;
  Repeat? _repeat = Repeat.noRepeat; //Valor por defecto
    String? _content ;
  final String _attachedFilesPath = '';
  late DateTime? _dispatchMoment = null;
  TimeOfDay? _time = null;



  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        DeviceOrientation.values.toList()
    );
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.check),
          onPressed: (){
            if(_recipient != null && _repeat!= null && _dispatchMoment != null && !_content!.isEmpty) {
              final msg = Message(
                  index: 0,
                  id: widget.originalMessage?.id ?? const Uuid().v1(),
                  recipient: _recipient!,
                  status: _status,
                  repeat: _repeat!,
                  content: _content!,
                  attachedFilesPath: _attachedFilesPath,
                  dispatchMoment: _dispatchMoment!
              );

              if (widget.isUpdating) {
                widget.onUpdate(msg);
              } else {
                widget.onCreate(msg);
              }
            }else{
              showAlert();
            }
          }
      ),
      appBar: AppBar(
        elevation: 0.0,
        title:  Text(
          widget.isUpdating ?  'Edit Message' : 'New Message',
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20,),
            buildSelectContact(),
            const SizedBox(height: 40,),
            buildDispatchMomentPicker(),
            const SizedBox(height: 40,),
            buildRepeat(),
            const SizedBox(height: 50,),
            buildContentField(),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _contentController.addListener(() {
      setState(() {
        _content = _contentController.text;
      });
    });
  }

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  Widget buildSelectContact(){
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(width: 15,),
          Icon(
            Icons.account_box_outlined,
            size: 50,
          ),
          const SizedBox(width: 20,),
          _recipient == null ? Expanded(child: ElevatedButton.icon(
            label: Text('SELECT A CONTACT' ),
            icon: Icon(Icons.arrow_drop_down),
            onPressed: () async {
              final PermissionStatus permissionStatus = await _getPermission();
              if (permissionStatus == PermissionStatus.granted) {
                _recipient = await Navigator.push(context, MaterialPageRoute(
                    builder: (context) => listContactScreen()
                )
                );
              }
              this.setState(() {});
            },
          )
          ) :  Expanded(child: ElevatedButton.icon(
            label: Text(_recipient!.name),
            icon: Icon(Icons.arrow_drop_down),
            onPressed: () async {
              final PermissionStatus permissionStatus = await _getPermission();
              if (permissionStatus == PermissionStatus.granted) {
                _recipient = await Navigator.push(context, MaterialPageRoute(
                    builder: (context) => listContactScreen()
                )
                );
              }
              this.setState(() {});
            },
          ))
        ]
    );

  }
  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted && permission != PermissionStatus.denied) {
      final Map<Permission, PermissionStatus> permissionStatus =
      await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.undetermined;
    } else {
      return permission;
    }
  }

  Widget buildDispatchMomentPicker(){
    return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 6),
          Icon(Icons.watch_later, size: 30.0,),
          const SizedBox(width: 25),
          Expanded(
              child:ElevatedButton(
                onPressed: _selectDate,
                child:
                _dispatchMoment == null ?
                Text('SELECT DATE') :
                // Text('${_dispatchMoment!.day}' + '/' + '${_dispatchMoment!.month}' + '/' + '${_dispatchMoment!.year}' ),
                Text(DateFormat('EEEE, d MMM, yyyy').format(_dispatchMoment!)),
              )
          ),
          const SizedBox(width: 20,),
          ElevatedButton(
            onPressed: _selectTime,
            child:
            _time == null ?
            Text('SELECT TIME') :
            Text('${_dispatchMoment!.hour}' + ':' + '${_dispatchMoment!.minute}' ),
          ),
        ]
    );
  }
  void _selectTime() async {
    _time = await showTimePicker(
      context: context,
      initialTime: _time == null ? TimeOfDay(hour: 10, minute: 00) : _time!,
    );
    setState(() {
      final now = new DateTime.now();
      _dispatchMoment = DateTime(now.year, now.month, now.day, _time!.hour, _time!.minute);
    }
    );
  }
  void _selectDate() async{
    _dispatchMoment = await showDatePicker(
      context: context,
      initialDate:  DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2028, 7),
      helpText: 'Select a date',
    );
    setState(() {
      if (_time == null){
        _time = TimeOfDay.now();
      }
      _dispatchMoment = DateTime(_dispatchMoment!.year, _dispatchMoment!.month, _dispatchMoment!.day, _time!.hour, _time!.minute);
      debugPrint("HORA ACTUAL ${_time!.hour} MINUTO ACTUAL ${_time!.minute}"  );
    }
    );
  }
  Widget buildRepeat(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:  [
        const SizedBox(width: 6),
        Icon(Icons.repeat, size: 30.0,),
        const SizedBox(width: 25),
        Expanded(

            child: DropdownButton<Repeat>(
              isExpanded: true,
              value: _repeat,
              items: [
                DropdownMenuItem(child: Text("No Repeat"),  value: Repeat.noRepeat),
                DropdownMenuItem(child: Text("Every Day"),  value: Repeat.everyDay),
                DropdownMenuItem(child: Text("Every Week"), value: Repeat.everyWeek),
                DropdownMenuItem(child: Text("Every Month"),value: Repeat.everyMonth),
                DropdownMenuItem(child: Text("Every Year"), value: Repeat.everyYear),
              ],
              onChanged: (Repeat? newValue){
                _repeat = newValue!;
                setState(() {});
              },
            )
        )
      ],
    );
  }

  Widget buildContentField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text(
          'Message content',
          style: Theme.of(context).textTheme.headline5,
          textAlign: TextAlign.left,
        ),
        TextField(
          selectionHeightStyle: BoxHeightStyle.max,
          selectionWidthStyle: BoxWidthStyle.max,
          controller: _contentController,
          decoration: const InputDecoration(
            hintText: 'Write your message here ',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 5.0) //
            ),
            border: UnderlineInputBorder(
              borderSide:  BorderSide(color: Colors.black),
            ),
          ),
        )
      ],
    );
  }

  Future<void>  showAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Fill the required information '),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Some of the data required to send the message could not be found.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('accept '),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


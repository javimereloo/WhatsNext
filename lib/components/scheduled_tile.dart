import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whats_next/model/message.dart';

/**Construye una Tile de un mensaje*/
class scheduledTile extends StatelessWidget{
  final Message message;

  scheduledTile({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Row(
      children: [
        const SizedBox(width: 10,),
        CircleAvatar(
          radius: 25,
          backgroundImage: MemoryImage(message.recipient.imageURL),
        ),
        Expanded(
          child: ListTile(
            title: Text('${message.recipient.name}',
                style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Row(children: [
              Icon(
                Icons.access_time,
                size: 15,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 6.0),
                  child: Text(
                    '${message.content}',
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
                  ),
                ),
              ),
            ]),
            trailing: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    '${message.dispatchMoment.hour}' + ':' + '${message.dispatchMoment.minute}' ,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );

  }
}
import 'package:whats_next/model/my_contacts.dart';

enum Status {
  scheduled,
  sent,
  received,
  read
}
enum Repeat{
  noRepeat,
  everyDay,
  everyWeek,
  everyMonth,
  everyYear,
}

class Message{
  int index;
  String id;
  myContact recipient;
  Status status;
  Repeat repeat;
  String content;
  String attachedFilesPath;
  DateTime dispatchMoment;


  Message({
    required this.index,
    required this.id,
    required this.recipient,
    required this.status,
    required this.repeat,
    required this.content,
    required this.attachedFilesPath,
    required this.dispatchMoment,
  });

  Message copyWith({
    int? index,
    String? id,
    myContact? recipient,
    Status? status,
    Repeat? repeat,
    String? content,
    String? attachedFilesPath,
    DateTime? dispatchMoment,
  }){
    return Message(
        index: index ?? this.index,
        id: id ?? this.id,
        recipient: recipient ?? this.recipient,
        status: status ?? this.status,
        repeat: repeat ?? this.repeat,
        content: content ?? this.content,
        attachedFilesPath: attachedFilesPath ?? this.attachedFilesPath,
        dispatchMoment: dispatchMoment ?? this.dispatchMoment
    );
  }



}

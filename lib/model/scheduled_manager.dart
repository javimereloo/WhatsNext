import 'package:flutter/cupertino.dart';
import 'package:whats_next/model/message.dart';

/** Recoge los mensajes programados aun sin enviar, permite su borrado, adición, actualización y envío*/
class ScheduledMessagesManager extends ChangeNotifier{
  static int numMessages = 0;
  final _scheduledMessages = <Message>[];
  List<Message> get scheduledMessages => List.unmodifiable(_scheduledMessages);

  void deleteMessage(int index) {
    _scheduledMessages.removeAt(index);
    notifyListeners();
  }
  void addMessage(Message msg) {
    msg.index = numMessages;
    numMessages += 1;
    _scheduledMessages.add(msg);
    notifyListeners();
  }
  void updateMessage(Message msg, int index) {
    _scheduledMessages[index] = msg;
    notifyListeners();
  }
  void sendMessage(int index, Status newStatus) {
    final message = _scheduledMessages[index];
    _scheduledMessages[index] = message.copyWith(status: newStatus);
    notifyListeners();
  }

}
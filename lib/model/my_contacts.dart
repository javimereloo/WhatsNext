import 'dart:typed_data';

class myContact{
  String name;
  String number;
  Uint8List imageURL;

myContact({
  required this.name,
  required this.number,
  required this.imageURL ,
});

factory myContact.fromJson(Map<String,dynamic> json){
  return myContact(
      name: json['name'] as String,
      number: json['number'] as String,
      imageURL: json['imageURL'] as Uint8List
  );
}
}
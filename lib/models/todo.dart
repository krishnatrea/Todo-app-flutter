import 'dart:convert';
class Tododata {
  String id;
  String title;
  String description;
  String catagory;
  int done;
  DateTime createdAt;
  int deleted;
  Tododata({
    required this.id,
    required this.title,
    required this.description,
    required this.catagory,
    required this.done,
    required this.deleted,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'catagory': catagory,
      'done': done,
      'deleted': deleted,
      'createdAt' : createdAt.toIso8601String()
    };
  }

  factory Tododata.fromMap(Map<String, dynamic> map) {
    return Tododata(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      catagory: map['catagory'],
      done: map['done'],
      deleted: map['deleted'],
      createdAt: DateTime.parse(map['createdAt'])
    );
  }

  String toJson() => json.encode(toMap());

  factory Tododata.fromJson(String source) => Tododata.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Tododata(id: $id, title: $title, description: $description, catagory: $catagory, done: $done, deleted: $deleted)';
  }
}

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Task {
  String? objectId;
  String title;
  String description;
  bool isCompleted;

  // Constructor
  Task({
    this.objectId,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  // ParseObject to Task model
  Task.fromParse(ParseObject parseObject)
      : objectId = parseObject.objectId,
        title = parseObject.get<String>('title') ?? '',
        description = parseObject.get<String>('description') ?? '',
        isCompleted = parseObject.get<bool>('isCompleted') ?? false;

  // Convert Task model to ParseObject for saving to Back4App
  ParseObject toParse() {
    final parseObject = ParseObject('Task')
      ..set<String>('title', title)
      ..set<String>('description', description)
      ..set<bool>('isCompleted', isCompleted);

    if (objectId != null) {
      parseObject.objectId = objectId;
    }

    return parseObject;
  }
}

import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'task_model.dart';
import 'constants/api_constants.dart';
import 'constants/event_constants.dart';
import 'constants/event_messages.dart';

class TaskService {
  // Get all tasks from the server
  Future<List<Task>> getAllTasks() async {
    final query = QueryBuilder(ParseObject(ApiConstants.tasks));
    final response = await query.query();

    if (response.success && response.results != null) {
      List<Task> tasks = response.results!.map((item) => Task.fromParse(item)).toList();
      return tasks;
    } else {
      throw Exception(EventMessages.requestUnsuccessfulMessage);
    }
  }

  // Create a new task
  Future<Task> createTask(Task task) async {
    final parseObject = task.toParse();
    final response = await parseObject.save();

    if (response.success) {
      return Task.fromParse(response.result);
    } else {
      throw Exception(EventMessages.requestUnsuccessfulMessage);
    }
  }

  // Update an existing task
  Future<Task> updateTask(Task task) async {
    final parseObject = task.toParse();
    final response = await parseObject.save();

    if (response.success) {
      return Task.fromParse(response.result);
    } else {
      throw Exception(EventMessages.requestUnsuccessfulMessage);
    }
  }

  // Delete a task
  Future<void> deleteTask(String objectId) async {
    final parseObject = ParseObject(ApiConstants.task)..objectId = objectId;
    final response = await parseObject.delete();

    if (!response.success) {
      throw Exception(EventMessages.requestUnsuccessfulMessage);
    }
  }
}

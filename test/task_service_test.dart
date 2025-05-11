import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:your_app/services/task_service.dart';  // Replace with your actual task service file

class MockTaskService extends Mock implements TaskService {}

void main() {
  group('TaskService Tests', () {
    test('Create task successfully', () async {
      final taskService = MockTaskService();

      // Set up mock behavior for creating a task
      when(taskService.createTask('Task 1', 'Task description'))
          .thenAnswer((_) async => true);  // Mock successful creation

      final result = await taskService.createTask('Task 1', 'Task description');
      expect(result, true);  // Assert the result is true (task created successfully)
    });

    test('Fetch tasks successfully', () async {
      final taskService = MockTaskService();

      // Set up mock behavior for fetching tasks
      when(taskService.fetchTasks()).thenAnswer((_) async => [
        Task(title: 'Task 1', description: 'Description', isCompleted: false),
      ]);

      final tasks = await taskService.fetchTasks();
      expect(tasks, isNotEmpty);  // Assert that tasks are returned
      expect(tasks[0].title, 'Task 1');
    });
  });
}

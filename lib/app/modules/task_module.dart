import 'package:flutter/material.dart';
import '../services/task_service.dart';
import '../models/task_model.dart';

class TaskModule extends StatefulWidget {
  @override
  _TaskModuleState createState() => _TaskModuleState();
}

class _TaskModuleState extends State<TaskModule> {
  late TaskService _taskService;
  late Future<List<Task>> _taskList;

  @override
  void initState() {
    super.initState();
    _taskService = TaskService();
    _taskList = _taskService.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: _taskList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No tasks available.'));
        } else {
          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: Icon(task.isCompleted ? Icons.check_circle : Icons.circle),
                onTap: () {
                  // Handle task click (e.g., update task or show details)
                },
              );
            },
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ParseObject> tasks = [];

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    QueryBuilder<ParseObject> query = QueryBuilder<ParseObject>(ParseObject('Task'));
    final response = await query.query();

    if (response.success && response.results != null) {
      setState(() {
        tasks = response.results!;
      });
    }
  }

  Future<void> addTask(String title, String description) async {
    final task = ParseObject('Task')
      ..set('title', title)
      ..set('description', description)
      ..set('isCompleted', false);
    await task.save();
    fetchTasks();
  }

  Future<void> updateTask(ParseObject task, String title, String description) async {
    task
      ..set('title', title)
      ..set('description', description);
    await task.save();
    fetchTasks();
  }

  Future<void> toggleCompletion(ParseObject task) async {
    final current = task.get<bool>('isCompleted') ?? false;
    task.set('isCompleted', !current);
    await task.save();
    fetchTasks();
  }

  Future<void> deleteTask(ParseObject task) async {
    await task.delete();
    fetchTasks();
  }

  void showTaskDialog({ParseObject? task}) {
    final titleController = TextEditingController(text: task?.get<String>('title') ?? '');
    final descriptionController = TextEditingController(text: task?.get<String>('description') ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(task == null ? 'Add Task' : 'Edit Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: titleController, decoration: InputDecoration(labelText: 'Title')),
            TextField(controller: descriptionController, decoration: InputDecoration(labelText: 'Description')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel')),
          ElevatedButton(
            onPressed: () async {
              if (task == null) {
                await addTask(titleController.text, descriptionController.text);
              } else {
                await updateTask(task, titleController.text, descriptionController.text);
              }
              Navigator.pop(context);
            },
            child: Text(task == null ? 'Add' : 'Update'),
          )
        ],
      ),
    );
  }

  void logoutUser() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user != null) {
      await user.logout();
    }
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logoutUser,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: fetchTasks,
        child: tasks.isEmpty
            ? Center(child: Text("No tasks yet."))
            : ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  final isCompleted = task.get<bool>('isCompleted') ?? false;
                  return ListTile(
                    title: Text(
                      task.get<String>('title') ?? '',
                      style: TextStyle(
                          decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none),
                    ),
                    subtitle: Text(task.get<String>('description') ?? ''),
                    leading: Checkbox(
                      value: isCompleted,
                      onChanged: (_) => toggleCompletion(task),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => showTaskDialog(task: task),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteTask(task),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showTaskDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}

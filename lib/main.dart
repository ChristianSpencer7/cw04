import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // Controller to capture the input text
  TextEditingController _taskController = TextEditingController();

  // List to hold tasks with their completion status
  List<Map<String, dynamic>> tasksList = [];

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  void _handleAddTask() {
    String task = _taskController.text;
    if (task.isNotEmpty) {
      setState(() {
        tasksList.add({"task": task, "isCompleted": false}); // Add task with completion status
      });
      _taskController.clear();
    }
  }

  void _handleRemoveTask(int index) {
    setState(() {
      tasksList.removeAt(index); // Remove the task from the list
    });
  }

  void _toggleTaskCompletion(int index, bool? value) {
    setState(() {
      tasksList[index]["isCompleted"] = value ?? false; // Update the task completion status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task List'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'Enter your task',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _handleAddTask,
              child: Text('Add Task'),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: tasksList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: tasksList[index]["isCompleted"],
                      onChanged: (bool? value) {
                        _toggleTaskCompletion(index, value); // Toggle completion status
                      },
                    ),
                    title: Text(
                      tasksList[index]["task"],
                      style: TextStyle(
                        decoration: tasksList[index]["isCompleted"]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none, // Strike-through if completed
                      ),
                    ),
                    trailing: tasksList[index]["isCompleted"]
                        ? null // Hide remove button if task is completed
                        : TextButton(
                            child: Text('Remove Task'),
                            onPressed: () => _handleRemoveTask(index), // Remove task
                          ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
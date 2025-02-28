import 'package:flutter/material.dart';

// Task model to represent each task
class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
   // List to store tasks
  List<Task> tasks = [];

  // Method to add a new task
  void addTask(String taskName) {
    setState(() {
      tasks.add(Task(name: taskName));
    });
  }

  // Method to mark a task as completed
  void completeTask(int index) {
    setState(() {
      tasks[index].isCompleted = !tasks[index].isCompleted;
    });
  }

   // Method to remove a task
  void removeTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  // Method to display task input dialog for adding a new task
  void showAddTaskDialog() {
    TextEditingController taskController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add New Task"),
          content: TextField(
            controller: taskController,
            decoration: InputDecoration(hintText: "Task name"),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (taskController.text.isNotEmpty) {
                  addTask(taskController.text);
                }
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Management'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: showAddTaskDialog, // Show dialog for adding task
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              tasks[index].name,
              style: TextStyle(
                decoration: tasks[index].isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => removeTask(index), // Remove task
            ),
            leading: IconButton(
              icon: Icon(
                tasks[index].isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
              ),
              onPressed: () => completeTask(index), // Mark task as complete
            ),
            onLongPress: () => removeTask(index), // Remove task on long press
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TaskListScreen(),
  ));
}

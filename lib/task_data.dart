import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'task_model.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('tasks');
    if (jsonString != null) {
      _tasks = (jsonDecode(jsonString) as List)
          .map((e) => Task.fromMap(e))
          .toList();
    }
    notifyListeners();
  }

  void addTask(Task task) {
    _tasks.add(task);
    saveTasks();
    notifyListeners();
  }

  void updateTask(Task task, int index) {
    _tasks[index] = task;
    saveTasks();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    saveTasks();
    notifyListeners();
  }

  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(_tasks.map((e) => e.toMap()).toList());
    await prefs.setString('tasks', jsonString);
  }
}

extension TaskExtension on Task {
  Map<String, dynamic> toMap() => {
        'title': title,
        'isComplete': isComplete,
      };

  static Task fromMap(Map<String, dynamic> map) => Task(
        title: map['title'],
        isComplete: map['isComplete'],
      );
}

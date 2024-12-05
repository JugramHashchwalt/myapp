import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../task_data.dart';
import '../widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskData>(context);
    return ListView.builder(
      itemBuilder: (context, index) {
        final task = taskData.tasks[index];
        return TaskTile(
          taskTitle: task.title,
          isChecked: task.isComplete,
          checkboxCallback: (bool? checkboxState) {
            taskData.updateTask(task.copyWith(isComplete: checkboxState!), index);
          },
          deleteCallback: () {
            taskData.deleteTask(index);
          },
        );
      },
      itemCount: taskData.tasks.length,
    );
  }
}

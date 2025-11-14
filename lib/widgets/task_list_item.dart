// lib/widgets/task_list_item.dart
import 'package:flutter/material.dart';
import '../models/task.dart';

class TaskListItem extends StatelessWidget {
  final Task task;
  final Function(String) onToggleCompletion;
  final Function(String) onRemove;

  const TaskListItem({
    super.key,
    required this.task,
    required this.onToggleCompletion,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final statusText = task.isCompleted ? 'Tarefa concluída' : 'Tarefa em andamento';
    final statusColor = task.isCompleted ? Colors.green : Theme.of(context).colorScheme.secondary;
    final icon = task.isCompleted ? Icons.check_circle : Icons.circle_outlined;
    
    return Dismissible(
      key: ValueKey(task.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        onRemove(task.id);
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
        elevation: 2,
        child: ListTile(
          leading: Icon(
            icon,
            color: statusColor,
            size: 30,
          ),
          title: Text(
            task.title,
            style: TextStyle(
              fontSize: 17,
              decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
              color: task.isCompleted ? Colors.black54 : Colors.black87,
            ),
          ),
          subtitle: Text(
            statusText,
            style: TextStyle(color: statusColor, fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
            icon: Icon(
              task.isCompleted ? Icons.undo : Icons.done,
              color: task.isCompleted ? Colors.blueGrey : Colors.green,
            ),
            onPressed: () => onToggleCompletion(task.id),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '/models/todo.dart';
import '/widgets/todo_list_tile.dart';

class TodosList extends StatelessWidget {
  const TodosList({
    super.key,
    required this.todos,
  });

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 12.0,
      ),
      child: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final task = todos[index];
          return TaskListTile(
            todo: task,
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc_pattern/bloc/todos_bloc.dart';
import 'package:todo_app_bloc_pattern/screens/create_edit_todo_page.dart';

import '/models/todo.dart';

class TaskListTile extends StatelessWidget {
  const TaskListTile({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => CreateEditTodoPage(todo: todo),
            ),
          );
        },
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (value) {
            context.read<TodosBloc>().add(
                  MarkTodoAsCompeletedEvent(
                    id: todo.id,
                    isCompleted: value ?? false,
                  ),
                );
          },
        ),
        title: Text(
          todo.title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600
          ),
        ),
        subtitle: Text(
          todo.description,
          style: const TextStyle(
            fontSize: 13
          ),
        ),
        trailing: IconButton(
          onPressed: () {
            context.read<TodosBloc>().add(DeleteTodoEvent(id: todo.id));
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}

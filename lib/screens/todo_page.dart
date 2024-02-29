import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc_pattern/bloc/todos_bloc.dart';
import 'package:todo_app_bloc_pattern/screens/create_edit_todo_page.dart';
import 'package:todo_app_bloc_pattern/widgets/filter_todos_button.dart';
import 'package:todo_app_bloc_pattern/widgets/option_todos_button.dart';
import 'package:todo_app_bloc_pattern/widgets/tasks_list_view.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Todo List'),
        actions: const [
          FilterTodosButton(),
          OptionsTodosButton()
        ],
      ),
      body: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          final todos = state.filteredTodos;

          if (todos.isNotEmpty) {
            return TodosList(todos: todos);
          }

          return Center(
            child: Text(
              'No todos',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const CreateEditTodoPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

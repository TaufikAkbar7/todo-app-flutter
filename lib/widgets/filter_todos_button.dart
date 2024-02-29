import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc_pattern/bloc/todos_bloc.dart';

class FilterTodosButton extends StatefulWidget {
  const FilterTodosButton({super.key});

  @override
  State createState() => _FilterTodosButtonState();
}

class _FilterTodosButtonState extends State<FilterTodosButton> {
  String selectedOption = 'Show All';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.filter_list),
      onSelected: (String value) {
        setState(() {
          selectedOption = value;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Show All',
          child: const Text('Show All'),
          onTap: () {
            context.read<TodosBloc>().add(GetAllTodosEvent());
          },
        ),
        PopupMenuItem<String>(
          value: 'Show Active',
          child: const Text('Show Active'),
          onTap: () {
            context.read<TodosBloc>().add(GetActiveTodosEvent());
          },
        ),
        PopupMenuItem<String>(
          value: 'Show Completed',
          child: const Text('Show Completed'),
          onTap: () {
            context.read<TodosBloc>().add(GetCompletedTodosEvent());
          },
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc_pattern/bloc/todos_bloc.dart';

class OptionsTodosButton extends StatefulWidget {
  const OptionsTodosButton({super.key});

  @override
  State createState() => _OptionsTodosButtonState();
}

class _OptionsTodosButtonState extends State<OptionsTodosButton> {
  String selectedOption = 'Show All';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_horiz),
      onSelected: (String value) {
        setState(() {
          selectedOption = value;
        });
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'Mark All Completed',
          child: const Text('Mark All Completed'),
          onTap: () {
            context.read<TodosBloc>().add(MarkAllTodosCompleted());
          },
        ),
        PopupMenuItem<String>(
          value: 'Clear Completed',
          child: const Text('Clear Completed'),
          onTap: () {
            context.read<TodosBloc>().add(ClearAllTodosCompleted());
          },
        ),
      ],
    );
  }
}

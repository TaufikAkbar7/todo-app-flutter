import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app_bloc_pattern/bloc/todos_bloc.dart';
import 'package:todo_app_bloc_pattern/models/todo.dart';

class CreateEditTodoPage extends StatefulWidget {
  final Todo? todo;

  const CreateEditTodoPage({super.key, this.todo});

  @override
  State<CreateEditTodoPage> createState() => _CreateEditTodoPageState();
}

class _CreateEditTodoPageState extends State<CreateEditTodoPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isEdited = false;
  Todo? todo;

  @override
  void initState() {
    if (widget.todo != null) {
      // set value
      isEdited = true;
      _titleController.text = widget.todo!.title;
      _descriptionController.text = widget.todo!.description;
      todo = widget.todo;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdited ? 'Edit Task' : 'Add New Task'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextField(
                name: 'Title',
                label: 'Task Title',
                placeholder: 'Please enter title',
                textFieldController: _titleController,
                maxLength: 50,
              ),
              CustomTextField(
                name: 'Description',
                label: 'Task Description',
                placeholder: 'Please enter description',
                textFieldController: _descriptionController,
                maxLength: 300,
                maxLines: 5,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(300),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (!_formKey.currentState!.validate()) return;

                  if (isEdited) {
                    final todo = widget.todo!.copyWith(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    );

                    context.read<TodosBloc>().add(UpdateTodoEvent(todo: todo));
                  } else {
                    final todo = Todo(
                      id: DateTime.now().toIso8601String(),
                      title: _titleController.text,
                      description: _descriptionController.text,
                      isCompleted: false,
                    );

                    context.read<TodosBloc>().add(AddNewTodoEvent(todo: todo));
                  }

                  // Close the screen after adding the task
                  Navigator.pop(context);
                },
                child: Text(
                  isEdited ? 'Update Task' : 'Add Task',
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController textFieldController;
  final String name;
  final String label;
  final String placeholder;
  final int? maxLength;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    required this.textFieldController,
    required this.name,
    required this.label,
    required this.placeholder,
    this.maxLength,
    this.maxLines,
    this.inputFormatters
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textFieldController,
      autofocus: true,
      autocorrect: false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        labelText: label,
        hintText: placeholder
      ),
      maxLength: maxLength,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      textInputAction: TextInputAction.done,
      // The validator receives the text that the user has entered.
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$name cannot be empty!';
        }
        return null;
      },
    );
  }
}

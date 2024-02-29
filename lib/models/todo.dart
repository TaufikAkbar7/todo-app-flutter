import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted
  });

  Todo copyWith({
    String? title,
    String? description,
    bool? isCompleted
  }) {
    return Todo(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted
    );
  }

  @override
  List<Object> get props => [id, title, description, isCompleted];
}
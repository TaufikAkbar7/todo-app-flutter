part of 'todos_bloc.dart';

@immutable
sealed class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class AddNewTodoEvent extends TodosEvent {
  final Todo todo;

  const AddNewTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class UpdateTodoEvent extends TodosEvent {
  final Todo todo;

  const UpdateTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class DeleteTodoEvent extends TodosEvent {
  final String id;

  const DeleteTodoEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class MarkTodoAsCompeletedEvent extends TodosEvent {
  final String id;
  final bool isCompleted;

  const MarkTodoAsCompeletedEvent({
    required this.id,
    required this.isCompleted
  });

  @override
  List<Object> get props => [id, isCompleted];
}

class GetAllTodosEvent extends TodosEvent {}

class GetActiveTodosEvent extends TodosEvent {}

class GetCompletedTodosEvent extends TodosEvent {}

class MarkAllTodosCompleted extends TodosEvent {
  const MarkAllTodosCompleted();

  @override
  List<Object> get props => [];
}

class ClearAllTodosCompleted extends TodosEvent {
  const ClearAllTodosCompleted();

  @override
  List<Object> get props => [];
}


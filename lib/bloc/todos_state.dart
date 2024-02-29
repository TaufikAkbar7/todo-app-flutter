part of 'todos_bloc.dart';

enum Filter { all, active, completed }

sealed class TodosState extends Equatable {
  final List<Todo> todos;

  const TodosState({required this.todos});

  List<Todo> get filteredTodos => todos;

  @override
  List<Object> get props => [todos];
}

final class TodosInitial extends TodosState {
  const TodosInitial() : super(todos: const []);
}

final class TodosCompleted extends TodosState {
  final Filter filterBy;

  const TodosCompleted({
    required super.todos,
    this.filterBy = Filter.all
  });

  @override
  List<Todo> get filteredTodos {
    switch(filterBy) {
      case Filter.active:
        return todos.where((todo) => !todo.isCompleted).toList();
      case Filter.completed:
        return todos.where((todo) => todo.isCompleted).toList();
      case Filter.all:
        return todos;
    }
  }

  @override
  List<Object> get props => [filterBy, todos];
}

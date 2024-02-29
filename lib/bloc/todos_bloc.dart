import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:todo_app_bloc_pattern/models/todo.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(const TodosInitial()) {
    // implement add todo event handler
    on<AddNewTodoEvent>((event, emit) {
      final newTodos = state.todos.toList()..add(event.todo);

      emit(TodosCompleted(todos: newTodos));
    });

    // implement update todo event handler
    on<UpdateTodoEvent>((event, emit) {
      final newTodo = state.todos.map((todo) {
        if (todo.id == event.todo.id) {
          return event.todo;
        } else {
          return todo;
        }
      }).toList();

      emit(TodosCompleted(todos: newTodo));
    });

    // implement delete todo event handler
    on<DeleteTodoEvent>((event, emit) {
      final deleteTodoById = state.todos.where((todo) => todo.id != event.id).toList();

      emit(TodosCompleted(todos: deleteTodoById));
    });

    // implement mark todo as completed event handler
    on<MarkTodoAsCompeletedEvent>((event, emit) {
      final newTodo = state.todos.map((todo) {
        if (todo.id == event.id) {
          return todo.copyWith(isCompleted: event.isCompleted);
        } else {
          return todo;
        }
      }).toList();

      emit(TodosCompleted(todos: newTodo));
    });

    // implement get all todos event handler
    on<GetAllTodosEvent>((event, emit) {
      emit(TodosCompleted(todos: state.todos));
    });

    // implement get active todos event handler
    on<GetActiveTodosEvent>((event, emit) {
      emit(TodosCompleted(todos: state.todos, filterBy: Filter.active));
    });

    // implement get completed todos event handler
    on<GetCompletedTodosEvent>((event, emit) {
      emit(TodosCompleted(todos: state.todos, filterBy: Filter.completed));
    });

    // implement mark completed all todos event handler
    on<MarkAllTodosCompleted>((event, emit) {
      final newTodos = state.todos.map((todo) {
        return todo.copyWith(isCompleted: true);
      }).toList();

      emit(TodosCompleted(todos: newTodos));
    });

    // implement clear completed all todos event handler
    on<ClearAllTodosCompleted>((event, emit) {
      final newTodos = state.todos.map((todo) {
        return todo.copyWith(isCompleted: false);
      }).toList();

      emit(TodosCompleted(todos: newTodos));
    });
  }
}

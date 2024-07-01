import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/data/models/todo_model.dart';
import 'package:flutter_todo_app/domain/usecases/create_todo.dart';
import 'package:flutter_todo_app/domain/usecases/delete_todo.dart';
import 'package:flutter_todo_app/domain/usecases/update_todo.dart';
import '../../domain/usecases/get_todos.dart';

import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final CreateTodo createTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;

  TodoBloc({
    required this.getTodos,
    required this.createTodo,
    required this.updateTodo,
    required this.deleteTodo,
  }) : super(TodoInitial()) {
    on<GetTodosEvent>(_onGetTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  void _onGetTodos(GetTodosEvent event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final failureOrTodos = await getTodos();
    emit(failureOrTodos.fold(
      (failure) => TodoError('Failed to fetch todos'),
      (todos) => TodosLoaded(todos),
    ));
  }

  void _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    final newTodo = TodoModel(
      title: event.todo.title,
      description: event.todo.description,
      dueDate: event.todo.dueDate,
      isCompleted: false,
    );

    final result = await createTodo(newTodo);
    result.fold(
      (failure) => emit(TodoError('Failed to add todo')),
      (todo) {
        print('Todo created successfully: ${todo.id}');
        add(GetTodosEvent());
      },
    );
  }

  // lib/presentation/bloc/todo_bloc.dart

  void _onUpdateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    final updatedTodo = TodoModel(
      id: event.todo.id,
      title: event.todo.title,
      description: event.todo.description,
      dueDate: event.todo.dueDate,
      isCompleted: event.todo.isCompleted,
    );

    final result = await updateTodo(updatedTodo);
    result.fold(
      (failure) {
        print('Failed to update todo: $failure');
        emit(TodoError('Failed to update todo'));
      },
      (todo) {
        print('Todo updated successfully: ${todo.id}');
        add(GetTodosEvent());
      },
    );
  }

  void _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    final failureOrVoid = await deleteTodo(event.id);
    failureOrVoid.fold(
      (failure) => emit(TodoError('Failed to delete todo')),
      (_) => add(GetTodosEvent()),
    );
  }
}

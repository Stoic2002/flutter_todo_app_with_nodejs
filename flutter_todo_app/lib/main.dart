import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todo_app/domain/repositories/todo_repository_impl.dart';
import 'package:flutter_todo_app/presentation/bloc/todo_event.dart';
import 'package:http/http.dart' as http;
import 'data/datasources/todo_remote_datasource.dart';
import 'domain/usecases/create_todo.dart';
import 'domain/usecases/delete_todo.dart';
import 'domain/usecases/get_todos.dart';
import 'domain/usecases/update_todo.dart';
import 'presentation/bloc/todo_bloc.dart';
import 'presentation/pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // PERBAIKAN: Pindahkan BlocProvider ke level tertinggi
    return BlocProvider(
      create: (context) {
        final todoRemoteDataSource =
            TodoRemoteDataSourceImpl(client: http.Client());
        final todoRepository =
            TodoRepositoryImpl(remoteDataSource: todoRemoteDataSource);
        return TodoBloc(
          getTodos: GetTodos(todoRepository),
          createTodo: CreateTodo(todoRepository),
          updateTodo: UpdateTodo(todoRepository),
          deleteTodo: DeleteTodo(todoRepository),
        )..add(GetTodosEvent());
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
      ),
    );
  }
}

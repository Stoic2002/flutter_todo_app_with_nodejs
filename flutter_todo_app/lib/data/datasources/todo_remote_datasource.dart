import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos();
  Future<TodoModel> createTodo(TodoModel todo);
  Future<TodoModel> updateTodo(TodoModel todo);
  Future<void> deleteTodo(int id);
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final http.Client client;
  final String baseUrl =
      'your-api-key'; // Use your actual IP if not using Android emulator

  TodoRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TodoModel>> getTodos() async {
    final response = await client.get(Uri.parse('$baseUrl/todos'));
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((todo) => TodoModel.fromJson(todo))
          .toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  @override
  Future<TodoModel> createTodo(TodoModel todo) async {
    final response = await client.post(
      Uri.parse('$baseUrl/todos'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todo.toJson()),
    );
    if (response.statusCode == 201) {
      return TodoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create todo');
    }
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todo) async {
    final response = await client.put(
      Uri.parse('$baseUrl/todos/${todo.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todo.toJson()),
    );
    if (response.statusCode == 200) {
      return TodoModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  @override
  Future<void> deleteTodo(int id) async {
    final response = await client.delete(Uri.parse('$baseUrl/todos/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}

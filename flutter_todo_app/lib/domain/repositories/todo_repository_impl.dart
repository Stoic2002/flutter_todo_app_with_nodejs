import 'package:dartz/dartz.dart';
import 'package:flutter_todo_app/data/datasources/todo_remote_datasource.dart';
import 'package:flutter_todo_app/data/models/todo_model.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;

  TodoRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      final remoteTodos = await remoteDataSource.getTodos();
      return Right(remoteTodos);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Todo>> createTodo(Todo todo) async {
    try {
      final remoteTodo = await remoteDataSource.createTodo(todo as TodoModel);
      return Right(remoteTodo);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(Todo todo) async {
    try {
      final remoteTodo = await remoteDataSource.updateTodo(todo as TodoModel);
      return Right(remoteTodo);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(int id) async {
    try {
      await remoteDataSource.deleteTodo(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

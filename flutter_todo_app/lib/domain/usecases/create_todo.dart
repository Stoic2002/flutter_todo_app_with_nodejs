import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class CreateTodo {
  final TodoRepository repository;

  CreateTodo(this.repository);

  Future<Either<Failure, Todo>> call(Todo todo) async {
    return await repository.createTodo(todo);
  }
}

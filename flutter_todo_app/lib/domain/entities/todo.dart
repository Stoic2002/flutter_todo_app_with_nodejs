import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final int? id;
  final String title;
  final String description;
  final DateTime dueDate;
  final bool isCompleted;
  final DateTime? createdAt;
  const Todo(
      {this.id,
      required this.title,
      required this.description,
      required this.dueDate,
      this.isCompleted = false,
      this.createdAt});

  @override
  List<Object?> get props =>
      [id, title, description, dueDate, isCompleted, createdAt];
}

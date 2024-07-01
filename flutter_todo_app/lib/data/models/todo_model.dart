import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  const TodoModel({
    int? id,
    required String title,
    required String description,
    required DateTime dueDate,
    bool isCompleted = false,
    DateTime? createdAt,
  }) : super(
            id: id,
            title: title,
            description: description,
            dueDate: dueDate,
            isCompleted: isCompleted,
            createdAt: createdAt);

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      dueDate: DateTime.parse(json['due_date']),
      isCompleted: json['is_completed'] == 1,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'due_date': dueDate.toIso8601String().split('T')[0],
      'is_completed': isCompleted ? 1 : 0,
    };
  }
}

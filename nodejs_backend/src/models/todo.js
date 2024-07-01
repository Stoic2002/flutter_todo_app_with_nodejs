const db = require('../config/database');

class Todo {
  static async getAll() {
    const [rows] = await db.query('SELECT * FROM todos');
    return rows;
  }

  static async create(todo) {
    const [result] = await db.query(
      'INSERT INTO todos (title, description, due_date, is_completed) VALUES (?, ?, ?, ?)',
      [todo.title, todo.description, todo.due_date, todo.is_completed ? 1 : 0]
    );
    return result.insertId;
  }

  static async update(id, todo) {
    const [result] = await db.query(
      'UPDATE todos SET title = ?, description = ?, due_date = ?, is_completed = ? WHERE id = ?',
      [todo.title, todo.description, todo.due_date, todo.is_completed ? 1 : 0, id]
    );
    return result.affectedRows;
  }
  

  static async delete(id) {
    const [result] = await db.query('DELETE FROM todos WHERE id = ?', [id]);
    return result.affectedRows;
  }
}

module.exports = Todo;
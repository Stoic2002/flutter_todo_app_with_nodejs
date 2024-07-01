const Todo = require('../models/todo');

exports.getAllTodos = async (req, res) => {
  try {
    const todos = await Todo.getAll();
    res.json(todos);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.createTodo = async (req, res) => {
  try {
    const todoData = {
      title: req.body.title,
      description: req.body.description,
      due_date: req.body.due_date,
      is_completed: req.body.is_completed || false
    };
    const id = await Todo.create(todoData);
    res.status(201).json({ id, ...todoData });
  } catch (error) {
    console.error('Error creating todo:', error);
    res.status(500).json({ message: error.message });
  }
};

exports.updateTodo = async (req, res) => {
  try {
    const result = await Todo.update(req.params.id, req.body);
    if (result) {
      res.json({ id: req.params.id, ...req.body });
    } else {
      res.status(404).json({ message: 'Todo not found' });
    }
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.deleteTodo = async (req, res) => {
  try {
    const result = await Todo.delete(req.params.id);
    if (result) {
      res.json({ message: 'Todo deleted successfully' });
    } else {
      res.status(404).json({ message: 'Todo not found' });
    }
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
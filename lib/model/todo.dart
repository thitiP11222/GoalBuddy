import 'package:flutter/material.dart';

class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo(
    {
    required this.id,
    required this.todoText,
    this.isDone = false,
  }
  );

  static List<Todo> todoList(){
    return[
      Todo(id: '001', todoText: 'Read Book'),
      
    ];
  }
}
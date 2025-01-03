import 'package:flutter/material.dart';
import 'package:goalbuddy/color.dart';
import 'package:goalbuddy/model/todo.dart';

class TodoItems extends StatelessWidget {
  final Todo todo ;
  final onToDoChange ;
  final onDeleteItem;

  const TodoItems({Key? key, required this.todo, required this.onToDoChange, required this.onDeleteItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          onToDoChange(todo);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        tileColor: colorWhite,
        leading: Icon(
          todo.isDone? Icons.check_box: Icons.check_box_outline_blank,
          color: colorTeal,
        ),
        title: Text(
          todo.todoText!,
          style: TextStyle(fontSize: 16, color: colorBlack,
          decoration: todo.isDone? TextDecoration.lineThrough: null),
        ),
        trailing: Container(
          
          
          child: IconButton(
            color: colorRed,
            iconSize: 20,
            icon: Icon(Icons.delete),
            onPressed: (){
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}

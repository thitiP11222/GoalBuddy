import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:goalbuddy/color.dart';
import 'package:goalbuddy/widgets/items.dart';
import 'package:goalbuddy/model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = Todo.todoList();
  final _todoController = TextEditingController();
  List<Todo> _searchTodo=[];

  @override
  void initState() {
    _searchTodo = todosList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorTealLight,
        appBar: AppBar(
          backgroundColor: colorTealLight,
          elevation: 0,
          
          title:Row(
            children: [
              Container(height: 40,width: 40,child: ClipRRect(child: Image.asset('assets/images/logo (1).png'),),),
               Text('GoalBuddy',
              style:
                  TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20,fontWeight: FontWeight.w500)),
                  
            ],
          )
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30, bottom: 15),
                        child: Text(
                          'Your Tasks: ',
                          style: TextStyle(
                              fontSize: 18),
                        ),
                      ),
                      for (Todo i in _searchTodo) TodoItems(todo: i,onToDoChange: _handleToDoChange,onDeleteItem:_handleDelete,),
                    ],
                  ),
                )
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromARGB(92, 184, 184, 184),
                              offset: Offset(0.0, 0.0),
                              blurRadius: 10.0,
                              spreadRadius: 0.0),
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                          hintText: 'Add your task', border: InputBorder.none),
                    ),
                  )),
                  Container(
                    margin: EdgeInsets.only(bottom: 20, right: 20),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _addTodo(_todoController.text);
                      },
                      label: Icon(
                        Icons.add,
                        color: colorWhite, 
                      ),
                      style: ButtonStyle(
    backgroundColor: MaterialStateProperty.all(colorTeal), 
    padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 20, vertical: 15)), 
                    ),
                  ))
                ],
              ),
            )
          ],
        )
        );
  }

void _handleToDoChange(Todo todo){
  setState(() {
    todo.isDone = !todo.isDone;
  });
  
}

void _handleDelete(String id){
  setState(() {
    todosList.removeWhere((item)=> item.id==id);
  });
  
}

void _addTodo(String toDo){
  setState(() {
    todosList.add(Todo(id: DateTime.now().microsecondsSinceEpoch.toString(), 
  todoText: toDo));
  });
  _todoController.clear();
}

void _runFilter(String enteredKeyword){
  List<Todo> result =[];
  if(enteredKeyword.isEmpty){
    result = todosList;
  } else{
    result = todosList.where((item) => item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
  }

  setState(() {
    _searchTodo = result;
  });
} 
Widget searchBox() {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 15),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
    ),
    child: TextField(
      onChanged: (value) => _runFilter(value),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: colorBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: colorGrey)),
    ),
  );
}

}


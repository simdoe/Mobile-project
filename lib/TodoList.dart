import 'package:flutter/material.dart';
import 'package:mini_project/Todo.dart';


class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  // create array list to store information when I add into checkbox.
  List<Todo> todos = [];
  TextEditingController controller = new TextEditingController(); // get information from input add into controller
  _toggleTodo(Todo todo, bool isChecked) { // is checked on checkbox 
    setState(() {
      todo.isDone = isChecked;
    });
  }

  Widget _bulidItem(BuildContext context, int index) {
    final todo = todos[index];
    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title),
      onChanged: (bool isChecked) {
        _toggleTodo(todo, isChecked);
      },
    );
  }

  _addTodo() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("New todo"),
            content: TextField(
              controller: controller,
              autofocus: true,
            ),
            actions: <Widget>[
              MaterialButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              MaterialButton(
                child: Text("Add"),
                onPressed: () {
                  setState(() {
                    final todo = new Todo(title: controller.value.text);
                    if (controller.value.text == "") {
                      print(" ");
                    } else {
                      todos.add(todo); // add information into array list
                    }
                    controller.clear(); // clear information when you add again
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          );
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: ListView.builder( // builder information when I add. 
        itemBuilder: _bulidItem,
        itemCount: todos.length,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addTodo,
      ),
    );
  }
}
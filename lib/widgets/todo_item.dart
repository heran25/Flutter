import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/model/todo.dart';
import 'package:flutter_application_1/widgets/todo_item.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final toDoChange;
final deteteToDo;
  const ToDoItem({super.key, required this.todo,required this.toDoChange, required this.deteteToDo});
  @override
  Widget build(BuildContext context) {
    return 
      Container(
        padding: const EdgeInsets.only(bottom: 20),
        child: ListTile(
          onTap: () { 
       toDoChange(todo);
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          tileColor: Colors.white,
          leading:  Icon(
           todo.isDone? Icons.check_box: Icons.check_box_outline_blank, 
            color: Colors.blue,
          ),
          title:  Text(
            todo.toDoText!,
            style:  TextStyle(
                color: tdBlack,
                fontSize: 16,
               decoration:  todo.isDone? TextDecoration.lineThrough: null,),
          ),
          trailing: Container(
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                  color: Colors.red, borderRadius: BorderRadius.circular(5)),
              child: IconButton(padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                icon: const Icon(Icons.delete),
                color: Colors.white,
                onPressed: () {
                  deteteToDo(todo.id);
                },
              )),
        ),
    
      );
    
  }
}

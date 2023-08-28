import 'package:flutter/material.dart';
import 'package:flutter_application_1/constants/colors.dart';
import 'package:flutter_application_1/model/todo.dart';
import 'package:flutter_application_1/widgets/todo_item.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todoslist = ToDo.toDoList;
  List<ToDo> found = [];
  final _toDoController = TextEditingController();
  void initState() {
    found = todoslist;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                    child: ListView(children: [
                  Container(
                      margin: const EdgeInsets.only(top: 50, bottom: 20),
                      child: const Text(
                        "All ToDos",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  for (ToDo todoo in found)
                    ToDoItem(
                        todo: todoo,
                        toDoChange: _handleToDoChange,
                        deteteToDo: _handleDelete),
                ])),
                Row(children: [
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 2, horizontal: 2),
                        decoration: BoxDecoration(
                            boxShadow: const [
                              BoxShadow(color: Colors.grey, blurRadius: 20)
                            ],
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          onSubmitted: (value) {
                            setState(() {
                              todoslist.add(ToDo(
                                  id: DateTime.now()
                                      .millisecondsSinceEpoch
                                      .toString(),
                                  toDoText: value));
                            });
                            _toDoController.clear();
                          },
                          controller: _toDoController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 10),
                            border: InputBorder.none,
                            hintText: 'Add a new todo item',
                          ),
                        )),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blueAccent),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 10),
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                      onPressed: () {
                        _addItem(_toDoController.text);
                      },
                    ),
                  )
                ]),
              ],
            )));
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDelete(String s) {
    setState(() {
      todoslist.removeWhere((element) => element.id == s);
      found.removeWhere((element) => element.id == s);
    });
  }

  void _addItem(String s) {
    setState(() {
      todoslist.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(), toDoText: s));
    });
    _toDoController.clear();
  }

  void search(String s) {
    List<ToDo> result = [];
    if (s.isEmpty) {
      result = todoslist;
    } else {
      result = todoslist
          .where(
              (item) => item.toDoText!.toLowerCase().contains(s.toLowerCase()))
          .toList();
    }
    setState(() {
      found=result;
    });
  }

  Widget searchBox() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child:  TextField(
        onChanged:(value) => search(value) ,
          decoration: const InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 15, 10, 10),
              prefixIcon: Icon(
                Icons.search,
                color: tdBlack,
                size: 20,
              ),
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(color: tdBlack))),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: tdBGColor,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Icon(Icons.menu, color: tdBlack, size: 30),
          Container(
              height: 40,
              width: 40,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset('images/rose.jpg'))),
        ]));
  }
}

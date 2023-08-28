class ToDo {
  String? id;
  String? toDoText;
  bool isDone;
  ToDo({required this.id, required this.toDoText, this.isDone = false});
  static List<ToDo> toDoList=[];
}

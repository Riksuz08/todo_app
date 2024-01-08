import 'package:flutter/material.dart';
import 'package:todo_pp/util/dialog_box.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_pp/util/todo_tile.dart';
import 'package:todo_pp/data/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
final _myBox = Hive.box('mybox');
ToDoDatabase db = ToDoDatabase();

//text controller
final _controller = TextEditingController();
@override
  void initState() {
      if(_myBox.get("TODOLIST")==null){
        db.createInitialData();
      }else{
        db.loadData();
      }

    // TODO: implement initState
    super.initState();
  }


void checkBoxChanged(bool? value, int index){
  setState(() {
    db.toDoList[index][1] = !db.toDoList[index][1];
    db.updateDatabase();
  });
}
void saveNewTask(){
  setState(() {
    db.toDoList.add([_controller.text,false]);
    Navigator.of(context).pop();
    _controller.clear();
      db.updateDatabase();
  });
}
void createNewTask(){
  showDialog(
    context: context, 
    builder: (context){
      return DialogBox(
        controller: _controller,
        onSave: saveNewTask,
        
        onCancel: () => Navigator.of(context).pop(),
        );
    }
    );
}
void deleteTask(int index){
  setState(() {
    db.toDoList.removeAt(index);
    db.updateDatabase();
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
       backgroundColor:Colors.yellow[200] ,
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        centerTitle: true,
        title: Text('TO DO'),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        shape: CircleBorder(),
        onPressed:createNewTask,
        child: Icon(Icons.add),
      ),
     body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context,index){
          return ToDoTile(
            name: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value)=> checkBoxChanged(value, index),
            deleteFunction: (context)=>deleteTask(index)
          );
        },
     )
     
     );
    
  }
}
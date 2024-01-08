import 'package:flutter/material.dart';
import 'package:todo_pp/util/my_button.dart';

class DialogBox extends StatelessWidget {
  final controller;
  VoidCallback onSave;
   VoidCallback onCancel;
   DialogBox({super.key, this.controller, required this.onCancel,required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: Container(
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.yellow), // Change the color for the active border
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black), // Change the color for the default border
                ),
                hintText: "Add a new task",
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
              MyButton(name: 'Save', onPressed: onSave),
              SizedBox(width: 8,),
               MyButton(name: 'Cancel', onPressed: onCancel)
            ],)
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sqflite_assignment/task_model.dart';

import 'constants.dart';
import 'db/db_helper.dart';

class NewTask extends StatefulWidget {
  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  bool isComplete = false;

  String taskName;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Task"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 20, right: 20),
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              child: TextField(
                decoration: InputDecoration(
                    suffixIcon: Checkbox(
                        value: isComplete,
                        onChanged: (value) {
                          this.isComplete = value;
                          setState(() {});
                        }),
                    labelText: "Title :",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
                onChanged: (val) {
                  this.taskName = val;
                },
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 15, bottom: 15, left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'SAVE',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          DBHelper.myDatabase
                              .insertTask(Task(this.taskName, this.isComplete));
                          taskList.add(Task(this.taskName, this.isComplete));
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

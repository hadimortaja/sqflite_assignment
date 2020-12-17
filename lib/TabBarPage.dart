
import 'package:flutter/material.dart';
import 'package:sqflite_assignment/task_model.dart';

import 'constants.dart';
import 'db/db_helper.dart';
import 'new_task.dart';


class TabBarPage extends StatefulWidget {


  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage>
    with SingleTickerProviderStateMixin {
  TabController tabController;
  var i = 1;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  var index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
     child: 
             Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return NewTask();
                },
              ));
            }
      ),
      appBar: AppBar(

        title: Text("My Tasks"),
        bottom: TabBar(
          controller: tabController,
          tabs: [
            Tab(
              text: "All Task",
            ),
            Tab(
              text: "Complete Tasks",
            ),
            Tab(
              text: "InComplete Tasks",
            ),
          ],
          isScrollable: true,
        ),
      ),
      body: Column(children: [
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: [AllTasks(), CompleteTasks(), InCompleteTasks()],
          ),
        ),
      ]),
    );
  }
}

class AllTasks extends StatefulWidget {
  @override
  _AllTasksState createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          children: taskList
              .where((element) =>
                  element.isComplete == false || element.isComplete == true)
              .map((e) => TasksWidget(e, myFun))
              .toList()),
    );
  }
}

class CompleteTasks extends StatefulWidget {
  @override
  _CompleteTasksState createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          children: taskList
              .where((element) => element.isComplete == true)
              .map((e) => TasksWidget(e, myFun))
              .toList()),
    );
  }
}

class InCompleteTasks extends StatefulWidget {
  @override
  _InCompleteTasksState createState() => _InCompleteTasksState();
}

class _InCompleteTasksState extends State<InCompleteTasks> {
  myFun() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
          children: taskList
              .where((element) => element.isComplete == false)
              .map((e) => TasksWidget(e, myFun))
              .toList()),
    );
  }
}

class TasksWidget extends StatefulWidget {
  Task task;
  Function function;

  TasksWidget(this.task, [this.function]);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: IconButton(
                icon: Icon(Icons.delete),
                onPressed: (){
             deleteItem(context, widget.task).then((value)
                    {
                      DBHelper.myDatabase.deleteTask(widget.task.id);
                      taskList.remove(widget.task);
                      setState(() {
                        this.widget.function();
                      });
                    }
                  );
                }),
                title:Text(this.widget.task.taskName) ,
                trailing:   Checkbox(
                value: widget.task.isComplete,
                onChanged: (value) {
                  this.widget.task.isComplete = value;
                  DBHelper.myDatabase.updateTask(this.widget.task);
                  setState(() {});
                  this.widget.function();
                }) ,
            
              )
            

      
     );
  }
}





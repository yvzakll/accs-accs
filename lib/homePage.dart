import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_generator/constants.dart';
import 'package:pin_generator/storage.dart';
import 'package:pin_generator/todo.dart';
import 'package:pin_generator/todoView.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'accs.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPreferences prefs;
  List todos = [];
  setupTodo() async {
    prefs = await SharedPreferences.getInstance();
    String stringTodo = prefs.getString('todo');
    List todoList = jsonDecode(stringTodo);
    for (var todo in todoList) {
      setState(() {
        todos.add(Todo().fromJson(todo));
      });
    }
  }

  void saveTodo() {
    List items = todos.map((e) => e.toJson()).toList();
    prefs.setString('todo', jsonEncode(items));
  }

  @override
  void initState() {
    super.initState();
    setupTodo();
  }

  Color appcolor = const Color.fromRGBO(58, 66, 86, 1.0);
  @override
  Widget build(BuildContext context) {
    String pcName = box.read('name');
    return Scaffold(
      backgroundColor: appcolor,
      appBar: /* AppBar(
        centerTitle: true,
        title: Text("Todo"),
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      ), */
          AppBar(
        actionsIconTheme: IconThemeData(color: appcolor),

        elevation: 0.0,
        //bottom shadow disabled
        backgroundColor: appcolor,

        iconTheme: IconThemeData(color: appcolor),
        toolbarHeight: 60,
        flexibleSpace: Container(
          color: appcolor,
          child: const Image(
            image: MyConstants.logobarblack,
            fit: BoxFit.fill,
            width: 100,
          ),
        ),
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
                elevation: 8.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(64, 75, 96, .9),
                  ),
                  child: makeListTile(todos[index], index),
                ));
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black12,
        onPressed: () async {
          addTodo();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  addTodo() async {
    int id = Random().nextInt(30);
    Todo t = Todo(id: id, title: '', description: '', status: false);
    Todo returnTodo = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TodoView(todo: t)));
    if (returnTodo != null) {
      setState(() {
        todos.add(returnTodo);
      });
      saveTodo();
    }
  }

  makeListTile(Todo todo, index) {
    return GestureDetector(
      onTap: () {
        box.write('authKey', todo.description);
        box.write('name', todo.title);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const MyHomePage(
            title: "GENERATE PIN",
          ),
        ));
      },
      child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: InkWell(
              onTap: () async {
                Todo t = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TodoView(todo: todos[index])));
                if (t != null) {
                  setState(() {
                    todos[index] = t;
                  });
                  saveTodo();
                }
              },
              child: const Icon(Icons.edit, color: Colors.white, size: 30.0)),
          title: Row(
            children: [
              Text(
                todo.title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 10,
              ),
              todo.status
                  ? const Icon(
                      Icons.verified,
                      color: Colors.greenAccent,
                    )
                  : Container()
            ],
          ),
          // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

          subtitle: Wrap(
            children: <Widget>[
              /* Text(todo.description,
                  overflow: TextOverflow.clip,
                  maxLines: 1,
                  style: const TextStyle(color: Colors.white),), */
            ],
          ),
          trailing: InkWell(
              onTap: () {
                delete(todo);
              },
              child:
                  const Icon(Icons.delete, color: Colors.white, size: 30.0))),
    );
  }

  delete(Todo todo) {
    return showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text("Alert"),
              content: const Text("Are you sure to delete"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("No")),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        todos.remove(todo);
                      });
                      Navigator.pop(ctx);
                      saveTodo();
                    },
                    child: const Text("Yes"))
              ],
            ));
  }
}

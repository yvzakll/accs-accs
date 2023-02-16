import 'package:flutter/material.dart';
import 'package:pin_generator/todo.dart';

import 'constants.dart';

class TodoView extends StatefulWidget {
  Todo todo;
  TodoView({Key key, this.todo}) : super(key: key);

  @override
  _TodoViewState createState() => _TodoViewState(todo: this.todo);
}

class _TodoViewState extends State<TodoView> {
  Todo todo;
  _TodoViewState({this.todo});
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (todo != null) {
      titleController.text = todo.title;
      descriptionController.text = todo.description;
    }
  }

  Widget build(BuildContext context) {
    Color appcolor = const Color.fromRGBO(58, 66, 86, 1.0);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        actionsIconTheme: IconThemeData(color: appcolor),

        elevation: 0.0,
        //bottom shadow disabled
        backgroundColor: appcolor,

        iconTheme: const IconThemeData(color: Colors.white),
        toolbarHeight: 60,
        flexibleSpace: Container(
          color: appcolor,
          child: const Image(
            image: MyConstants.logobarblack2,
            fit: BoxFit.fill,
            width: 100,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                  child: colorOverride(TextField(
                onChanged: (data) {
                  todo.title = data;
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.white),
                  labelText: "Computer Name",
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.green),
                  ),

                  prefixIcon: const Icon(
                    Icons.computer,
                    color: Colors.white,
                    size: 20,
                  ),
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  //fillColor: Colors.green
                ),
                controller: titleController,
              ))),
              const SizedBox(
                height: 25,
              ),
              Container(
                  child: colorOverride(TextField(
                maxLines: 1,
                onChanged: (data) {
                  todo.description = data;
                },
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelStyle: const TextStyle(color: Colors.white),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.green),
                  ),
                  prefixIcon: const Icon(
                    Icons.key,
                    color: Colors.white,
                    size: 20,
                  ),
                  labelText: "Authorization Key",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  //fillColor: Colors.green
                ),
                controller: descriptionController,
              ))),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55.0,
        child: BottomAppBar(
          color: const Color.fromRGBO(58, 66, 86, 1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              /* InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Alert"),
                        content: Text(
                            "Mark this todo as ${todo.status ? 'not done' : 'done'}  "),
                        actions: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: const Text("No"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                todo.status = !todo.status;
                              });
                              Navigator.of(ctx).pop();
                            },
                            child: const Text("Yes"),
                          )
                        ],
                      ),
                    );
                  },
                  child: Text(
                    "${todo.status ? 'Mark as Not Done' : 'Mark as Done'} ",
                    style: const TextStyle(color: Colors.white),
                  )), */
              /* const VerticalDivider(
                color: Colors.white,
              ), */
              IconButton(
                icon: const Icon(
                  Icons.save,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  if (descriptionController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please enter a  authorization key"),
                    ));
                  } else {
                    Navigator.pop(context, todo);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget colorOverride(Widget child) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
        accentColor: Colors.white,
        hintColor: Colors.white,
      ),
      child: child,
    );
  }
}

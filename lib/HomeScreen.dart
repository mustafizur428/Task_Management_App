import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:task_app/db-services/database.dart';
import 'package:task_app/screen/signin.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool Personal = true, office = false, college = false;
  bool suggest = false;
  TextEditingController todoController = TextEditingController();
  Stream? todoStream;

  getonTheLoad() async {
    todoStream = await DatabaseService().getTask(Personal
        ? "Personal"
        : college
            ? "College"
            : "Office");
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget getWork() {
    return StreamBuilder(
        stream: todoStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot docSnap = snapshot.data.docs[index];
                      return CheckboxListTile(
                        activeColor: Colors.greenAccent.shade400,
                        title: Text(docSnap["work"]),
                        value: docSnap["Yes"],
                        onChanged: (newValue) async {
                          await DatabaseService().tickMethode(
                              docSnap["Id"],
                              Personal
                                  ? "Personal"
                                  : college
                                      ? "College"
                                      : "Office");
                          setState(() {
                            Future.delayed(const Duration(seconds: 4), () {
                              DatabaseService().removeMethode(
                                  docSnap["Id"],
                                  Personal
                                      ? "Personal"
                                      : college
                                          ? "College"
                                          : "Office");
                            });
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      );
                    },
                  ),
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[200],
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: Text(
            "YOUR DAILY TASKS",
            style: TextStyle(
                fontSize: 20.0, // Font size
                fontWeight: FontWeight.bold, // Font weight
                color: Colors.white,
                fontFamily: 'Poppins' // Text color
                ),
          )),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Signin()));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[200],
        onPressed: () {
          openBox();
        },
        child: Icon(
          Icons.task,
          color: Colors.white,
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 70, left: 20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 249, 255, 255),
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 252, 255, 254),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Center(
                child: Text(
                  "QuestList: Your Journey to Productivity!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Personal
                    ? Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(17),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[200],
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Text(
                            "Personal",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          Personal = true;
                          college = false;
                          office = false;
                          await getonTheLoad();

                          setState(() {});
                        },
                        child: Text(
                          "Personal",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                college
                    ? Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(17),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[200],
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Text(
                            "College",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          Personal = false;
                          college = true;
                          office = false;
                          await getonTheLoad();

                          setState(() {});
                        },
                        child: Text(
                          "College",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                office
                    ? Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(17),
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[200],
                            borderRadius: BorderRadius.circular(17),
                          ),
                          child: Text(
                            "Office",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () async {
                          Personal = false;
                          college = false;
                          office = true;
                          await getonTheLoad();

                          setState(() {});
                        },
                        child: Text(
                          "Office",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            getWork(),
          ],
        ),
      ),
    );
  }

  Future openBox() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                    
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Text(
                      "ADD TASK",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Add Task"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                    color: Colors.black54,
                    width: 2,
                  )),
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter The Task",
                        hintStyle: TextStyle(color: Colors.black87)),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    width: 50,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(10)),
                    child: GestureDetector(
                      onTap: () {
                        String id = randomAlpha(10);
                        Map<String, dynamic> userTodo = {
                          "work": todoController.text,
                          "Id": id,
                          "Yes": false,
                        };
                        Personal
                            ? DatabaseService().addPersonalTask(userTodo, id)
                            : college
                                ? DatabaseService().addCollegeTask(userTodo, id)
                                : DatabaseService().addOfficeTask(userTodo, id);
                        Navigator.pop(context);
                        todoController.clear();
                      },
                      child: Center(
                        child: Text(
                          "Add",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

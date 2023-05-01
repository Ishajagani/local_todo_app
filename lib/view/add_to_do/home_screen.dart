import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/app_to_do_model.dart';
import '../../res/constant/app_images.dart';
import 'add_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final TextEditingController textFieldController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  SharedPreferences? prefs;

  setInstant() async {
    prefs = await SharedPreferences.getInstance();
    getData();
  }

  setData() {
    List<String> data = [];
    for (int i = 0; i < toDoList.length; i++) {
      data.add(jsonEncode(toDoList[i].toJson()));
    }
    debugPrint(data.toString());
    prefs!.setStringList("key", data);
  }

  List<ToDoModel> toDoList = [];
  getData() {
    List<String> data = [];
    data = prefs!.getStringList("key")!;

    for (int i = 0; i < data.length; i++) {
      toDoList.add(ToDoModel.fromJson(jsonDecode(data[i])));
    }
    debugPrint(toDoList.toString());
    setState(() {});
  }

  bool checkBoxData = true;

  @override
  void initState() {
    // TODO: implement initState
    setInstant();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              backgroundColor: Colors.transparent,
              builder: (context) => AddToDoScreen(
                    toDoList: toDoList,
                  )).then((value) {
            if (value != null) {
              toDoList = value;
              setState(() {});
            }
          });
        },
        backgroundColor: const Color(0xffF76C6A),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 80, right: 20, left: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "TO DO LIST",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFFF79E89),
                    fontFamily: "Montserrat-Bold",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Image.asset(
                  AppImages.settings,
                  height: 24,
                  width: 24,
                ),
              ],
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Image.asset(
                  AppImages.listlogo,
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 15),
                const Text(
                  "LIST OF TODO",
                  style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFFF79E89),
                    fontFamily: "Montserrat-Bold",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                Image.asset(
                  AppImages.filter,
                  height: 24,
                  width: 24,
                ),
              ],
            ),
            const SizedBox(height: 40),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 15),
                itemCount: toDoList.length,
                padding: const EdgeInsets.all(15),
                itemBuilder: (context, index) => Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: const Color(0xffF76C6A),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${toDoList[index].title}",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Montserrat",
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () async {
                                dynamic data = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddToDoScreen(
                                      toDoList: toDoList,
                                      index: index,
                                    ),
                                  ),
                                );
                                if (data != null) {
                                  debugPrint("Data ---> $data");
                                  toDoList = data;
                                  setState(() {});
                                }
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: Color(0xFFFFFFFf),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                toDoList.removeAt(index);
                                setData();
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.delete_rounded,
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${toDoList[index].des}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Montserrat",
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "${toDoList[index].time}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Montserrat",
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "${toDoList[index].date}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Montserrat",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

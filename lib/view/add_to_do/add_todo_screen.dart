import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/app_to_do_model.dart';
import '../../res/common/app_container.dart';
import '../../res/common/textfield_screen.dart';

class AddToDoScreen extends StatefulWidget {
  final List<ToDoModel>? toDoList;
  final int? index;

  const AddToDoScreen({Key? key, this.toDoList, this.index}) : super(key: key);

  @override
  State<AddToDoScreen> createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  bool? dateIsSelected = false;
  TimeOfDay selectedTime = TimeOfDay.now();
  bool? timeIsSelected = false;
  SharedPreferences? prefs;

  setInstant() async {
    prefs = await SharedPreferences.getInstance();
  }

  setData() {
    List<String> data = [];
    for (int i = 0; i < toDoList.length; i++) {
      data.add(jsonEncode(toDoList[i].toJson()));
    }
    debugPrint(data.toString());
    prefs!.setStringList("key", data);
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    debugPrint("picked ---->> $selectedDate");
    debugPrint("picked ---->> $picked");

    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      dateIsSelected = true;
      setState(() {});
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    debugPrint("picked ---->> $selectedTime");
    debugPrint("picked ---->> $picked");

    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      timeIsSelected = true;
      setState(() {});
    }
  }

  List<ToDoModel> toDoList = [];

  @override
  void initState() {
    // TODO: implement initState
    toDoList = widget.toDoList!;
    if (widget.index != null) {
      titleController.text = toDoList[widget.index!].title!;
      descriptionController.text = toDoList[widget.index!].des!;

      selectedDate = DateFormat('d/M/y').parse(toDoList[widget.index!].date!);
      dateIsSelected = true;

      var hour =
          toDoList[widget.index!].time!.split(" ").first.split(":").first;
      var minute = toDoList[widget.index!].time!.split(" ").first.split(":")[1];
      selectedTime =
          TimeOfDay(hour: int.parse(hour), minute: int.parse(minute));
      timeIsSelected = true;
    }

    setInstant();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 750,
          decoration: const BoxDecoration(
            color: Color(0xFFF79E89),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const SizedBox(height: 15),
                const Text(
                  "Title",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                      fontSize: 20,
                      color: Color(0xFFFFFFFF)),
                ),
                TextFieldScreen(
                  controller: titleController,
                  hintText: "title",
                  // isDes: true,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 15),
                const Text(
                  "Date",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                      fontSize: 20,
                      color: Color(0xFFFFFFFF)),
                ),
                GestureDetector(
                  onTap: () => selectDate(context),
                  child: AppContainer(
                    hintText: dateIsSelected!
                        ? DateFormat.yMd().format(selectedDate)
                        : "Click here to choose Date",
                    isData: dateIsSelected!,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                const Text(
                  "Time",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                      fontSize: 20,
                      color: Color(0xFFFFFFFF)),
                ),
                GestureDetector(
                  onTap: () => selectTime(context),
                  child: AppContainer(
                    hintText: timeIsSelected!
                        ? selectedTime.format(context)
                        : "Enter Time",
                    isData: timeIsSelected!,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                const Text(
                  "Task Description",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: "Montserrat",
                      fontSize: 20,
                      color: Color(0xFFFFFFFF)),
                ),
                TextFieldScreen(
                  controller: descriptionController,
                  hintText: "description",
                  textInputAction: TextInputAction.done,
                  maxlines: 5,
                ),
                const SizedBox(height: 15),
                FloatingActionButton.extended(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Taks',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Montserrat")),
                  onPressed: () {
                    if (widget.index != null) {
                      toDoList[widget.index!] = ToDoModel(
                        title: titleController.text,
                        date: DateFormat.yMd().format(selectedDate),
                        time: selectedTime.format(context),
                        des: descriptionController.text,
                      );
                    } else {
                      toDoList.add(
                        ToDoModel(
                          title: titleController.text,
                          date: DateFormat.yMd().format(selectedDate),
                          time: selectedTime.format(context),
                          des: descriptionController.text,
                        ),
                      );
                    }
                    setData();
                    Navigator.pop(context, toDoList);
                  },
                  splashColor: Colors.white,
                  backgroundColor: const Color(0xffF76C6A),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

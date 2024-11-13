import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/core/util/cubit/app_bloc.dart';
import 'package:tasks_app/core/util/cubit/states.dart';
import 'package:tasks_app/features/representations/widgets/task_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime _selectedDate = DateTime.now();

  String _startTime = "06:00 Am";
  String _endTime = "12:00 Pm";

  String _selectedRemind = "10 min";
  List<String> remindList = ["10 min", "30 min", "1 hour", "1 day"];

  String _selectedRepeat = "Weekly";
  List<String> repeatList = ["none", "Daily", "Weekly", "Monthly"];

  int selectedColor = 0;


  //String _startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                color: Colors.black,
              ),
              backgroundColor: Colors.white,
              title: Text(
                "Add task",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TaskField(
                        title: "Title",
                        hint: "Design team meeting",
                        controller: AppBloc.get(context).titleController,
                        widget: null,
                      ),
                      TaskField(
                        title: "Date",
                        hint: DateFormat.yMd().format(_selectedDate),
                        widget: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          color: Colors.grey,
                          onPressed: () {
                            _getDateFromUser().then((value) {
                              _selectedDate=value;
                              AppBloc.get(context).dateController.text =
                                  DateFormat.yMMMd().format(value!).toString();
                            });
                          },
                        ),
                        controller:AppBloc.get(context).dateController,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TaskField(
                            title: "Start time",
                            hint: _startTime,
                            widget: IconButton(

                              onPressed: () {
                                _getTimeFromUser(isStartTime: true).then((value) {
                                  AppBloc.get(context).startTimeController.text =
                                      value.format(context);

                                });
                              },
                              icon: Icon(Icons.watch_later_outlined),
                              color: Colors.grey,
                            ),
                            controller: AppBloc.get(context).startTimeController,
                          )),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: TaskField(
                            title: "End time",
                            hint: _endTime,
                            widget: IconButton(
                              onPressed: () {
                                _getTimeFromUser(isStartTime: false).then((value) {
                                  _endTime=value;
                                  AppBloc.get(context).endTimeController.text = value.format(context);
                                });


                              },
                              icon: Icon(Icons.watch_later_outlined),
                              color: Colors.grey,
                            ),
                            controller: AppBloc.get(context).endTimeController,
                          )),
                        ],
                      ),
                      TaskField(
                        title: "Remind",
                        hint: "$_selectedRemind before",
                        widget: DropdownButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          elevation: 4,
                          onChanged: (String? value) {
                            _selectedRemind = value!;
                            AppBloc.get(context).remindController.text =
                                "$_selectedRemind before";
                          },
                          items: remindList.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                        controller: AppBloc.get(context).remindController,
                      ),
                      TaskField(
                        title: "Repeat",
                        hint: _selectedRepeat,
                        widget: DropdownButton(
                          icon: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                          iconSize: 32,
                          elevation: 4,
                          onChanged: (String? value) {
                            _selectedRepeat = value.toString();
                            AppBloc.get(context).repeatController.text =
                                _selectedRepeat;
                          },
                          items: repeatList.map<DropdownMenuItem<String>>(
                            (String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            },
                          ).toList(),
                        ),
                        controller: AppBloc.get(context).repeatController,
                      ),
                      Container(
                        alignment: AlignmentDirectional.topStart,
                        margin: EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Color",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Wrap(
                              children: List<Widget>.generate(4, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    selectedColor = index;
                                    AppBloc.get(context).colorIndex = index;
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 8.0),
                                    child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: index == 0
                                          ? Colors.green
                                          : index == 1
                                              ? Colors.red
                                              : index == 2
                                                  ? Colors.yellow
                                                  : Colors.teal,
                                      child: selectedColor == index
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.white,
                                              size: 16,
                                            )
                                          : null,
                                    ),
                                  ),
                                );
                              }),
                            ),
                            Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              width: double.infinity,
                              margin: EdgeInsets.all(10.0),
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.green,
                              ),
                              child: MaterialButton(
                                onPressed: () {
                                  AppBloc.get(context).insertTaskData(
                                    title:
                                        AppBloc.get(context).titleController.text,
                                    date:
                                    AppBloc.get(context).dateController.text,
                                    startTime: AppBloc.get(context)
                                        .startTimeController
                                        .text,
                                    endTime: AppBloc.get(context)
                                        .endTimeController
                                        .text,
                                    remind: AppBloc.get(context)
                                        .remindController
                                        .text,
                                    repeat: AppBloc.get(context)
                                        .repeatController
                                        .text,
                                    color: AppBloc.get(context).colorIndex,
                                  );
                                  Navigator.of(context).pushNamed('/a');
                                },
                                child: Text(
                                  "Create a task",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  _getDateFromUser() async {
    DateTime? pickerDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2025));
    if (pickerDate != null) {
      setState(() {
        _selectedDate = pickerDate;
      });
    } else {
      print("it's null or something is wrong");
    }
  }

  _getTimeFromUser({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String _formatedTime = pickedTime.format(context);
    if (pickedTime == null) {
      print("Time canceld");
    } else if (isStartTime == true) {
      setState(() {
        _startTime = _formatedTime;
      });
    } else if (isStartTime == false) {
      setState(() {
        _endTime = _formatedTime;
      });
    }
  }

  _showTimePicker() {
    return showTimePicker(
        initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(_startTime.split(":")[0]),
          minute: int.parse(_startTime.split(":")[1].split(" ")[0]),
        ));
  }
}

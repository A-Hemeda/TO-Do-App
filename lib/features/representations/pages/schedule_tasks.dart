import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tasks_app/core/util/cubit/app_bloc.dart';
import 'package:tasks_app/features/representations/widgets/schedule_item.dart';
import 'package:tasks_app/core/util/cubit/states.dart';

class ScheduleTasks extends StatefulWidget {

  ScheduleTasks({
    Key? key,
  }) : super(key: key);

  @override
  State<ScheduleTasks> createState() => _ScheduleTasksState();
}

class _ScheduleTasksState extends State<ScheduleTasks> {
  DateTime _selectedDate = DateTime.now();

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
            title: Text(
              "Schedule",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: Colors.white,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    DatePicker(
                      DateTime.now(),
                      height: 90,
                      width: 60,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Colors.green,
                      selectedTextColor: Colors.white,
                      dateTextStyle: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      dayTextStyle: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      monthTextStyle: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                      onDateChange: (date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                    ),
                  ],
                ),
              ),
              Text(
                "${DateFormat.yMd().format(_selectedDate)}",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    AppBloc.get(context).getTasksData();
                  },
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                 /*        if (AppBloc.get(context).tasks[index]['repeat'] ==
                            'daily') {
                          return ScheduleItem(
                              item: AppBloc.get(context).tasks[index]);
                        }
                        if (AppBloc.get(context).tasks[index]['date'] ==
                            _selectedDate) {
                          return ScheduleItem(
                              item: AppBloc.get(context).tasks[index]);
                        } else {
                          return Container();
                        }*/

                       return ScheduleItem(item: AppBloc.get(context).tasks[index]);
                      },
                      separatorBuilder: (context, index) => Container(),
                      itemCount: AppBloc.get(context).tasks.length),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

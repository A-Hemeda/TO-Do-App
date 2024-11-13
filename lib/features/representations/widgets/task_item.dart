import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/core/util/cubit/states.dart';

import '../../../core/util/cubit/app_bloc.dart';

class TaskItem extends StatefulWidget {
  final Map item;

  TaskItem({Key? key, required this.item}) : super(key: key);

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _checkedValue = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListTile(
          title: Text(
            "${widget.item['title']}",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
          leading: Checkbox(
            value: _checkedValue,
            activeColor: widget.item['color'] == 0
                ? Colors.green
                : widget.item['color'] == 1
                    ? Colors.red
                    : widget.item['color'] == 2
                        ? Colors.yellow
                        : Colors.teal,
            checkColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            onChanged: (bool? newValue) {
              setState(() {
                _checkedValue = newValue!;
                if (widget.item['status'] == 'completed') {
                  AppBloc.get(context).updateTaskStatus(
                      taskStatus: 'new', taskId: widget.item['id']);
                } else if (widget.item['status'] == 'new') {
                  AppBloc.get(context).updateTaskStatus(
                      taskStatus: 'completed', taskId: widget.item['id']);
                }
              });
            },
          ),
          trailing: PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Complete"),
                onTap: () {
                  AppBloc.get(context).updateTaskStatus(
                      taskStatus: 'complete', taskId: widget.item['id']);
                },
              ),
              PopupMenuItem(
                child: Text("UnComplete"),
                onTap: () {
                  AppBloc.get(context).updateTaskStatus(
                      taskStatus: 'new', taskId: widget.item['id']);
                },
              ),
              PopupMenuItem(
                child: Text("Favorite"),
                onTap: () {
                  AppBloc.get(context).updateTaskStatus(
                      taskStatus: 'favorite', taskId: widget.item['id']);
                },
              )
            ],
            onSelected: null,
          ),
        );
      },
    );
  }
}

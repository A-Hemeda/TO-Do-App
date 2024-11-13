import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/core/util/cubit/app_bloc.dart';
import 'package:tasks_app/core/util/cubit/states.dart';
import 'package:tasks_app/features/representations/widgets/task_item.dart';

class AllTasks extends StatefulWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  State<AllTasks> createState() => _AllTasksState();
}

class _AllTasksState extends State<AllTasks> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  AppBloc.get(context).getTasksData();
                },
                child: ListView.separated(
                    itemBuilder: (context, index) => TaskItem(
                          item: AppBloc.get(context).tasks[index],
                        ),
                    separatorBuilder: (context, index) => Container(),
                    itemCount: AppBloc.get(context).tasks.length),
              ),
            ),
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              width: double.infinity,
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(7.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green,
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('AddTaskPage');
                },
                child: Text(
                  "Add task",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

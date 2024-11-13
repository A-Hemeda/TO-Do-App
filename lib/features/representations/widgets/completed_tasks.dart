import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/core/util/cubit/states.dart';
import 'package:tasks_app/features/representations/widgets/task_item.dart';

import '../../../core/util/cubit/app_bloc.dart';

class CompletedTasks extends StatefulWidget {
  const CompletedTasks({Key? key}) : super(key: key);

  @override
  State<CompletedTasks> createState() => _CompletedTasksState();
}

class _CompletedTasksState extends State<CompletedTasks> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppBloc, AppStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) => TaskItem(
                      item: AppBloc.get(context).completedTasks[index]),
                  separatorBuilder: (context, index) => Container(),
                  itemCount: AppBloc.get(context).completedTasks.length),
            ),
          ],
        );
      },
    );
  }
}

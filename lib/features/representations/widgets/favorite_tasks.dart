import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/core/util/cubit/states.dart';
import 'package:tasks_app/features/representations/widgets/task_item.dart';

import '../../../core/util/cubit/app_bloc.dart';

class FavoriteTasks extends StatefulWidget {
  const FavoriteTasks({Key? key}) : super(key: key);

  @override
  State<FavoriteTasks> createState() => _FavoriteTasksState();
}

class _FavoriteTasksState extends State<FavoriteTasks> {
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
                      item: AppBloc.get(context).favoriteTasks[index]),
                  separatorBuilder: (context, index) => Container(),
                  itemCount: AppBloc.get(context).favoriteTasks.length),
            ),
          ],
        );
      },
    );
  }
}

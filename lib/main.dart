import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_app/features/representations/pages/schedule_tasks.dart';
import 'package:tasks_app/features/representations/widgets/all_tasks.dart';

import 'core/util/cubit/app_bloc.dart';
import 'features/representations/pages/add_task_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (context) => AppBloc()..initDatabase(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        // supportedLocales: const [
        //   Locale("en"),
        // ],
        // localizationsDelegates: const [
        //   CountryLocalizations.delegate,
        // ],
        home: ScheduleTasks(),
      ),
    );

  }
}



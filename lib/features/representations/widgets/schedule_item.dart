import 'package:flutter/material.dart';

class ScheduleItem extends StatelessWidget {
  final Map item;

  const ScheduleItem({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,

      width: 20,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: item['color'] == 0
      ? Colors.green
          : item['color'] == 1
      ? Colors.red
          : item['color'] == 2
      ? Colors.yellow
          : Colors.teal,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        children: [
          Text(
            "${item['startTime']}",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            "${item['title']}",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

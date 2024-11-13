import 'package:flutter/material.dart';

class TaskField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;

  TaskField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(top: 8.0),
            padding: EdgeInsets.only(left: 14.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  autofocus: false,
                  // readOnly: widget == null ? false : true,
                  controller: controller,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: TextStyle(fontSize: 18, color: Colors.blueGrey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 0,
                    )),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                      color: Colors.white,
                      width: 0,
                    )),
                  ),
                )),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

Widget app_name() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "Wallpepar",
        style: TextStyle(color: Colors.black),
      ),
      SizedBox(width: 10),
      Text("Gallery", style: TextStyle(color: Colors.blue))
    ],
  );
}

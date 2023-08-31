import 'package:flutter/material.dart';

class Student extends StatefulWidget {
  const Student({super.key});

  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:const Color(0xFF115E38),
        height: 250,
        padding: const EdgeInsets.only(top:100, left: 15, right: 15, bottom: 15),
        width: MediaQuery.of(context).size.width,
        child: const Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Adamu Jethro",
                style: TextStyle(fontFamily: 'Millik', fontSize: 30, color: Colors.white),
                ),
            )
          ],
        ),
      ),
    );
  }
}
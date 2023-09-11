import 'package:attendance/views/students/attendance.dart';
import 'package:attendance/views/students/courses.dart';
import 'package:attendance/views/students/logout.dart';
import 'package:attendance/views/students/scan.dart';
import 'package:attendance/views/students/student.dart';
import 'package:flutter/material.dart';
import 'package:botton_nav_bar/botton_nav_bar.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: BottomNavBar(
        onPressFAB: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Scan()),
          );
        },
        fabBackGroundColor:  const Color(0xFF115E38),
          notchedRadius: 30,
          centerNotched: true,
          fabIcon: const Icon(Icons.qr_code),
          bottomItems: <BottomBarItem>[
            BottomBarItem(
              bottomItemSelectedColor:  const Color(0xFF115E38),
              label: 'Student',
              screen: Student(),
              selectedIcon: FeatherIcons.user,
            ),
            BottomBarItem(
              bottomItemSelectedColor:  const Color(0xFF115E38),
              label: 'Courses',
              screen: const Courses(),
              selectedIcon: FeatherIcons.book,
            ),
            BottomBarItem(
              bottomItemSelectedColor:  const Color(0xFF115E38),
              label: 'Attendance',
              selectedIcon: FeatherIcons.bookOpen,
              screen: const Attendance(),
            ),
            BottomBarItem(
              bottomItemSelectedColor:  const Color(0xFF115E38),
              label: 'Logout',
              screen: const Logout(),
              selectedIcon: FeatherIcons.logOut,
            )
          ],
        ),
    );
  }
}
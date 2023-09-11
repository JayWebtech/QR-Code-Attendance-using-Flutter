import 'package:attendance/views/getStarted.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const Logout({Key? key});

  @override
  State<Logout> createState() => _LogoutState();
}

class _LogoutState extends State<Logout> {
  @override
  void initState() {
    super.initState();
    navigateToTabsScreen();
  }

  Future<void> navigateToTabsScreen() async {
    final preferences = await SharedPreferences.getInstance();
    preferences.remove('documentId');
    Future.delayed(Duration.zero, () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TabsScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Text("");
  }
}

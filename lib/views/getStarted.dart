// ignore_for_file: use_build_context_synchronously

import 'package:attendance/views/signupScreen.dart';
import 'package:attendance/views/students/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'loginScreen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  void initState() {
    super.initState();
    checkIfDocumentIdExists();
  }

  Future<void> checkIfDocumentIdExists() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? documentId = prefs.getString('documentId');

    if (documentId != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Dashboard()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      backgroundColor: const Color(0xFF115E38),
      child: Builder(
        builder: (context) => DefaultTabController(
          length: 2, // Number of tabs
          child: Scaffold(
            backgroundColor: const Color(0xFF115E38),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 50),
                  decoration: const BoxDecoration(
                    color: Color(0xFF115E38),
                  ),
                  child: const TabBar(
                    tabs: [
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Text(
                            'Login',
                            style: TextStyle(
                                fontFamily: 'InfantRegular', fontSize: 20),
                          ),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 15.0),
                          child: Text(
                            'Signup',
                            style: TextStyle(
                                fontFamily: 'InfantRegular', fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    indicatorColor: Colors.white,
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      LoginScreen(), // First tab (Login)
                      SignupScreen(), // Second tab (Signup)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

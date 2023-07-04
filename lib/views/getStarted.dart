import 'package:attendance/views/loginScreen.dart';
import 'package:attendance/views/signupScreen.dart';
import 'package:flutter/material.dart';

class TabsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
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
            const Expanded(
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
    );
  }
}

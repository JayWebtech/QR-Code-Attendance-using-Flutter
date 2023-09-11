import 'package:flutter/material.dart';

import '../../controllers/user_data.dart';

class Student extends StatefulWidget {
  const Student({super.key});
  @override
  State<Student> createState() => _StudentState();
}

class _StudentState extends State<Student> {
  UserDataController userDataController = UserDataController();
  Map<String, dynamic>? userData;
  Map<String, dynamic>? userCourses;

  @override
  void initState() {
    super.initState();
    loadDocumentIdAndUserData();
    loadDocumentIdAndUserCourses();
  }

  Future<void> loadDocumentIdAndUserData() async {
    await userDataController.loadDocumentId();
    fetchUserData();
  }

  Future<void> loadDocumentIdAndUserCourses() async {
    await userDataController.loadDocumentId();
    fetchCoursesByLevel();
  }

  void fetchUserData() async {
    userData = await userDataController.fetchUserData();
    setState(() {});
  }

  void fetchCoursesByLevel() async {
    userData = await userDataController.fetchCoursesByLevel();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<Map<String, dynamic>?>(
            future: userDataController.fetchUserData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF115E38),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Error fetching user data."),
                );
              } else if (!snapshot.hasData || snapshot.data == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Color(0xFF115E38),
                  ),
                );
              } else {
                final userData = snapshot.data!;
                return Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF115E38),
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/img/footer.png'), // Replace with your image asset path
                          fit: BoxFit.cover, // You can adjust the fit as needed
                        ),
                      ),
                      height: 330,
                      padding: const EdgeInsets.only(
                          top: 100, left: 15, right: 15, bottom: 15),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${userData['name']}",
                              style: const TextStyle(
                                  fontFamily: 'Millik',
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${userData['regno']}",
                              style: const TextStyle(
                                  fontFamily: 'InfantBold',
                                  fontSize: 25,
                                  color: Colors.white),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "${userData['level']}",
                              style: const TextStyle(
                                  fontFamily: 'InfantBold',
                                  fontSize: 25,
                                  color: Colors.white),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                  child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                      0xFF94E8B4), // Set the button color
                                  padding: const EdgeInsets.all(
                                      20), // Set the button padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Set the border radius
                                  ),
                                ),
                                child: const Text(
                                  'Take Attendance',
                                  style: TextStyle(
                                      fontFamily: 'InfantRegular',
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                              )),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(
                                      0xFF94E8B4), // Set the button color
                                  padding: const EdgeInsets.all(
                                      20), // Set the button padding
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        10), // Set the border radius
                                  ),
                                ),
                                child: const Text(
                                  'View Attendance',
                                  style: TextStyle(
                                      fontFamily: 'InfantRegular',
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                              ))
                            ],
                          )
                        ],
                      ),
                    ),
                    FutureBuilder<Map<String, dynamic>?>(
                      future: userDataController.fetchCoursesByLevel(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 16), // Adjust the top margin as needed
                              child: const CircularProgressIndicator(
                                color: Color(0xFF115E38),
                              ),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text("Error fetching user data."),
                          );
                        } else if (!snapshot.hasData || snapshot.data == null) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF115E38),
                            ),
                          );
                        } else {
                          final userCourses = snapshot.data!;
                          return Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xFFFCFCFC),
                                ),
                                height: MediaQuery.of(context).size.height,
                                padding: const EdgeInsets.only(
                                  top: 0,
                                  left: 15,
                                  right: 15,
                                  bottom: 100,
                                ),
                                margin: const EdgeInsets.only(bottom: 10),
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                  itemCount: userCourses.length,
                                  itemBuilder: (context, index) {
                                    final courseId =
                                        userCourses.keys.elementAt(index);
                                    final courseName = userCourses[courseId];
                                    return Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 1,
                                                blurRadius: 2,
                                                offset: const Offset(0, 1),
                                              ),
                                            ],
                                          ),
                                          padding: const EdgeInsets.all(15),
                                          margin: const EdgeInsets.only(
                                            bottom: 15,
                                            left: 5,
                                            right: 5,
                                          ),
                                          child: Column(
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  courseName ??
                                                      'Course Name Not Found',
                                                  style: const TextStyle(
                                                    fontFamily: 'InfantBold',
                                                    fontSize: 25,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        }
                      },
                    )
                  ],
                );
              }
            }));
  }
}

import 'package:flutter/material.dart';

import '../../controllers/user_data.dart';

class Courses extends StatefulWidget {
  const Courses({super.key});

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  UserDataController userDataController = UserDataController();
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    loadDocumentIdAndUserData();
  }

  Future<void> loadDocumentIdAndUserData() async {
    await userDataController.loadDocumentId();
    fetchUserData();
  }

  void fetchUserData() async {
    userData = await userDataController.fetchUserData();
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
                      height: 250,
                      padding: const EdgeInsets.only(
                          top: 100, left: 15, right: 15, bottom: 15),
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Offered Courses",
                              style: TextStyle(
                                  fontFamily: 'Millik',
                                  fontSize: 30,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Courses are automatically fetched from your courses database",
                              style: TextStyle(
                                  fontFamily: 'InfantBold',
                                  fontSize: 25,
                                  color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
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
                                  top: 20), // Adjust the top margin as needed
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

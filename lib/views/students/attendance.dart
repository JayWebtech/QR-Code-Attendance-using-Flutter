import 'package:flutter/material.dart';

import '../../controllers/user_data.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
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
                      height: 220,
                      padding: const EdgeInsets.only(
                          top: 100, left: 15, right: 15, bottom: 15),
                      width: MediaQuery.of(context).size.width,
                      child: const Column(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Attendance",
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
                              "All your attendance will display below",
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
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xFFFCFCFC),
                            ),
                            height: MediaQuery.of(context).size.height,
                            padding: const EdgeInsets.only(
                                top: 0, left: 15, right: 15, bottom: 100),
                            margin: const EdgeInsets.only(bottom: 10),
                            width: MediaQuery.of(context).size.width,
                            child: ListView.builder(
                              itemCount: 16,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .white, // Set the background color of the container
                                        borderRadius: BorderRadius.circular(
                                            10), // Set the border radius
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(
                                                0.2), // Adjust the opacity for subtlety
                                            spreadRadius:
                                                1, // Smaller spread radius
                                            blurRadius:
                                                2, // Smaller blur radius
                                            offset: const Offset(
                                                0, 1), // Adjust the offset
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(15),
                                      margin: const EdgeInsets.only(
                                          bottom: 15, left: 5, right: 5),
                                      child: Column(
                                        children: [
                                          Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                                            children: [
                                              Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "MTH 202 ${index}",
                                                      style: const TextStyle(
                                                          fontFamily:
                                                              'InfantBold',
                                                          fontSize: 25,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                  const Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: Text(
                                                      "22/11/2023 - 8:30pm",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'InfantRegular',
                                                          fontSize: 15,
                                                          color: Colors.black),
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              const Icon(
                                                Icons
                                                    .check_circle, // Replace with the desired icon
                                                color: Colors
                                                    .green, // Optionally, set the icon color
                                                size:
                                                    48.0, // Optionally, set the icon size
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                );
                              },
                            )),
                      ),
                    )
                  ],
                );
              }
            }));
  }
}

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
                      height: 305,
                      padding: const EdgeInsets.only(
                          top: 100, left: 15, right: 15, bottom: 5),
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
                                            offset: Offset(
                                                0, 1), // Adjust the offset
                                          ),
                                        ],
                                      ),
                                      padding: const EdgeInsets.all(15),
                                      margin: const EdgeInsets.only(bottom: 15, left:5, right: 5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "MTH 202 ${index}",
                                              style: const TextStyle(
                                                  fontFamily: 'InfantBold',
                                                  fontSize: 25,
                                                  color: Colors.black),
                                            ),
                                          ),
                                          const Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "22/11/2023 - 8:30pm",
                                              style: TextStyle(
                                                  fontFamily: 'InfantRegular',
                                                  fontSize: 15,
                                                  color: Colors.black),
                                            ),
                                          ),
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

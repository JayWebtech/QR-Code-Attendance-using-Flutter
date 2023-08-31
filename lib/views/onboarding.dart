import 'package:attendance/views/getStarted.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: const Color(0xFF115E38),
            padding: const EdgeInsets.all(20),
            child: Padding(
              padding: const EdgeInsets.only(top: 130),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  color: const Color(0xFF115E38),
                  padding: EdgeInsets.zero,
                  child:
                      Image.asset("assets/img/qrcode.png", fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              height: MediaQuery.of(context).size.height * 0.3, //
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'QR Code Attendance',
                    style: TextStyle(
                      fontFamily: 'Millik',
                      fontSize: 30,
                      color: Color(0xFF000000),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Effortlessly track attendance with our QR code scanner. Simplify the process and save time. Just scan and go!',
                    style: TextStyle(
                      fontFamily: 'InfantRegular',
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          int isViewed = 0;
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setInt('onBoard', isViewed);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const TabsScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFF115E38), // Set the button color
                          padding: const EdgeInsets.all(
                              20), // Set the button padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                30), // Set the border radius
                          ),
                        ),
                        child: const Text(
                          'Get Started',
                          style: TextStyle(
                            fontFamily: 'InfantRegular',
                            fontSize: 16,
                          ),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

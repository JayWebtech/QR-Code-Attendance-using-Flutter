// ignore: file_names
import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';
class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final LoginController _controller = LoginController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
          padding: const EdgeInsets.all(25),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/login.png",
                  width: 200,
                  height: 200,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Login Screen',
                  style: TextStyle(fontFamily: 'Millik', fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Enter your email and password to continue 🚀',
                  style: TextStyle(fontFamily: 'InfantRegular', fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                TextFormField(
                  controller:  _controller.regNumberController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Set the border radius
                      borderSide: const BorderSide(
                          color: Colors.grey), // Set the default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Set the border radius
                      borderSide: const BorderSide(
                          color: Color(
                              0xFF115E38)), // Set the focused border color
                    ),
                    hintText: 'Enter a your reg number',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _controller.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Set the border radius
                      borderSide: const BorderSide(
                          color: Colors.grey), // Set the default border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(30), // Set the border radius
                      borderSide: const BorderSide(
                          color: Color(
                              0xFF115E38)), // Set the focused border color
                    ),
                    hintText: 'Enter your password',
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () { _controller.submitForm(context); },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF115E38), // Set the button color
                        padding:
                            const EdgeInsets.all(20), // Set the button padding
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              30), // Set the border radius
                        ),
                      ),
                      child: const Text(
                        'Login',
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
      ),
    );
  }
}

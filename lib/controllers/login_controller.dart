// ignore_for_file: use_build_context_synchronously

import 'package:attendance/views/students/dashboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:m_toast/m_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

ShowMToast toast = ShowMToast();

class LoginController {
  final TextEditingController regNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('students');

  Future<void> submitForm(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress?.show();
    final String regNumber = regNumberController.text.trim();
    final String password = passwordController.text.trim();

    if (regNumber.isEmpty || password.isEmpty) {
      progress?.dismiss();
      toast.errorToast(
        context,
        message: "All fields are required 😉",
        alignment: Alignment.topCenter,
      );
    } else {
      try {
        // Check if the pin and regNumber already exist in the collection
        final QuerySnapshot duplicateSnapshot = await studentsCollection
            .where('pword', isEqualTo: password)
            .where('regno', isEqualTo: regNumber)
            .get();

        if (duplicateSnapshot.docs.isNotEmpty) {
          String documentId = duplicateSnapshot.docs[0].id;
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('documentId', documentId);

          progress?.dismiss();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Dashboard()),
          );
        } else {
          progress?.dismiss();
          toast.errorToast(
            context,
            message: "Wrong login details. Try again 😩",
            alignment: Alignment.topCenter,
          );
        }
      } catch (e) {
        // Handle Firestore-related errors
        progress?.dismiss();
        toast.errorToast(
          context,
          message: "An error occurred. Please try again later. 😩",
          alignment: Alignment.topCenter,
        );
        print("Firestore Error: $e");
      }
    }
  }
}

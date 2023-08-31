// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:m_toast/m_toast.dart';

import '../views/getStarted.dart';

ShowMToast toast = ShowMToast();

class SignupController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pinController = TextEditingController();
  final TextEditingController regNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference studentsCollection =
      FirebaseFirestore.instance.collection('students');

  Future<void> submitForm(BuildContext context) async {
    final progress = ProgressHUD.of(context);
    progress?.show();
    final String name = nameController.text.trim();
    final String pin = pinController.text.trim();
    final String regNumber = regNumberController.text.trim();
    final String password = passwordController.text.trim();

    if (name.isEmpty || pin.isEmpty || regNumber.isEmpty || password.isEmpty) {
      progress?.dismiss();
      toast.errorToast(
        context,
        message: "All fields are required 😉",
        alignment: Alignment.topCenter,
      );
    } else {
      // Check if the pin and regNumber already exist in the collection
      final QuerySnapshot duplicateSnapshot = await studentsCollection
          .where('pin', isEqualTo: pin)
          .where('regno', isEqualTo: regNumber)
          .get();

      if (duplicateSnapshot.docs.isNotEmpty) {
        final DocumentSnapshot duplicateDoc = duplicateSnapshot.docs[0];

        if (duplicateDoc['status'] == "TRUE") {
          progress?.dismiss();
          toast.errorToast(
            context,
            message: "You have already been registered. Please login 😉",
            alignment: Alignment.topCenter,
          );
        } else {
          try {
            // Update the existing document with the name and password fields
            await duplicateDoc.reference
                .update({'name': name, 'pword': password, 'status': 'TRUE'});

            progress?.dismiss();
            toast.successToast(
              context,
              message: "Registrating successful, redirecting to login..🚀🥳",
              alignment: Alignment.topCenter,
            );
            Future.delayed(const Duration(seconds: 1), () {
              // Navigate to the login screen after 5 seconds
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TabsScreen()),
              );
            });
          } catch (error) {
            progress?.dismiss();
            toast.errorToast(
              context,
              message: "Error updating document: $error",
              alignment: Alignment.topCenter,
            );
          }
        }
      } else {
        progress?.dismiss();
        toast.errorToast(
          context,
          message: "Pin and registration number do not exist",
          alignment: Alignment.topCenter,
        );
      }
    }
  }
}

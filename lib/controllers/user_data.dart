import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? documentId;
  UserDataController() {
    loadDocumentId();
  }

  Future<void> loadDocumentId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    documentId = prefs.getString('documentId');
  }

  Future<Map<String, dynamic>?> fetchUserData() async {
    if (documentId == null) {
      return null;
    }

    try {
      DocumentSnapshot userDataSnapshot =
          await firestore.collection('students').doc(documentId).get();

      if (userDataSnapshot.exists) {
        return userDataSnapshot.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print("Firestore Error: $e");
      return null;
    }
  }
}

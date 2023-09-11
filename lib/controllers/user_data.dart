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

  Future<Map<String, String?>?> fetchCoursesByLevel() async {
  if (documentId == null) {
    return null;
  }

  try {
    DocumentSnapshot userDataSnapshot =
        await firestore.collection('students').doc(documentId).get();

    if (userDataSnapshot.exists) {
      Map<String, dynamic> userData = userDataSnapshot.data() as Map<String, dynamic>;
      
      String? level = userData['level'] as String?;
      QuerySnapshot coursesSnapshot = await firestore
          .collection('course')
          .where('level', isEqualTo: level)
          .get();

      if (coursesSnapshot.docs.isNotEmpty) {
        Map<String, String?> coursesMap = {};
        for (var doc in coursesSnapshot.docs) {
          Map<String, dynamic>? courseData = doc.data() as Map<String, dynamic>?;
          if (courseData != null) {
            String? courseName = courseData['course'] as String?;
            if (courseName != null) {
              coursesMap[doc.id] = courseName;
            }
          }
        }
        return coursesMap;
      } else {
        return null;
      }
    } else {
      return null;
    }
  } catch (e) {
    print("Firestore Error: $e");
    return null;
  }
}


}

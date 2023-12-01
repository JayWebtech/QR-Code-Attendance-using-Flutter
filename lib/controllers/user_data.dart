import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
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
        Map<String, dynamic> userData =
            userDataSnapshot.data() as Map<String, dynamic>;

        String? level = userData['level'] as String?;
        QuerySnapshot coursesSnapshot = await firestore
            .collection('course')
            .where('level', isEqualTo: level)
            .get();

        if (coursesSnapshot.docs.isNotEmpty) {
          Map<String, String?> coursesMap = {};
          for (var doc in coursesSnapshot.docs) {
            Map<String, dynamic>? courseData =
                doc.data() as Map<String, dynamic>?;
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

  Future<String> processAttendance(qrCodeResult) async {
    try {
      // Fetch student data using the stored documentId
      DocumentSnapshot studentSnapshot =
          await firestore.collection('students').doc(documentId).get();

      if (!studentSnapshot.exists) {
        // Student data not found
        return "Student data not found";
      }

      // Check the attendance collection for the QR code and status
      QuerySnapshot attendanceSnapshot = await firestore
          .collection('attendance')
          .where('code', isEqualTo: qrCodeResult)
          .where('status', isEqualTo: 'OPEN')
          .get();

      if (attendanceSnapshot.docs.isNotEmpty) {
        // Check for existing attendance with the same regno and code
        QuerySnapshot duplicateAttendanceSnapshot = await firestore
            .collection('student_attendance')
            .where('regno', isEqualTo: studentSnapshot['regno'])
            .where('code', isEqualTo: qrCodeResult)
            .get();

        if (duplicateAttendanceSnapshot.docs.isNotEmpty) {
          return "Duplicate attendance";
        } else {
          final Map<String, String?> studentAttendanceData = {};

          for (var attendanceDoc in attendanceSnapshot.docs) {
            Map<String, dynamic>? attendanceData =
                attendanceDoc.data() as Map<String, dynamic>?;

            if (attendanceData != null) {
              // Extract and add specific fields to studentAttendanceData
              studentAttendanceData['course'] =
                  attendanceData['course'] as String?;
              studentAttendanceData['level'] =
                  attendanceData['level'] as String?;
              studentAttendanceData['email'] =
                  attendanceData['email'] as String?;
              studentAttendanceData['time'] = attendanceData['time'] as String?;
              studentAttendanceData['code'] = qrCodeResult;

              // Fetch the student's registration number
              studentAttendanceData['regno'] =
                  studentSnapshot['regno'] as String?;
              final dynamic dateValue = attendanceData['date'];
              if (dateValue is Timestamp) {
                // Convert Timestamp to DateTime
                DateTime dateTime = dateValue.toDate();

                // Format DateTime to String (change format as needed)
                String formattedDate =
                    DateFormat('yyyy-MM-dd').format(dateTime);

                // Assign the formatted date string to studentAttendanceData['date']
                studentAttendanceData['date'] = formattedDate;
              } else if (dateValue is String) {
                // If 'date' is already a String, directly assign it
                studentAttendanceData['date'] = dateValue;
              }
            }
          }

          // Insert studentAttendanceData into student_attendance collection
          await firestore
              .collection('student_attendance')
              .add(studentAttendanceData);

          return "valid";
        }
      } else {
        return "Invalid attendance code";
      }
    } catch (e) {
      print("Error processing attendance: $e");
    }
    return "Error $qrCodeResult";
  }

  Future<List<Map<String, dynamic>>> fetchStudentAttendance(String regNo) async {
    List<Map<String, dynamic>> studentAttendanceList = [];

    try {
      QuerySnapshot attendanceSnapshot = await FirebaseFirestore.instance
          .collection('student_attendance')
          .where('regno', isEqualTo: regNo)
          .get();

      if (attendanceSnapshot.docs.isNotEmpty) {
        for (var attendanceDoc in attendanceSnapshot.docs) {
          Map<String, dynamic>? attendanceData =
              attendanceDoc.data() as Map<String, dynamic>?;

          if (attendanceData != null) {
            // Add attendance data to the list
            studentAttendanceList.add(attendanceData);
          }
        }
      }
    } catch (e) {
      print('Error fetching student attendance: $e');
    }
    return studentAttendanceList;
  }

}

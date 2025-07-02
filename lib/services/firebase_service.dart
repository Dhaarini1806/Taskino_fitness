import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task.dart';
import '../models/fitness_log.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addTask(Task task) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('tasks')
        .doc(task.id)
        .set(task.toMap());
  }

  Stream<List<Task>> getTasks() {
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('tasks')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Task.fromMap(doc.data())).toList());
  }

  Future<void> deleteTask(String id) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('tasks')
        .doc(id)
        .delete();
  }

  Future<void> addFitnessLog(FitnessLog log) async {
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('fitness_logs')
        .doc(log.id)
        .set(log.toMap());
  }

  Stream<List<FitnessLog>> getWeeklyFitnessLogs() {
    final startOfWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
    return _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .collection('fitness_logs')
        .where('date', isGreaterThanOrEqualTo: startOfWeek)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => FitnessLog.fromMap(doc.data())).toList());
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
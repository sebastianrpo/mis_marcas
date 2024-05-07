import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mis_marcas/models/SwimTimeFirebase.dart';
import '../models/User.dart ' as UserApp;

class FirebaseApi {
  Future<Object?> registerUser(String emailAddress, String password) async {
    try {
      final result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return result.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } catch (e) {
      print("Exception $e");
    }
  }

  Future<Object?> loginUser(String emailAddress, String password) async {
    try {
      final result = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return result.user?.uid;
    } on FirebaseAuthException catch (e) {
      print("FirebaseAuthException ${e.code}");
      return e.code;
    } catch (e) {
      print("Exception $e");
    }
  }

  Future<Object?> createUserInDB(UserApp.User user) async {
    try {
      final document = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .set(user.toJson());
      return user.uid;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }

  Future<Object?> deleteRecord(String id) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("records")
          .doc(id).delete();
      return id;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }
    saveRecord(SwimTimeFirebase swimTime) async {
    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;
      final document = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("records")
          .doc(); //Se crea documento vacío
      swimTime.id = document.id; //Se saca el id del documento
      final result = await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("records")
          .doc(swimTime.id)
          .set(swimTime
              .toJson()); //En ese id se coloca la marca que acabamos de crear
      return document.id;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }
}

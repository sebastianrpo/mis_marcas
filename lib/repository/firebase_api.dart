import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      final document =
      await FirebaseFirestore.instance.collection("users").doc(user.uid).set(
          user.toJson());
      return user.uid;
    } on FirebaseException catch (e) {
      print("FirebaseException ${e.code}");
      return e.code;
    }
  }
}

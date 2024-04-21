import 'package:firebase_auth/firebase_auth.dart';

class FirebaseApi {
  Future<String?> registerUser(String emailAddress, String password) async {
    try {
      final result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return result.user?.uid;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      } else if (e.code == 'invalid-email'){
        print('El correo electrónico es inválido');
      } else if (e.code == 'network-request-failed'){
        print("Revise su conexión a internet");
      }
      return e.code;
    } catch (e) {
      print(e);
    }
  }
}

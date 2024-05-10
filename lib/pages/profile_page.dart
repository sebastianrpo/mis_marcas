import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mis_marcas/pages/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>?>>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("Loading");
            }
            var user = snapshot.data!.data();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Hola ${user?['name']}',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 32,
                  ),
                  Text('Correo eléctronico ${user?['email']}',
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 32,
                  ),
                  ElevatedButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    onPressed: _onCerrarButtonClicked,
                    child: const Text("Cerrar sesión"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _onCerrarButtonClicked() {
    AlertDialog alert = AlertDialog(
      title: const Text("Advertencia"),
      content: const Text("¿Está seguro que desea cerrar sesión?"),
      actions: <Widget>[

        TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancelar')),
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
        ),
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }
}

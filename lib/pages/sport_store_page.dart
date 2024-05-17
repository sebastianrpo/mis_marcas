import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mis_marcas/pages/detail_store_page.dart';

class SportStorePage extends StatefulWidget {
  const SportStorePage({super.key});

  @override
  State<SportStorePage> createState() => _SportStorePageState();
}

class _SportStorePageState extends State<SportStorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("stores").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot store = snapshot.data!.docs[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        store['urlPicture'] ?? "",
                        errorBuilder: (BuildContext context, Object Exception,
                            StackTrace? stackTrace) {
                          return const Image(
                              image: AssetImage('assets/images/logo.png'));
                        },
                      ),
                      title: Text(store['name']),
                      subtitle: Text(store['address']),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => DetailStorePage(store)));
                      },
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}

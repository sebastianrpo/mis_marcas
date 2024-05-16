import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mis_marcas/models/SwimTime.dart';
import 'package:mis_marcas/pages/new_swimming_time_page.dart';
import 'package:mis_marcas/repository/firebase_api.dart';

import '../boxes.dart';

class SwimmingPage extends StatefulWidget {
  const SwimmingPage({super.key});

  @override
  State<SwimmingPage> createState() => _SwimmingPageState();
}

class _SwimmingPageState extends State<SwimmingPage> {
  final FirebaseApi _firebaseApi = FirebaseApi();

  void _addButtonClicked() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NewSwimmingTimePage()));
    });
  }

  Widget _buildListViewFromLocal() {
    return ValueListenableBuilder<Box<SwimTime>>(
      valueListenable: Boxes.getSwimTimeBox().listenable(),
      builder: (context, box, _) {
        final swimTimeBox = box.values.toList().cast<SwimTime>();
        return ListView.builder(
            itemCount: swimTimeBox.length,
            itemBuilder: (BuildContext context, int index) {
              final swimTime = swimTimeBox[index];
              return Card(
                child: ListTile(
                  title: Text(swimTime.toSwim ?? "No swim"),
                  subtitle: Text(swimTime.time ?? "No time"),
                  onLongPress: () {
                    setState(() {
                      swimTime.delete();
                    });
                  },
                ),
              );
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection("records")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) {
                QueryDocumentSnapshot record = snapshot.data!.docs[index];
                return buildCard(record);
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addButtonClicked,
      ),
    );
  }

  InkWell buildCard(QueryDocumentSnapshot record) {
    var heading = record['toSwim'];
    var subheading = record['tournamentName'];
    var supportingText = "Fecha: ${record['dateTournament']}";
    var cardImage = record['urlPicture'] == ""
        ? const AssetImage('assets/images/logo.png') as ImageProvider
        : NetworkImage(record["urlPicture"]);
    return InkWell(
      onTap: () {
        print("clic");
      },
      onLongPress: () {
        print("onLongPress");
        showAlertDialog(context, record);
      },
      child: Card(
        elevation: 4,
        child: Column(
          children: [
            ListTile(
              title: Text(heading),
              subtitle: Text(subheading),
            ),
            Container(
              height: 100,
              width: 100,
              child: Ink.image(image: cardImage),
            ),
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: Text(supportingText),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context, QueryDocumentSnapshot record) {
    AlertDialog alert = AlertDialog(
      title: const Text("Advertencia"),
      content:
          const Text("¿Está seguro que desea eliminar la marca registrada?"),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancelar')),
        TextButton(
          child: const Text('Aceptar'),
          onPressed: () => {
            _firebaseApi.deleteRecord(record.id),
            Navigator.pop(context, 'Aceptar'),
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

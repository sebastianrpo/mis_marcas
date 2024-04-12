import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mis_marcas/models/SwimTime.dart';
import 'package:mis_marcas/pages/new_swimming_time_page.dart';

import '../boxes.dart';

class SwimmingPage extends StatefulWidget {
  const SwimmingPage({super.key});

  @override
  State<SwimmingPage> createState() => _SwimmingPageState();
}

class _SwimmingPageState extends State<SwimmingPage> {
  void _addButtonClicked() {
    setState(() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NewSwimmingTimePage()));
    });
  }

  Widget _buildListView() {
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
                  onLongPress: (){
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
      body: Center(
        child: _buildListView(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addButtonClicked,
      ),
    );
  }
}

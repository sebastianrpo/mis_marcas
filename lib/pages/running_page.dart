import 'package:flutter/material.dart';

class RunningPage extends StatefulWidget {
  const RunningPage({super.key});

  @override
  State<RunningPage> createState() => _RunningPageState();
}

class _RunningPageState extends State<RunningPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Atletismo')),
    );
  }
}

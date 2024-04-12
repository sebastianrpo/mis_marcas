import 'package:flutter/material.dart';

class CyclingPage extends StatefulWidget {
  const CyclingPage({super.key});

  @override
  State<CyclingPage> createState() => _CyclingPageState();
}

class _CyclingPageState extends State<CyclingPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text('Ciclismo')),
    );
  }
}

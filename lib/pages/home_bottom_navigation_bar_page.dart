import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:mis_marcas/pages/cycling_page.dart';
import 'package:mis_marcas/pages/profile_page.dart';
import 'package:mis_marcas/pages/running_page.dart';
import 'package:mis_marcas/pages/swimming_page.dart';

class HomeBottomNavigationBarPage extends StatefulWidget {
  const HomeBottomNavigationBarPage({super.key});

  @override
  State<HomeBottomNavigationBarPage> createState() => _HomeBottomNavigationBarPageState();
}

class _HomeBottomNavigationBarPageState extends State<HomeBottomNavigationBarPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    SwimmingPage(),
    CyclingPage(),
    RunningPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis marcas"),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Image.asset('assets/images/swimming.png'), label: 'Natación', backgroundColor: Colors.redAccent),
          BottomNavigationBarItem(icon: Image.asset('assets/images/cycling.png'), label: 'Ciclismo'),
          BottomNavigationBarItem(icon: Image.asset('assets/images/running.png'), label: 'Atletismo'),
          BottomNavigationBarItem(icon: Image.asset('assets/images/user.png'), label: 'Mi perfil'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

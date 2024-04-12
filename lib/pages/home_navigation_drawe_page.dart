import 'package:flutter/material.dart';

import 'cycling_page.dart';
import 'profile_page.dart';
import 'running_page.dart';
import 'swimming_page.dart';

class HomeNavigationDrawerPage extends StatefulWidget {
  const HomeNavigationDrawerPage({super.key});

  @override
  State<HomeNavigationDrawerPage> createState() =>
      _HomeNavigationDrawerPageState();
}

class _HomeNavigationDrawerPageState extends State<HomeNavigationDrawerPage> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    SwimmingPage(),
    CyclingPage(),
    RunningPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis marcas'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
                decoration: BoxDecoration(color: Colors.redAccent),
                child: Text('Mis marcas header')),
            ListTile(
              leading: Image.asset('assets/images/swimming.png'),
              title: const Text('Natación'),
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Image.asset('assets/images/cycling.png'),
              title: const Text('Ciclismo'),
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Image.asset('assets/images/running.png'),
              title: const Text('Atletismo'),
              onTap: () {
                _onItemTapped(2);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Image.asset('assets/images/user.png'),
              title: const Text('Mi perfil'),
              onTap: () {
                _onItemTapped(3);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

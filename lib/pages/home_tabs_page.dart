import 'package:flutter/material.dart';
import 'package:mis_marcas/pages/cycling_page.dart';
import 'package:mis_marcas/pages/profile_page.dart';
import 'package:mis_marcas/pages/running_page.dart';
import 'package:mis_marcas/pages/swimming_page.dart';

class HomeTabsPage extends StatefulWidget {
  const HomeTabsPage({super.key});

  @override
  State<HomeTabsPage> createState() => _HomeTabsPageState();
}

class _HomeTabsPageState extends State<HomeTabsPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 4,
          child: Scaffold(
              appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Image.asset('assets/images/swimming.png')),
                Tab(icon: Image.asset('assets/images/cycling.png')),
                Tab(icon: Image.asset('assets/images/running.png')),
                Tab(icon: Image.asset('assets/images/user.png')),
              ],
            ),
            title: const Text('Mis marcas'),
          ),
          body: const TabBarView(children: [SwimmingPage(),
          CyclingPage(), RunningPage(), ProfilePage()]),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mis_marcas/pages/login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    _closeSplash();
    super.initState();
  }

  Future<void> _closeSplash() async {
    Future.delayed(const Duration(seconds: 2), () async{
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Center(
                child:
                  Center(
                  child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      width: 250,
                      height: 250,
                    ),
                ),),),);
  }
}
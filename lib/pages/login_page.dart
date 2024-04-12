import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mis_marcas/pages/home_bottom_navigation_bar_page.dart';
import 'package:mis_marcas/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  var _passwordVisible = false;

  User userLoaded = User.Empty();

  void _onLoginButtonClicked() {
    if (_email.text == userLoaded.email &&
        _password.text == userLoaded.password) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeBottomNavigationBarPage()));
    } else {
      _showMsg("Usuario o contraseña incorrectos");
    }
  }

  void _showMsg(String msg) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
            label: 'Aceptar',
            onPressed: () {
              _password.text = "";
            }),
      ),
    );
  }

  getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = jsonDecode(prefs.getString("user")!);
    userLoaded = User.fromJson(userMap);
  }

  @override
  void initState() {
    getUser();
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Image(
                  image: AssetImage('assets/images/logo.png'),
                  width: 200,
                  height: 200,
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  controller: _email,
                  decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                      labelText: 'Correo electrónico'),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  obscureText: !_passwordVisible,
                  controller: _password,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(_passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      border: OutlineInputBorder(),
                      labelText: 'Contraseña'),
                  keyboardType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                ElevatedButton(
                  child: const Text("Iniciar sesión"),
                  onPressed: () {
                    _onLoginButtonClicked();
                  },
                ),
                TextButton(
                    style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            color: Colors.red)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: const Text("Registrarse"))
              ],
            ))));
  }
}

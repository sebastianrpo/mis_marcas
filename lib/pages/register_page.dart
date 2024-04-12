import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mis_marcas/pages/login_page.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Genre { masculino, femenino }

class _RegisterPageState extends State<RegisterPage> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _repPassword = TextEditingController();
  bool _atletismo = false;
  bool _ciclismo = false;
  bool _natacion = false;
  String _fechaNacimiento = "Fecha de nacimiento";
  String genre = "Masculino";

  Genre? _genre = Genre.masculino;

  DateTime _date = DateTime(2024, 28, 02);
  String _bornDate = "";

  String _dateConverter(DateTime newDate) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateFormatted = formatter.format(newDate);
    return dateFormatted;
  }

  void _showSelectedDate() async {
    final DateTime? newDate = await showDatePicker(
        context: context,
        locale: const Locale("es", "CO"),
        initialDate: DateTime(2024, 2),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2024, 3, 15),
        helpText: _fechaNacimiento);

    if (newDate != null) {
      setState(() {
        _bornDate = _dateConverter(newDate);
        _fechaNacimiento = "Fecha de nacimiento: ${_bornDate.toString()}";
      });
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
              _repPassword.text = "";
            }),
      ),
    );
  }

  void _saveUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("user", jsonEncode(user));
  }

  void _onRegisterButtonClicked() {
    setState(() {
      if (_password.text == _repPassword.text) {
        if (_genre == Genre.femenino) {
          genre = "Femenino";
        } else {
          genre = "Masculino";
        }
        var user = User(_name.text, _email.text, _password.text, genre,
            _atletismo, _ciclismo, _natacion, _bornDate);
        _saveUser(user);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
        _showMsg("Usuario registrado exitosamente");
      } else {
        _showMsg("Las contraseñas no son iguales");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Center(
          child: SingleChildScrollView(
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
                    controller: _name,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Nombre'),
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    controller: _email,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Correo electrónico'),
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    controller: _password,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Contraseña'),
                    keyboardType: TextInputType.visiblePassword),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    controller: _repPassword,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Repita la contraseña'),
                    keyboardType: TextInputType.visiblePassword),
                const SizedBox(
                  height: 8.0,
                ),
                const Text(
                  "Seleccione su género",
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          'Masculino',
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Radio<Genre>(
                          value: Genre.masculino,
                          groupValue: _genre,
                          onChanged: (Genre? value) {
                            setState(() {
                              _genre = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          'Femenino',
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Radio<Genre>(
                          value: Genre.femenino,
                          groupValue: _genre,
                          onChanged: (Genre? value) {
                            setState(() {
                              _genre = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const Text(
                  "Deportes favoritos",
                  style: TextStyle(fontSize: 18),
                ),
                CheckboxListTile(
                  title: const Text("Atletismo"),
                  value: _atletismo,
                  selected: _atletismo,
                  onChanged: (bool? value) {
                    setState(() {
                      _atletismo = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text("Ciclismo"),
                  value: _ciclismo,
                  selected: _ciclismo,
                  onChanged: (bool? value) {
                    setState(() {
                      _ciclismo = value!;
                    });
                  },
                ),
                CheckboxListTile(
                  title: const Text("Natación"),
                  value: _natacion,
                  selected: _natacion,
                  onChanged: (bool? value) {
                    setState(() {
                      _natacion = value!;
                    });
                  },
                ),
                ElevatedButton(
                    child: Text(_fechaNacimiento),
                    onPressed: () {
                      _showSelectedDate();
                    }),
                ElevatedButton(
                    onPressed: () {
                      _onRegisterButtonClicked();
                    },
                    child: Text("Registrar")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

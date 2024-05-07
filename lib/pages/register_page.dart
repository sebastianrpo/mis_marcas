import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mis_marcas/pages/login_page.dart';
import 'package:mis_marcas/repository/firebase_api.dart';
import '../models/User.dart ';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

enum Genre { masculino, femenino }

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseApi _firebaseApi = FirebaseApi();
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
        duration: const Duration(seconds: 60),
        action: SnackBarAction(
            label: 'Aceptar',
            onPressed: () {
              scaffold.hideCurrentSnackBar;
              _email.text = "";
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

  void _registerUser(String email, String password) async {
    final result = await _firebaseApi.registerUser(email, password);
    if (result == 'weak-password') {
      _showMsg('La contraseña debe tener más de 6 caracteres.');
    } else if (result == 'email-already-in-use') {
      _showMsg('Esta cuenta de correo ya se encuentra registrada.');
    } else if (result == 'invalid-email') {
      _showMsg('El correo electrónico es inválido');
    } else if (result == 'network-request-failed') {
      _showMsg("Revise su conexión a internet");
    } else {
      createUser(result);
    }
  }

  void createUser(Object? uid) async {
    if (_genre == Genre.femenino) {
      genre = "Femenino";
    } else {
      genre = "Masculino";
    }
    var user = User(uid, _name.text, _email.text, genre, _atletismo, _ciclismo,
        _natacion, _bornDate);
    var result = await _firebaseApi.createUserInDB(user);
    if (result == "network-request-failed") {
      _showMsg("Revise su conexión a internet");
    } else {
      //_saveUser(user);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  void _onRegisterButtonClicked() {
    setState(() {
      if (!_email.text.isValidEmail()) {
        _showMsg("El correo electrónico es inválido");
      } else if (_password.text != _repPassword.text) {
        _showMsg("Las contraseñas no son iguales");
      } else if (_password.text.length < 6) {
        _showMsg("La contraseña debe tener 6 o más caracteres");
      } else {
        _registerUser(_email.text, _password.text);
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
                    child: const Text("Registrar")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

extension on String {
  bool isValidEmail() {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(this);
  }
}

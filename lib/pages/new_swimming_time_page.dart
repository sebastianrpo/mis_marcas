import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mis_marcas/models/SwimTime.dart';
import 'package:mis_marcas/models/SwimTimeFirebase.dart';
import 'package:mis_marcas/repository/firebase_api.dart';
import 'package:image_picker/image_picker.dart';

import '../boxes.dart';

class NewSwimmingTimePage extends StatefulWidget {
  const NewSwimmingTimePage({super.key});

  @override
  State<NewSwimmingTimePage> createState() => _NewSwimmingTimePageState();
}

enum PoolSize { size50, size25 }

class _NewSwimmingTimePageState extends State<NewSwimmingTimePage> {
  final FirebaseApi _firebaseApi = FirebaseApi();
  final _tournamentName = TextEditingController();
  final _toSwim = TextEditingController();
  final _time = TextEditingController();
  String _dateTournamentLabel = "Fecha del torneo";
  String _dateTournament = "";
  PoolSize? _poolSize = PoolSize.size25;
  String _pruebaSeleccionada = "";
  File? image;

  final List<String> _events25mts = [
    '25 Libre',
    '50 Libre',
    '100 Libre',
    '400 Libre',
    '800 Libre',
    '25 Espalda',
    '50 Espalda',
    '100 Espalda',
    '25 Mariposa',
    '50 Mariposa',
    '100 Mariposa',
    '25 Pecho',
    '50 Pecho',
    '100 Pecho',
    '100 Comb. Ind.',
    '200 Comb. Ind.'
  ];

  final List<String> _events50mts = [
    '50 Libre',
    '100 Libre',
    '200 Libre'
        '400 Libre',
    '800 Libre',
    '1500 Libre',
    '50 Espalda',
    '100 Espalda',
    '200 Espalda',
    '50 Mariposa',
    '100 Mariposa',
    '200 Mariposa',
    '50 Pecho',
    '100 Pecho',
    '200 Pecho',
    '200 Comb. Ind.',
    '400 Comb. Ind.'
  ];

  String _dateConverter(DateTime newDate) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String dateFormatted = formatter.format(newDate);
    return dateFormatted;
  }

  void _onRegisterButtonClicked() async {
    var _poolSize = "25 mts";
    if (_poolSize == PoolSize.size50) {
      _poolSize = "50 mts";
    }

    var swimTime = SwimTimeFirebase("", _dateTournament, _poolSize, _time.text,
        _pruebaSeleccionada, _tournamentName.text, "");
    var result = await _firebaseApi.saveRecord(swimTime, image);
    if (result == "network-request-failed") {
      _showMsg("Revise su conexión a internet");
    } else {
      /*var swimTime = SwimTime()
      ..tournamentName = _tournamentName.text
      ..dateTournament = _dateTournament
      ..poolSize = _poolSize
      ..toSwim = _toSwim.text
      ..time = _time.text;

    final box = Boxes.getSwimTimeBox();
    box.add(swimTime);*/

      Navigator.pop(context);
    }
  }

  Future pickImage() async {
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null) return;
      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    }
    on PlatformException catch(e){
      print('Failed to pick image: $e');
    }
  }

  void _showSelectedDate() async {
    final DateTime? newDate = await showDatePicker(
        context: context,
        locale: const Locale("es", "CO"),
        initialDate: DateTime(2024, 3),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2024, 12),
        helpText: _dateTournamentLabel);

    if (newDate != null) {
      setState(() {
        _dateTournament = _dateConverter(newDate);
        _dateTournamentLabel = "Fecha del torneo: $_dateTournament";
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
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Natación"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: 170,
                  child: Stack(
                    children: [
                      image != null
                          ? Image.file(
                              image!,
                              width: 150,
                              height: 150,
                            )
                          : const Image(
                              image:
                                  AssetImage('assets/images/swimminglarge.png'),
                              width: 150,
                              height: 150,
                            ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            alignment: Alignment.bottomLeft,
                            onPressed: () async {
                              pickImage();
                            },
                            icon: const Icon(Icons.camera_alt_outlined, color: Colors.red,),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    controller: _tournamentName,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nombre del torneo'),
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 8.0,
                ),
                ElevatedButton(
                    child: Text(_dateTournamentLabel),
                    onPressed: () {
                      _showSelectedDate();
                    }),
                const Text(
                  "Tamaño de la piscina",
                  style: TextStyle(fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          '25 metros',
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Radio<PoolSize>(
                          value: PoolSize.size25,
                          groupValue: _poolSize,
                          onChanged: (PoolSize? value) {
                            setState(() {
                              _poolSize = value;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text(
                          '50 metros',
                          style: TextStyle(fontSize: 14),
                        ),
                        leading: Radio<PoolSize>(
                          value: PoolSize.size50,
                          groupValue: _poolSize,
                          onChanged: (PoolSize? value) {
                            setState(() {
                              _poolSize = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                if (_poolSize == PoolSize.size25)
                  DropdownMenu<String>(
                    hintText: 'Seleccione la prueba',
                    initialSelection: _events25mts[0],
                    requestFocusOnTap: true,
                    label: const Text('Prueba'),
                    onSelected: (String? event) {
                      setState(() {
                        _pruebaSeleccionada = event!;
                      });
                    },
                    dropdownMenuEntries: _events25mts
                        .map<DropdownMenuEntry<String>>((String event) {
                      return DropdownMenuEntry<String>(
                        value: event,
                        label: event,
                      );
                    }).toList(),
                  )
                else
                  const Text("Seleccionó 50 mts"),
                const SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                    controller: _time,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(), labelText: 'Tiempo'),
                    keyboardType: TextInputType.text),
                ElevatedButton(
                    onPressed: () {
                      _onRegisterButtonClicked();
                    },
                    child: Text("Registrar tiempo")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GenderScreen extends StatefulWidget {
  @override
  _GenderScreenState createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  final _controller = TextEditingController();
  String _gender = "";
  Color _color = Colors.white;
  bool _loading = false;
  final Map<String, String> _genderCache = {};

  void _predictGender() async {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      setState(() {
        _gender = "Introduce un nombre";
        _color = Colors.grey;
      });
      return;
    }

    setState(() {
      _loading = true;
    });

    // Verifica si ya tienes el género almacenado en el caché
    if (_genderCache.containsKey(name)) {
      setState(() {
        _gender = _genderCache[name]!;
        _color = _gender == 'male'
            ? Colors.blue
            : (_gender == 'female' ? Colors.pink : Colors.grey);
        _loading = false;
      });
      return;
    }

    try {
      final response =
          await http.get(Uri.parse('https://api.genderize.io/?name=$name'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _gender = data['gender'] ?? 'unknown';
        _genderCache[name] = _gender; // Almacena el género en el caché
        _color = _gender == 'male'
            ? Colors.blue
            : (_gender == 'female' ? Colors.pink : Colors.grey);
      } else {
        _gender = "Error en la respuesta";
        _color = Colors.red;
      }
    } catch (e) {
      _gender = "Error de conexión";
      _color = Colors.red;
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Extiende el gradiente detrás de la AppBar
      appBar: AppBar(
        title: Text('Predecir Género'),
        backgroundColor: Colors.transparent, // Fondo transparente
        elevation: 0, // Sin sombra
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1E3C72), // Azul oscuro
              Color(0xFF2A5298), // Azul medio
              Color(0xFF8A2BE2), // Violeta acento
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Introduce tu nombre',
                      labelStyle: TextStyle(color: Colors.grey[700]),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _predictGender,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromARGB(255, 231, 231, 231), // Azul medio
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _loading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text('Predecir', style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: _color,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 3,
                          blurRadius: 6,
                          offset: Offset(0, 3), // Desplazamiento de la sombra
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        _gender,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

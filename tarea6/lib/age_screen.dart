import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AgeScreen extends StatefulWidget {
  @override
  _AgeScreenState createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final _controller = TextEditingController();
  String _message = "";
  String _image = "";
  String _ageText = ""; // Variable para almacenar la edad
  bool _loading = false;

  void _determineAge() async {
    final name = _controller.text.trim();
    if (name.isEmpty) {
      setState(() {
        _message = "Introduce un nombre";
        _image = "";
        _ageText = ""; // Reinicia la edad
      });
      return;
    }

    setState(() {
      _loading = true;
      _message = "";
      _image = "";
      _ageText = ""; // Reinicia la edad
    });

    final response =
        await http.get(Uri.parse('https://api.agify.io/?name=$name'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final age = data['age'] ?? 0;

      setState(() {
        _ageText = 'Edad: $age años'; // Establece el texto de la edad

        if (age <= 18) {
          _message = 'Joven';
          _image = 'assets/joven.jpg'; // Imagen relacionada
        } else if (age <= 65) {
          _message = 'Adulto';
          _image = 'assets/adulto.jpg';
        } else {
          _message = 'Anciano';
          _image = 'assets/viejo.jpg';
        }
        _loading = false;
      });
    } else {
      setState(() {
        _message = "Error al obtener la edad";
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar:
          true, // Extiende el gradiente hasta detrás de la AppBar
      appBar: AppBar(
        title: Text('Determinar Edad'),
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
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            elevation: 6, // Sombra más pronunciada
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
                      labelStyle: TextStyle(
                          color: Colors.grey[700]), // Color del texto del label
                      filled: true,
                      fillColor: Colors.grey[200], // Fondo gris claro
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(fontSize: 18, color: Colors.black87),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _determineAge,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Color.fromARGB(255, 202, 202, 202), // Azul medio
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _loading
                        ? CircularProgressIndicator(
                            color: const Color.fromARGB(255, 255, 255, 255),
                          )
                        : Text('Determinar Edad',
                            style: TextStyle(fontSize: 18)),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _ageText, // Mostrar la edad
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E3C72)),
                  ),
                  SizedBox(height: 20),
                  Text(
                    _message,
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8A2BE2)),
                  ),
                  SizedBox(height: 20),
                  _image.isNotEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 3,
                                blurRadius: 6,
                                offset:
                                    Offset(0, 3), // Desplazamiento de la sombra
                              ),
                            ],
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(
                            _image,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Container(), // Contenedor vacío si no hay imagen
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

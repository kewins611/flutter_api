import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final String _apiUrl =
      'https://kinsta.com/wp-json/wp/v2/posts'; // URL de la API de Kinsta
  List<dynamic> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts(); // Llamada a la API al iniciar la pantalla
  }

  Future<void> _fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _posts = data.take(3).toList(); // Mostrar las últimas 3 publicaciones
        });
      } else {
        throw Exception('Error al cargar las publicaciones');
      }
    } catch (e) {
      print('Error: $e'); // Manejo de errores
    }
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Últimas Noticias'),
        backgroundColor: Color.fromARGB(255, 45, 76, 133), // Color de la AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF1E3C72),
              Color(0xFF2A5298),
              Color(0xFF8A2BE2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ), // Aplicar el gradiente al fondo
        padding: EdgeInsets.all(16.0),
        child: _posts.isEmpty
            ? Center(child: CircularProgressIndicator()) // Mostrar cargando
            : ListView.builder(
                itemCount: _posts.length,
                itemBuilder: (context, index) {
                  final post = _posts[index];
                  return Card(
                    color: const Color.fromARGB(255, 255, 255,
                        255), // Color gris para el contenedor de texto
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post['title']['rendered'], // Cambiar a 'rendered'
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(
                                  255, 0, 0, 0), // Color del texto
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            post['excerpt']['rendered'],
                            style: TextStyle(
                                color: const Color.fromARGB(
                                    255, 0, 0, 0)), // Color del texto
                          ), // Cambiar a 'excerpt'
                          SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () => _launchURL(post['link']),
                            child: Text('Visitar noticia'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(
                                  255, 158, 159, 161), // Color del botón
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

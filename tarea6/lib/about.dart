// about.dart
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  // Aquí puedes definir tus variables para mostrar la información
  final String name = "Kewin Sanchez Martinez"; // Cambia esto por tu nombre
  final String matricula = "2022-0169"; // Cambia esto por tu matrícula
  final String tarea =
      "Tool Box App-tarea6"; // Cambia esto por el nombre de tu tarea

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acerca de'),
        // Puedes eliminar el botón de acción aquí
        actions: [],
      ),
      body: Container(
        // Usar un Container para el gradiente
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // Ajusta el tamaño del Card
                  children: [
                    Text(
                      'Tool Box App',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(fontSize: 24), // Aumentar tamaño de texto
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Esta aplicación te proporciona herramientas útiles como:',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 18), // Aumentar tamaño de texto
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text('- Predicción de Género',
                        style: TextStyle(fontSize: 16)),
                    Text('- Determinación de Edad',
                        style: TextStyle(fontSize: 16)),
                    Text('- Información sobre Universidades',
                        style: TextStyle(fontSize: 16)),
                    Text('- Clima', style: TextStyle(fontSize: 16)),
                    Text('- Noticias sobre WordPress',
                        style: TextStyle(fontSize: 16)),
                    SizedBox(height: 20),

                    // Mostrar información estática
                    Text(
                      'Tu Nombre: $name',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 18), // Aumentar tamaño de texto
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Matrícula Universitaria: $matricula',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 18), // Aumentar tamaño de texto
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Nombre de la Tarea: $tarea',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(fontSize: 18), // Aumentar tamaño de texto
                    ),
                    SizedBox(height: 20),

                    // Imagen
                    CircleAvatar(
                      radius:
                          70, // Aumentar el tamaño de la imagen si lo deseas
                      backgroundImage: AssetImage(
                          'assets/mifoto.jpg'), // Asegúrate de que la imagen esté en la carpeta 'assets'
                      backgroundColor: Colors.grey[200], // Color de fondo
                    ),
                    SizedBox(height: 20),

                    ElevatedButton(
                      onPressed: () {
                        // Aquí puedes manejar el evento de regresar
                        Navigator.pop(context);
                      },
                      child: Text('Regresar'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

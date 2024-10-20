import 'package:flutter/material.dart';
import 'gender_screen.dart';
import 'age_screen.dart';
import 'university.dart';
import 'weather_screen.dart';
import 'news_screen.dart';
import 'about.dart';

void main() {
  runApp(ToolBoxApp());
}

class ToolBoxApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tool Box App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.black87, fontSize: 16),
          bodySmall: TextStyle(color: Colors.black54, fontSize: 14),
          headlineMedium: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      home: HomeScreen(),
      routes: {
        '/gender': (context) => GenderScreen(),
        '/age': (context) => AgeScreen(),
        '/universities': (context) => UniversitiesScreen(),
        '/weather': (context) => WeatherScreen(),
        '/news': (context) => NewsScreen(),
        '/about': (context) => AboutScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tool Box App')),
      body: Container(
        // Fondo con gradiente
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              SizedBox(height: 30), // Espacio superior
              SizedBox(
                height: 200, // Cambia esto a tu preferencia
                child: Image.asset(
                  'assets/m1.png', // Asegúrate de colocar la imagen en la carpeta 'assets'
                  fit: BoxFit
                      .contain, // Asegúrate de que la imagen se ajuste dentro del espacio
                ),
              ),
              SizedBox(height: 30), // Espacio después de la imagen
              Text(
                'Bienvenido a la Tool Box App',
                style: Theme.of(context).textTheme.headlineMedium, // Ajustado
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.person,
                      size: 40,
                      color: Color(0xFF8A2BE2)), // Icono en violeta acento
                  title: Text('Predecir Género',
                      style:
                          Theme.of(context).textTheme.bodyMedium), // Ajustado
                  onTap: () => Navigator.pushNamed(context, '/gender'),
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.calendar_today,
                      size: 40,
                      color: Color(0xFF8A2BE2)), // Icono en violeta acento
                  title: Text('Determinar Edad',
                      style:
                          Theme.of(context).textTheme.bodyMedium), // Ajustado
                  onTap: () => Navigator.pushNamed(context, '/age'),
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.school,
                      size: 40,
                      color: Color(0xFF8A2BE2)), // Icono en violeta acento
                  title: Text('Universidades',
                      style:
                          Theme.of(context).textTheme.bodyMedium), // Ajustado
                  onTap: () => Navigator.pushNamed(context, '/universities'),
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.sunny,
                      size: 40,
                      color: Color(0xFF8A2BE2)), // Icono en violeta acento
                  title: Text('Clima',
                      style:
                          Theme.of(context).textTheme.bodyMedium), // Ajustado
                  onTap: () => Navigator.pushNamed(context, '/weather'),
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.wordpress,
                      size: 40,
                      color: Color(0xFF8A2BE2)), // Icono en violeta acento
                  title: Text('paginas con wordpress',
                      style:
                          Theme.of(context).textTheme.bodyMedium), // Ajustado
                  onTap: () => Navigator.pushNamed(context, '/news'),
                ),
              ),
              SizedBox(height: 10),
              Card(
                elevation: 4,
                child: ListTile(
                  leading: Icon(Icons.info,
                      size: 40,
                      color: Color(0xFF8A2BE2)), // Icono en violeta acento
                  title: Text('Acerca',
                      style:
                          Theme.of(context).textTheme.bodyMedium), // Ajustado
                  onTap: () => Navigator.pushNamed(context, '/about'),
                ),
              ),
              // Otras tarjetas...
            ],
          ),
        ),
      ),
    );
  }
}

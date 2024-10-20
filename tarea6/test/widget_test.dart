import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tarea6/main.dart'; // Asegúrate de que la ruta sea correcta.

void main() {
  testWidgets('Verifica que se muestre el texto y la imagen',
      (WidgetTester tester) async {
    // Construye la aplicación.
    await tester.pumpWidget(MaterialApp(home: HomeScreen()));

    // Verifica que el texto "Esta aplicación ofrece varias herramientas" esté presente.
    expect(find.text('Esta aplicación ofrece varias herramientas'),
        findsOneWidget);

    // Verifica que la imagen esté presente. Aquí estamos verificando si hay una imagen en la pantalla.
    expect(find.byType(Image), findsOneWidget);
  });
}

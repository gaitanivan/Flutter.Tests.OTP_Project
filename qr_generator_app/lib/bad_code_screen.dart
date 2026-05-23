import 'package:flutter/material.dart';

class BadCodeScreen extends StatelessWidget {
	final String insertedCode;
	
	const BadCodeScreen(this.insertedCode,  {super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.red.shade50, // Fondo rojo sutil
			body: Center(
				child: Padding(
					padding: const EdgeInsets.all(24.0),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							const Icon(Icons.error_outline, size: 100, color: Colors.red),
							const SizedBox(height: 20),
							const Text(
								'Código Inválido',
								style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
							),
							const SizedBox(height: 10),
							Text(
								'El código ha expirado o es incorrecto ($insertedCode). Por favor, verifica tu aplicación autenticadora.',
								textAlign: TextAlign.center,
								style: TextStyle(fontSize: 16, color: Colors.black54),
							),
							const SizedBox(height: 40),
							ElevatedButton.icon(
								style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
								onPressed: () {
									Navigator.of(context).pop(); // Volver atrás
								},
								icon: const Icon(Icons.refresh, color: Colors.white),
								label: const Text('Intentar de Nuevo', style: TextStyle(color: Colors.white)),
							),
						],
					),
				),
			),
		);
	}
}
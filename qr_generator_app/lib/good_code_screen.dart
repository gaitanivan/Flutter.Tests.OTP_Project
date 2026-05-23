import 'package:flutter/material.dart';

class GoodCodeScreen extends StatelessWidget {
	final String insertedCode;
	
	const GoodCodeScreen(this.insertedCode, {super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: Colors.green.shade50, // Fondo verde sutil
			body: Center(
				child: Padding(
					padding: const EdgeInsets.all(24.0),
					child: Column(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
							const Icon(Icons.check_circle_outline, size: 100, color: Colors.green),
							const SizedBox(height: 20),
							const Text(
								'¡Validación Correcta!',
								style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
							),
							const SizedBox(height: 10),
							Text(
								'El código OTP introducido ($insertedCode) es válido y el acceso ha sido autorizado.',
								textAlign: TextAlign.center,
								style: TextStyle(fontSize: 16, color: Colors.black54),
							),
							const SizedBox(height: 40),
							ElevatedButton.icon(
								style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
								onPressed: () {
									// Volver a la pantalla anterior.
									Navigator.of(context).pop();
								},
								icon: const Icon(Icons.arrow_back, color: Colors.white),
								label: const Text('Volver a Intentar', style: TextStyle(color: Colors.white)),
							),
						],
					),
				),
			),
		);
	}
}
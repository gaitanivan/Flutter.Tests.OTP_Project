import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp/otp.dart';
import 'package:qr_generator_app/good_code_screen.dart';
import 'package:qr_generator_app/bad_code_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
	runApp(MainApp());
}

// ==============================================================================
// Clase inicial de la aplicación.
class MainApp extends StatelessWidget {
	MainApp({super.key});

	final AuthCodeTextField _authCodeTextField = AuthCodeTextField();

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: Scaffold(
				body: Container(
					margin: EdgeInsets.all(10),
					child: Column(
						spacing: 10,
						children: [
							// Texto con detalles e instrucciones de funcionamiento.
							const ExpansionTile(
								backgroundColor: Color.fromARGB(255, 240, 240, 240),
								collapsedBackgroundColor:  Color.fromARGB(255, 240, 240, 240),
								controlAffinity: .leading,
								title: 
									Text(
										"Detalles",
										style: TextStyle(
											fontWeight: .bold
										)
									),
								children: [
									Text(
										"Aplicación creada en Flutter para probar el funcionamiento de la librería OTP.\n"
										"Use una aplicación autenticadora (Google Auth, Microsoft Authenticator...) para escanear el código QR y agregar la cuenta de pruebas.\n"
										"En la cuenta creada es su aplicación de autenticación, podrá ver el código de 6 dígitos que cambian cada 30 segundos, escriba ese código en el cuadro de texto abajo y haga clic en el botón Validar.\n"
										"Verá los mensajes de validación correspondientes."
									)
								]
							),

							// Texto que indica para que sirve el QR.
							const Text(
								"QR Code para la cuenta prueba@correo.com en MiApp",
								textAlign: .center,
								style: TextStyle(
									fontSize: 30,
									fontWeight: .bold
								),
							),

							// Widget que muestra el código QR.
							QrImageView(
								data: 'otpauth://totp/MiApp:prueba@correo.com?secret=NBSWY3DPEB3W64TBNQ&issuer=MiApp',
								version: QrVersions.auto,
								size: 200.0,
							),

							// Una fila para mostrar una etiqueta y el campo para escribir.
							Row(
								spacing: 10,
								children: [
									const Text(
										"Código de 6 dígitos:",
										style: TextStyle(
											fontWeight: .bold
										)
									),
									Expanded(
										child: _authCodeTextField
									)
								],
							),

							// Botón para validar el código ingresado.
							AuthValidateButton(_authCodeTextField)
						],
					),
				),
			),
		);
	}
}
// ==============================================================================


// ==============================================================================
// Clase para tener acceso al control en que se lee el código a validar.
class AuthCodeTextField extends StatefulWidget {
	AuthCodeTextField({super.key});

	final TextEditingController codeController = TextEditingController();
	final FocusNode codeFocus = FocusNode();

	@override
	State<StatefulWidget> createState() {
		return _AuthCodeTextFieldState();
	}
}

// Clase para el estado de la clase AuthCodeTextField.
class _AuthCodeTextFieldState extends State<AuthCodeTextField> {
	@override
	void dispose() {
		widget.codeController.dispose();
		widget.codeFocus.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context) {
		return TextField(
			controller: widget.codeController,
			focusNode: widget.codeFocus,
			keyboardType: .number,
			maxLength: 7,
			inputFormatters: [
				FilteringTextInputFormatter.digitsOnly,
				CodeInputFormatter()
			],
		);
	}
}

// Clase para formatear la entrada de texto.
class CodeInputFormatter extends TextInputFormatter {
	@override
	TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
		// 1. Quitamos cualquier espacio que ya exista para trabajar con los números puros
		final text = newValue.text.replaceAll(' ', '');

		final buffer = StringBuffer();
		for (int i = 0; i < text.length; i++) {
			buffer.write(text[i]);
			// 2. Si vamos en la tercera posición (índice 2) y vienen más números, metemos un espacio
			if (i == 2 && text.length > 3) {
				buffer.write(' '); 
			}
		}

		final string = buffer.toString();
		return newValue.copyWith(
			text: string,
			// 3. Esto mantiene el cursor siempre al final del texto
			selection: TextSelection.collapsed(offset: string.length),
		);
	}
}
// ==============================================================================


// ==============================================================================
// Clase en la que se define el botón que validará un código.
class AuthValidateButton extends StatefulWidget {
	const AuthValidateButton(this.codeField, {super.key});

	final AuthCodeTextField codeField;

	@override
	State<AuthValidateButton> createState() {
		return _AuthValidateButtonState();
	}
}

// Clase para el estado de la clase AuthValidateButton.
class _AuthValidateButtonState extends State<AuthValidateButton> {
	@override
	Widget build(BuildContext context) {
		return ElevatedButton(
			onPressed: () {
				// Limpiar el espacio en blanco que agrega el formateador visual.
				String originalCode = widget.codeField.codeController.text;
				String typedCode = originalCode.replaceAll(' ', '');

				// Validar que se hallan escrito los 6 npumeros del código.
				if (typedCode.length != 6) {
					// Reproducir un pequeño sonido de alerta.
					SystemSound.play(.alert);
					// Mostrar mensaje al usuario.
					showDialog(
						barrierDismissible: false,
						context: context,
						builder: (BuildContext bContext) {
							return AlertDialog(
								// El título es el encabezado del mensje.
								title: const Row(
									spacing: 30,
									children: [
										Icon(
											Icons.warning_rounded,
											color: Colors.deepOrange,
											size: 30,
										),
										Text(
											"¡Advertencia!",
											textAlign: .center
										)
									],
								),

								// Contenido del cuadro de dialogo.
								content: const Column(
									mainAxisSize: .min,
									spacing: 20,
									children: [
										Divider(),
										Text("Por favor, ingresar los 6 dígitos completos."),
										Divider()
									]
								),

								// Mostrar botón para cerrar el cuadro de dialogo.
								actions: [
									FilledButton(
										onPressed: () {
											Navigator.of(bContext).pop();
											widget.codeField.codeFocus.requestFocus();
										},
										child: const Text("OK")
									)
								],
							);
						}
					);
					return;
				}

				int tiempoActual = DateTime.now().millisecondsSinceEpoch;
				
				// Generar el código del ciclo ACTUAL (0 segundos)
				String codigoActual = OTP.generateTOTPCodeString(
					'NBSWY3DPEB3W64TBNQ',
					tiempoActual,
					length: 6,
					interval: 30,
					algorithm: Algorithm.SHA1,
					isGoogle: true
				);

				// Comparar con el código obtenido.
				if (typedCode == codigoActual) {
					Navigator.of(context).push(
						MaterialPageRoute(builder: (context) => GoodCodeScreen(originalCode)),
					);
				} else {
					Navigator.of(context).push(
						MaterialPageRoute(builder: (context) => BadCodeScreen(originalCode)),
					);
				}
			},
			child: const Text("Validar Código")
		);
	}
}
// ==============================================================================
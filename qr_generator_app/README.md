# QR GEN-APP 📱🔴

**QR GEN-APP** es una aplicación multiplataforma (Windows, Android, Web) desarrollada con **Flutter** que funciona como el primer módulo del ecosistema de seguridad OTP. Su función actual es renderizar un código QR de prueba estructurado para la autenticación de dos factores (2FA).

## 🚀 Sobre el Proyecto
Este proyecto provee la interfaz base para validar la generación de un código QR estático de prueba. Al ser escaneado por aplicaciones autenticadoras estándar (como Microsoft Authenticator o Google Authenticator), permite verificar la correcta vinculación del secreto y la sincronización del token de identidad de 6 dígitos.

## 📱 Vista Previa
<p align="center">
  <img src="Screenshots/Splash.png" width="30%" title="Splash Screen Red">
  <img src="Screenshots/Home.png" width="30%" title="Generador de QR">
</p>

## ✨ Características actuales
* **Renderizado de QR de prueba:** Dibujo del código QR basado en una cadena de texto/secreto de prueba compatible con el estándar TOTP.
* **Estructura Multi-App:** Configurado dentro de un monorepositorio para coexistir con el desarrollo de la futura aplicación autenticadora propia.
* **Manejo de Caché:** Control del crecimiento de datos locales derivado del uso de paquetes de personalización de interfaz.

## 🛠️ Tecnologías utilizadas
* **IDE:** VS Code (con las extensiones oficiales de Flutter y Dart)
* **Lenguaje:** Dart 3.11.5
* **Framework:** Flutter 3.41.9 (Canal Stable)
* **Librerías clave:**
    * `otp: ^3.2.0`: Para la estructuración y validación del formato de los parámetros del secreto (URI) bajo el estándar TOTP.
    * `qr_flutter: ^4.1.0`: Para el renderizado y dibujo del código QR en pantalla.
    * `flutter_native_splash: ^4.2.7` *(dev_dependencies)*: Para la inyección del splash screen nativo.
    * `flutter_launcher_icons: ^0.14.4` *(dev_dependencies)*: Para la gestión automatizada de los iconos adaptativos de la aplicación.

## ⚖️ Licencia y Atribuciones
Este proyecto se distribuye bajo la Licencia **MIT**. Se permite el uso, modificación y distribución de este software de forma libre. Para obtener más detalles sobre las licencias de componentes de código abierto integrados y recursos gráficos de Microsoft, se puede consultar el archivo:
👉 `THIRD-PARTY-NOTICES.md`

## 🤖 Créditos
Desarrollado con el apoyo de **Google Gemini** como asistente en la depuración de código, configuración de entornos y optimización del repositorio.

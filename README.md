# panamericanos-frontend
🎨 panamericanos-frontend

Aplicación Flutter para la gestión logística de transporte, equipos y rutas — Juegos Panamericanos 2027

[![Flutter](https://img.shields.io/badge/Flutter-3.x-blue)]()
[![Dart](https://img.shields.io/badge/Dart-stable-blue)]()
[![Estado](https://img.shields.io/badge/status-En%20desarrollo-yellow)]()
[![Plataformas](https://img.shields.io/badge/Android-iOS%20%7C%20Web-success)]()


📌 Descripción General

Este proyecto corresponde a la aplicación Flutter utilizada para la gestión operativa del transporte y delegaciones durante los Juegos Panamericanos 2027.

La app es multiplataforma:
✔ Android
✔ iOS
✔ Web (Chrome, Edge, etc.)

Está conectada al backend oficial desarrollado en Spring Boot 3 + WebFlux, consumiendo APIs REST para administrar buses, equipos, asignaciones, transportistas y más.

🚀 Tecnologías Principales
  
    Tecnología	Uso
      Flutter 3.x	Framework principal
      Dart	Lenguaje de programación
      Dio / Http	Consumo de APIs REST
      Provider / Riverpod / Bloc	Administración de estado (según arquitectura elegida)
      QR / Barcode	Visualización de códigos para buses
      Image Picker	Subida de fotos desde cámara/galería
🧩 Módulos y Pantallas

    🚍 Gestión de Buses
    
      -Listar buses con filtros.
    
      -Crear / editar / eliminar bus.
    
      -Ver QR del bus.
    
      -Subir fotos desde cámara o galería.

  
    🏆 Gestión de Equipos Deportivos
      
      -Registro de equipos.
      
      -Asociación de equipo con un deporte.
      
      -Listado general.

    
    🚚 Gestión de Transportistas
      
      -Registro de transportistas.
      
      -Visualización de buses asignados.

    
    🛣️ Asignación de Rutas
      
      -Crear rutas.
      
      -Selección de bus + equipo + transportista.
      
      -Vista de rutas activas.

    
    🔐 Autenticación (en roadmap)
      
      -Headers obligatorios según backend.
      
      -Token para seguridad.

🧱 Arquitectura Recomendada del Proyecto
   
      /lib
        /config            → URLs, constantes, estilos
        /models            → DTOs y entidades
        /services          → Clientes HTTP (Dio / Http)
        /providers         → Estado (Provider/Riverpod)
        /pages
          /bus
            bus_list_page.dart
            bus_form_page.dart
            bus_qr_page.dart
          /equipo
            equipo_list_page.dart
            equipo_form_page.dart
          /transportista
            transportista_list_page.dart
            transportista_form_page.dart
          /asignacion
            asignacion_list_page.dart
            asignacion_form_page.dart
        /widgets           → Componentes reutilizables
        main.dart


✔ Modular
✔ Escalable
✔ Fácil de mantener

🛠️ Cómo Ejecutar el Proyecto
📱 Android
    flutter run -d android

🍎 iOS
    flutter run -d ios


(requiere MacOS + Xcode)

🌐 Web (Chrome u otro navegador)
    flutter run -d chrome

🔧 Mostrar dispositivos disponibles
    flutter devices

🔗 Conexión con el Backend

Configurar la URL base en un archivo como:

/lib/config/api_config.dart

    class ApiConfig {
      static const String baseUrl = "http://localhost:8080"; 
      // o la URL de tu backend en la nube
    }

📦 Variables y Entorno

Puedes crear un archivo .env (si usas flutter_dotenv):

    API_URL=https://tudominio-backend.com

🧪 Pruebas

Soporte para pruebas unitarias y widget tests:

    flutter test

🛤️ Roadmap

     Autenticación completa con backend
    
     Mejorar estilo con Material 3
    
     Dashboard general para operaciones
    
     Mapa y geolocalización de buses
    
     Notificaciones push
    
     Offline mode para zonas sin internet

👨‍💻 Autor

Rainier Carbajal
Software Engineer — Cloud & Microservices Architect
GitHub: https://github.com/raiszbook

🏁 Estado del Proyecto

🚧 En desarrollo — versión inicial del Frontend panamericano.

Comandos de build para tu sección “Cómo ejecutar / build”

### 📱 Build Android (APK debug)
```bash
flutter build apk
```


### 📱 Build Android (AppBundle para Play Store)
```bash
flutter build appbundle



### 📱 Build Web
```bash
flutter build web



### 📱 Build Tests
```bash
flutter test







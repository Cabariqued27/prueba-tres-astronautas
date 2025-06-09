# 🚀 Tres Astronautas

Aplicación Flutter como prueba técnica para explorar los planetas del sistema solar. Los usuarios pueden ver detalles de cada planeta, incluyendo imágenes, datos científicos y marcarlos como favoritos localmente.

---

## 🛠️ Tecnologías utilizadas

- **Flutter 3.32.0** (gestionado con FVM)
- **Riverpod** para el manejo de estado
- **GoRouter** para navegación declarativa
- **Hive** para almacenamiento local
- Diseño **responsive** que se adapta a distintos tamaños de pantalla
- Arquitectura en capas: UI, controladores, servicios y modelos

---

## 📦 Instalación

Este proyecto utiliza [FVM (Flutter Version Management)](https://fvm.app/) para mantener una versión consistente de Flutter entre desarrolladores.

### 1. Instalar FVM

Primero, asegúrate de tener Dart instalado y luego instala FVM con:

```bash
dart pub global activate fvm
```

### 2. Clonar este repositorio

```bash
git clone https://github.com/Cabariqued27/tres_astronautas.git
cd tres_astronautas
```

### 3. Instalar la versión de Flutter definida en el proyecto

```bash
fvm install
```

### 4. Usar la versión instalada

```bash
fvm use
```

Esto asegurará que estás usando la misma versión que el resto del equipo.

### 5. Instalar las dependencias

```bash
fvm flutter pub get
```

### 6. Ejecutar la aplicación

```bash
fvm flutter run
```

> ✅ Asegúrate de ejecutar todos los comandos de Flutter usando `fvm flutter` para mantener la versión correcta.

---

## 🌐 API usada

Los datos de los planetas se obtienen de:

```
https://us-central1-a-academia-espacial.cloudfunctions.net/planets
```

---

## 📁 Estructura del Proyecto

```
lib/
├── core/            # Servicios generales (PlanetService, etc.)
├── data/            # Modelos de datos
├── features/        # UI y controladores por dominio
│   └── planets/
├── utils/           # Utilidades reutilizables (Responsive, etc.)
└── main.dart        # Punto de entrada
```

---

## 💡 Decisiones técnicas

- El uso de **Riverpod** permite desacoplar la lógica de negocio de la UI de forma reactiva.
- Se eligió **Hive** por su facilidad de uso para almacenar favoritos sin necesidad de una base de datos compleja.
- La navegación con **GoRouter** permite manejo simple de rutas dinámicas (por ejemplo: `/planets/mars`).
- El diseño **responsive** se maneja con un widget personalizado `Resizer` para adaptar el contenido según el ancho de pantalla.

---

## 📌 Versión Flutter

Este proyecto usa:

```
Flutter 3.32.0 (definido en .fvm/fvm_config.json)
```

---

## 📄 Licencia

Este es un proyecto de código abierto como parte de una prueba técnica. Puedes usarlo, modificarlo y distribuirlo libremente con los debidos créditos.

---

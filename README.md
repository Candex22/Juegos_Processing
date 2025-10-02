# 🎮 Colección de Juegos en Processing

Dos juegos clásicos implementados en Processing: **Ta-Te-Ti** (Tres en Línea) y **Pong 3D**.

---

## 📋 Requisitos

- [Processing](https://processing.org/download) 3.0 o superior

---

## 🎯 Ta-Te-Ti

Implementación clásica del juego de tres en línea (Tic-Tac-Toe) con interfaz gráfica.

### Características
- Tablero 3×3 interactivo
- Turnos alternados entre X y O
- Detección automática de victoria o empate
- Línea verde que marca la combinación ganadora
- Botón de reinicio al finalizar cada partida
- Interfaz visual clara con colores diferenciados

### Cómo Jugar
1. Abre el archivo `Tateti/Tateti.pde` en Processing
2. Ejecuta el sketch (Ctrl+R o botón ▶)
3. Haz clic en cualquier casilla vacía para colocar tu ficha
4. Gana el primero que logre tres en línea (horizontal, vertical o diagonal)
5. Al terminar, usa el botón "REINICIAR" para jugar otra vez

### Controles
- **Clic izquierdo**: Colocar ficha en casilla vacía
- **Botón REINICIAR**: Comenzar nueva partida (aparece al terminar)

---

## 🏓 Pong 3D

Versión tridimensional del clásico Pong con efectos visuales y físicas mejoradas.

### Características
- Gráficos 3D con iluminación dinámica
- Física realista con aceleración progresiva de la pelota
- Efectos visuales de brillo en pelota y raquetas
- Sistema de puntuación
- Controles para dos jugadores
- Pantalla de inicio

### Cómo Jugar
1. Abre el archivo `pong/pong.pde` en Processing
2. Ejecuta el sketch (Ctrl+R o botón ▶)
3. Presiona **ESPACIO** para comenzar
4. Cada jugador controla su raqueta para evitar que la pelota pase
5. Ganas punto cuando la pelota pasa al lado contrario

### Controles
#### Jugador 1 (Izquierda)
- **W**: Mover raqueta hacia arriba
- **S**: Mover raqueta hacia abajo

#### Jugador 2 (Derecha)
- **↑**: Mover raqueta hacia arriba
- **↓**: Mover raqueta hacia abajo

#### Generales
- **ESPACIO**: Iniciar juego
- **R**: Reiniciar puntuación

---

## 🛠️ Instalación

1. Descarga e instala [Processing](https://processing.org/download)
2. Clona o descarga este repositorio
3. Abre cada carpeta como un sketch de Processing
4. Ejecuta cualquiera de los juegos

---

## 📁 Estructura del Proyecto

```
.
├── Tateti/
│   └── Tateti.pde          # Juego de Ta-Te-Ti
├── pong/
│   └── pong.pde            # Juego de Pong 3D
├── LICENSE
└── README.md               
```

---

## 🎨 Detalles Técnicos

### Ta-Te-Ti
- Resolución: 400×450 píxeles
- Matriz de estado 3×3
- Detección de victoria en filas, columnas y diagonales
- Sistema de turnos booleano

### Pong 3D
- Resolución: 800×600 píxeles
- Renderizado 3D (P3D)
- Sistema de iluminación con spotlights
- Física de colisión con ángulo variable
- Aceleración progresiva (1.05× por rebote)

---

## ✨ Créditos

Desarrollado con Processing - [processing.org](https://processing.org)

PVector ballPos, ballSpeed;
float ballRadius = 15;
PVector paddle1Pos, paddle2Pos;
float paddleWidth = 15, paddleHeight = 80, paddleDepth = 15;
float paddleSpeed = 8;
int score1 = 0, score2 = 0;
boolean gameStarted = false;

void setup() {
  size(800, 600, P3D);
  textAlign(CENTER, CENTER);
  resetBall();
  paddle1Pos = new PVector(30, height / 2, 0);
  paddle2Pos = new PVector(width - 30, height / 2, 0);
}

void draw() {
  background(20, 20, 40);
  setupLights();
  
  if (!gameStarted) {
    drawStartScreen();
    return;
  }
  
  // Mover pelota
  ballPos.add(ballSpeed);
  
  // Colisiones con paredes superior e inferior
  if (ballPos.y - ballRadius < 0 || ballPos.y + ballRadius > height) {
    ballSpeed.y *= -1;
    ballPos.y = constrain(ballPos.y, ballRadius, height - ballRadius);
  }
  
  // Colisión con raqueta izquierda (Jugador 1)
  if (ballPos.x - ballRadius < paddle1Pos.x + paddleWidth/2 &&
      ballPos.x + ballRadius > paddle1Pos.x - paddleWidth/2 &&
      ballPos.y > paddle1Pos.y - paddleHeight/2 &&
      ballPos.y < paddle1Pos.y + paddleHeight/2) {
    ballSpeed.x = abs(ballSpeed.x);
    ballSpeed.x *= 1.05; // Incrementar velocidad
    float hitPos = (ballPos.y - paddle1Pos.y) / paddleHeight;
    ballSpeed.y += hitPos * 3;
  }
  
  // Colisión con raqueta derecha (Jugador 2)
  if (ballPos.x + ballRadius > paddle2Pos.x - paddleWidth/2 &&
      ballPos.x - ballRadius < paddle2Pos.x + paddleWidth/2 &&
      ballPos.y > paddle2Pos.y - paddleHeight/2 &&
      ballPos.y < paddle2Pos.y + paddleHeight/2) {
    ballSpeed.x = -abs(ballSpeed.x);
    ballSpeed.x *= 1.05;
    float hitPos = (ballPos.y - paddle2Pos.y) / paddleHeight;
    ballSpeed.y += hitPos * 3;
  }
  
  // Puntos: si la pelota sale por los lados
  if (ballPos.x < 0) {
    score2++;
    resetBall();
  }
  if (ballPos.x > width) {
    score1++;
    resetBall();
  }
  
  // Control de raquetas
  controlPaddles();
  
  // Dibujar todo
  drawField();
  drawPaddle(paddle1Pos);
  drawPaddle(paddle2Pos);
  drawBall();
  drawScore();
  drawInstructions();
}

void setupLights() {
  lights();
  ambientLight(50, 50, 50);
  pointLight(255, 255, 255, width/2, height/2, 200);
  spotLight(150, 200, 255, ballPos.x, ballPos.y, 100, 0, 0, -1, PI/4, 2);
}

void drawField() {
  // Línea central
  pushMatrix();
  translate(width/2, height/2, -50);
  fill(100, 150, 200, 50);
  noStroke();
  box(5, height, 5);
  popMatrix();
  
  // Bordes superior e inferior
  stroke(100, 150, 200);
  strokeWeight(2);
  line(0, 10, 0, width, 10, 0);
  line(0, height-10, 0, width, height-10, 0);
}

void drawPaddle(PVector pos) {
  pushMatrix();
  translate(pos.x, pos.y, pos.z);
  fill(100, 255, 100);
  noStroke();
  box(paddleWidth, paddleHeight, paddleDepth);
  
  // Efecto de brillo
  fill(150, 255, 150, 100);
  box(paddleWidth + 2, paddleHeight + 2, paddleDepth + 2);
  popMatrix();
}

void drawBall() {
  pushMatrix();
  translate(ballPos.x, ballPos.y, ballPos.z);
  
  // Rotación para efecto visual
  rotateX(frameCount * 0.05);
  rotateY(frameCount * 0.07);
  
  fill(255, 100, 100);
  noStroke();
  sphere(ballRadius);
  
  // Efecto de brillo
  fill(255, 150, 150, 80);
  sphere(ballRadius + 3);
  popMatrix();
}

void drawScore() {
  // Dibujar puntuación en 2D
  camera();
  hint(DISABLE_DEPTH_TEST);
  
  fill(255);
  textSize(48);
  text(score1, width/4, 50);
  text(score2, 3*width/4, 50);
  
  hint(ENABLE_DEPTH_TEST);
  perspective();
}

void drawInstructions() {
  camera();
  hint(DISABLE_DEPTH_TEST);
  
  fill(200);
  textSize(14);
  text("Jugador 1: W/S", 80, height - 20);
  text("Jugador 2: ↑/↓", width - 80, height - 20);
  
  hint(ENABLE_DEPTH_TEST);
  perspective();
}

void drawStartScreen() {
  camera();
  fill(255);
  textSize(48);
  text("PADDLE 3D", width/2, height/2 - 50);
  textSize(24);
  text("Presiona ESPACIO para comenzar", width/2, height/2 + 20);
  textSize(16);
  text("Jugador 1: W/S  |  Jugador 2: ↑/↓", width/2, height/2 + 60);
}

void controlPaddles() {
  // Jugador 1 (W/S)
  if (keyPressed) {
    if (key == 'w' || key == 'W') {
      paddle1Pos.y -= paddleSpeed;
    }
    if (key == 's' || key == 'S') {
      paddle1Pos.y += paddleSpeed;
    }
    
    // Jugador 2 (Flechas)
    if (keyCode == UP) {
      paddle2Pos.y -= paddleSpeed;
    }
    if (keyCode == DOWN) {
      paddle2Pos.y += paddleSpeed;
    }
  }
  
  // Limitar movimiento de raquetas
  paddle1Pos.y = constrain(paddle1Pos.y, paddleHeight/2, height - paddleHeight/2);
  paddle2Pos.y = constrain(paddle2Pos.y, paddleHeight/2, height - paddleHeight/2);
}

void resetBall() {
  ballPos = new PVector(width / 2, height / 2, 0);
  float angle = random(-PI/4, PI/4);
  float direction = random(1) > 0.5 ? 1 : -1;
  ballSpeed = new PVector(4 * direction, 2 * sin(angle), 0);
}

void keyPressed() {
  if (key == ' ' && !gameStarted) {
    gameStarted = true;
  }
  
  // Reiniciar juego con R
  if (key == 'r' || key == 'R') {
    score1 = 0;
    score2 = 0;
    resetBall();
  }
}

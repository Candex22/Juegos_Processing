int[][] board = new int[3][3];
boolean xTurn = true;
boolean gameEnded = false;
String winner = "";
int winCol = -1, winRow = -1; // Para línea ganadora
int winType = -1; // 0=fila, 1=columna, 2=diag principal, 3=diag secundaria

void setup() {
  size(400, 450);
  textAlign(CENTER, CENTER);
  textSize(20);
  resetGame();
}

void draw() {
  background(240);
  drawBoard();
  drawPieces();
  checkWin();
  displayInfo();
  drawResetButton();
}

void resetGame() {
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      board[i][j] = 0;
    }
  }
  xTurn = true;
  gameEnded = false;
  winner = "";
  winCol = -1;
  winRow = -1;
  winType = -1;
}

void drawBoard() {
  stroke(50);
  strokeWeight(3);
  for (int i = 1; i < 3; i++) {
    line(i * 133.33, 50, i * 133.33, 450);
    line(0, 50 + i * 133.33, 400, 50 + i * 133.33);
  }
}

void drawPieces() {
  for (int col = 0; col < 3; col++) {
    for (int row = 0; row < 3; row++) {
      if (board[col][row] == 1) {
        drawX(col, row);
      } else if (board[col][row] == 2) {
        drawO(col, row);
      }
    }
  }
  
  if (winType != -1) {
    drawWinningLine();
  }
}

void drawX(int col, int row) {
  stroke(220, 50, 50);
  strokeWeight(8);
  float x = col * 133.33 + 66.67;
  float y = 50 + row * 133.33 + 66.67;
  line(x - 40, y - 40, x + 40, y + 40);
  line(x - 40, y + 40, x + 40, y - 40);
}

void drawO(int col, int row) {
  stroke(50, 100, 220);
  strokeWeight(8);
  noFill();
  float x = col * 133.33 + 66.67;
  float y = 50 + row * 133.33 + 66.67;
  ellipse(x, y, 90, 90);
}

void drawWinningLine() {
  stroke(50, 200, 50);
  strokeWeight(6);
  
  if (winType == 0) { // Fila horizontal
    float y = 50 + winRow * 133.33 + 66.67;
    line(20, y, 380, y);
  } else if (winType == 1) { // Columna vertical
    float x = winCol * 133.33 + 66.67;
    line(x, 70, x, 430);
  } else if (winType == 2) { // Diagonal principal (\)
    line(20, 70, 380, 430);
  } else if (winType == 3) { // Diagonal secundaria (/)
    line(380, 70, 20, 430);
  }
}

void displayInfo() {
  fill(0);
  textSize(18);
  if (gameEnded) {
    if (winner.equals("")) {
      text("¡EMPATE! 🤝", width/2, 25);
    } else {
      text("¡GANÓ " + winner + "! 🎉", width/2, 25);
    }
  } else {
    text("Turno de: " + (xTurn ? "X" : "O"), width/2, 25);
  }
}

void drawResetButton() {
  if (gameEnded) {
    fill(100, 200, 100);
    stroke(50);
    strokeWeight(2);
    rect(140, 460, 120, 40, 10);
    fill(255);
    textSize(16);
    text("REINICIAR", 200, 480);
  }
}

void mousePressed() {
  if (gameEnded && mouseX > 140 && mouseX < 260 && mouseY > 460 && mouseY < 500) {
    resetGame();
    return;
  }
  
  if (gameEnded || mouseY < 50) return;
  
  int col = int(mouseX / 133.33);
  int row = int((mouseY - 50) / 133.33);
  
  if (col >= 0 && col < 3 && row >= 0 && row < 3 && board[col][row] == 0) {
    board[col][row] = xTurn ? 1 : 2;
    xTurn = !xTurn;
  }
}

void checkWin() {
  if (gameEnded) return;
  
  // Verificar FILAS (horizontales) - mismo row, diferentes col
  for (int row = 0; row < 3; row++) {
    if (board[0][row] != 0 && 
        board[0][row] == board[1][row] && 
        board[1][row] == board[2][row]) {
      winner = board[0][row] == 1 ? "X" : "O";
      gameEnded = true;
      winRow = row;
      winType = 0;
      return;
    }
  }
  
  // Verificar COLUMNAS (verticales) - mismo col, diferentes row
  for (int col = 0; col < 3; col++) {
    if (board[col][0] != 0 && 
        board[col][0] == board[col][1] && 
        board[col][1] == board[col][2]) {
      winner = board[col][0] == 1 ? "X" : "O";
      gameEnded = true;
      winCol = col;
      winType = 1;
      return;
    }
  }
  
  // Verificar diagonal principal (\) - de [0][0] a [2][2]
  if (board[0][0] != 0 && 
      board[0][0] == board[1][1] && 
      board[1][1] == board[2][2]) {
    winner = board[0][0] == 1 ? "X" : "O";
    gameEnded = true;
    winType = 2;
    return;
  }
  
  // Verificar diagonal secundaria (/) - de [2][0] a [0][2]
  if (board[2][0] != 0 && 
      board[2][0] == board[1][1] && 
      board[1][1] == board[0][2]) {
    winner = board[2][0] == 1 ? "X" : "O";
    gameEnded = true;
    winType = 3;
    return;
  }
  
  // Verificar empate
  boolean empate = true;
  for (int col = 0; col < 3; col++) {
    for (int row = 0; row < 3; row++) {
      if (board[col][row] == 0) {
        empate = false;
        break;
      }
    }
  }
  
  if (empate) {
    gameEnded = true;
    winner = "";
  }
}

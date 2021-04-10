//Hola. A continuación te mostraré los controles para jugar.
//Con 'p' o 'P' pausas el juego; con 'l' o 'L' limpias el tablero, con 'r' o 'R' activas patrón aleatorio.
//Para mostar ejemplos primero limpiar el tablero.
//Con 'a' se muestra el patrón de nave.
//Con 's'  se muestra el oscilatorio de 3x1.
//Con 'd' se muestra el cuadrado de 2x2.
//Con '+' amuentas los frames por segundo, con '-' reduces los frames por segundo.
//Con '4' aumentas el factor rojo del color (rgb), con '1' disminuyes el factor rojo del color en el tablero y las celulas.
//Con '5' aumentas el factor verde del color (rgb), con '2' disminuyes el factor verde del color en el tablero y las celulas.
//Con '6' aumentas el factor azul del color (rgb), con '3' disminuyes el factor azul del color en el tablero y las celulas.
int n = 46;
int l = 10;
int[][] matriz = new int[n][n];
boolean pausa = false;
int x = 5;
int r= 250;
int g= 250;
int b= 250;
void setup() {
  size(505, 505);
  background(100);
  noStroke();
  comienzo(matriz, 1);
  frameRate(5);
}

void draw() {
  background(r,g,b);
  if (pausa) {
    frameRate(15); //frames de tiempo de despausa
    vida_1(matriz, l);
  }
  else {
    frameRate(x); //frames del juego
    vida_1(matriz, l);
    logica(matriz);
  }
}

void vida_1(int[][] estado, int lado) {
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {  //recorre la matriz en i filas y j columnas
      fill(estado[i][j]*300); //colorea cada celda de blanco
      rect((lado+1)*i, (lado+1)*j, lado, lado); //tamaño y ubicación de mis celulas dentro de la matriz
    }
  }
}

void logica(int[][] Matriz_ini) {
  int[][] bandera = new int[n+2][n+2];
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      bandera[i+1][j+1] = Matriz_ini[i][j];
    }
  }
  for (int i=0; i<n; i++) {
    bandera[i+1][0] = Matriz_ini[i][n-1];
    bandera[i+1][n+1] = Matriz_ini[i][0];
  }
  for (int j=0; j<n; j++) {
    bandera[0][j+1] = Matriz_ini[n-1][j];
    bandera[n+1][j+1] = Matriz_ini[0][j];
  }
  bandera[0][0] = Matriz_ini[n-1][n-1];
  bandera[0][n+1] = Matriz_ini[n-1][0];
  bandera[n+1][0] = Matriz_ini[0][n-1];
  bandera[n+1][n+1] = Matriz_ini[0][0];
  
  int vecinas = 0;
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      vecinas = bandera[i][j] + bandera[i+1][j] + bandera[i+2][j] + bandera[i][j+1] + bandera[i+2][j+1] + bandera[i][j+2] + bandera[i+1][j+2] + bandera[i+2][j+2]; //conteo de vida al rededor 
      if (Matriz_ini[i][j] == 0 && vecinas == 3) {   //regla Si una celula está muerta (Matriz_ini[i][j]=0)y tiene 3 vecinas vivas, nace(vecinas==3)
        Matriz_ini[i][j] = 1; //nace
      }
      else if (Matriz_ini[i][j] == 1 && (vecinas < 2 || vecinas > 3)) { //Si una celula viva tiene  menos de dos vecinas vivas o más de tres vecinas vivas, muere.
        Matriz_ini[i][j] = 0; //Muere 
      }
    }
  }
}

void comienzo(int[][] m, int z) {  // z= 0: vacío. z= 1 Aleatorio.
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) {
      m[i][j] = z*int(random(2));
    }
  }
}

  

void mousePressed() {
  if (pausa) {
    int x = int(mouseX/(l+1));
    int y = int(mouseY/(l+1));
    matriz[x][y] = 1-matriz[x][y];
  }
}

void keyPressed() {
  if  (key == 'd' ){ //cuadrado 2x2
  for(int i=34; i<36;i++)
    for(int j=34; j<36;j++)
    matriz[i][j]=1;
  }
  
  if  (key == 's' ){ //3 de largo
  for(int i=14; i<17;i++)
    matriz[i][23]=1;
  }
  if  (key == 'a' ){ // nave
  for(int i=24; i<27;i++)
    matriz[i][23]=1;
  }
  if  (key == 'a' ){ // nave
  for(int i=24; i<26;i++)
    matriz[i][i]=1;
  }
  if  (key == '4' && r<301){
  r=(r+10);
  }
  if  (key== '1' && 0<r){
  r=(r-10);
  }
  if  (key == '5' && g<301){
  g=(g+10);
  }
  if  (key== '2' && 0<g){
  g=(g-10);
  }
  if  (key == '6' && b<301){
  b=(b+10);
  }
  if  (key== '3' && 0<b){
  b=(b-10);
  }
  if  (key == '+' && x<20){
  x=(x+1);
  }
  if  (key== '-' && 1<x){
  x=(x-1);
  }
  if  (key == 'l' || key == 'L') {
    comienzo(matriz, 0);
  }
  else if (key == 'r' || key == 'R') {
    comienzo(matriz, 1);
  }
  else if (key == 'p' || key == 'P') {
    if (pausa) {
      pausa = false;
    }
    else {
      pausa = true;
    }
  }
}

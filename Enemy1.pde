class BasicEnemy {
  float x;
  float y;
  float angulo;
  float raio;
  
  BasicEnemy() {
    x = random(200, width/2);
    y = random(200, height/2);
    angulo = random(PI*2/2*2);
    raio = 0;
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y;
  }
  
  void update() {
    raio = raio + ( 400 - raio)*0.025;           
    x = cos(angulo)*raio + width/2;
    y = sin(angulo)*raio + height/2;
  }
  
  void setLocation() {
    x = random(200, width/2);
    y = random(200, height/2);
    angulo = random(PI*2/2*2);
    raio = 0;
  }

}

/* @pjs preload="back.png","crosshair.png","destroyer.png","start.png","start2.png"; */

class Star {
  float x;
  float y;
  float z;
  float timer;
  float pz;
  float starter;
  
  Star() {
    x = random(-width, width);
    y = random(-height, height);
    z = random(width);
    pz = z;
    timer = random(width);
    starter = 0;
  }
  
  void update(float x) {
    starter = x;
    z = z - starter;
    if (z < 1) {
      z = width;
      x = random(-width, width);
      y = random(-height, height);
      pz = z;
    }
  }
  
  void show() {
    fill(255);
    noStroke();
    
    float sx = map(x / z, 0, 1, 0, width);
    float sy = map(y / z, 0, 1, 0, height);
    float r = map(z, 0, width, 6, 0);
    
    ellipse(sx, sy, r, r);
    
    float px = map(x / pz, 0, 1, 0, width);
    float py = map(y / pz, 0, 1, 0, height);
    
    pz = z + 20;
    
    stroke(255);
    line(px, py, sx, sy);
  }
  
  void backgroundUpdate() {
    timer = timer - 100;
    if (timer < 1) {
      x = random(-width, width);
      y = random(-height, height);
      timer = random(width);
    }
  }
  
  void backgroundShow() {
    fill(255);
    noStroke();
    ellipse(x, y, 1, 1);
  }
  
  void menuShow() {
    fill(255);
    noStroke();
    float sx = map(x / z, 0, 1, 0, width);
    float sy = map(y / z, 0, 1, 0, height);
    float r = map(z, 0, width, 6, 0);
    
    ellipse(sx, sy, r, r);
  }
  
  
}


  
  
  
  
  
  
  
  
  

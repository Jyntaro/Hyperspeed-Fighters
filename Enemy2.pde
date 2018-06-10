class CrossingEnemy {
  float x, y;
  int decider;
  
  CrossingEnemy() {
   decider = (int) random (0, 2);
   if (decider == 1) {
     x = random(0, width - 500);
     y = -height - 100;
   } else if (decider == 0) {
     x = -width - 100;
     y = random(0, height - 500);
   } else if (decider == 3) {
     x = width + 100;
     y = random(0, height - 500);
   } else if (decider == 2) {
     x = random(0, width - 500);
     y = height + 100;
   }
  }
  
  float getX() {
    return x;
  }
  
  float getY() {
    return y; 
  }
  
  void update() {
    if (decider == 1) {
      y += 12; 
    } else if (decider == 0) {
      x += 12;
    } else if (decider == 2) {
      x -= 12;
    } else if (decider == 3) {
      y -= 12;
    }
      
  }
  
  void reset() {
    decider = (int) random(0, 4);
    if (decider == 1) {
     x = random(0, width - 200);
     y = -height - 100;
    } else if (decider == 0) {
     x = -width - 100;
     y = random(0, height - 200);
    } else if (decider == 3) {
     x = width + 100;
     y = random(0, height - 200);
    } else if (decider == 2) {
     x = random(0, width - 200);
     y = height + 100;
    }
  }
}

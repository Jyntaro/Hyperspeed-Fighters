import gifAnimation.*;
import ddf.minim.*;

/*
  Requires minim library and gifAnimation library
  library to be able to run completely. Without
  these, the stability and functionality of the 
  program cannot be guaranteed. 
*/

AudioPlayer laser;
AudioPlayer BGMMenu;
AudioPlayer BGMBattle;
AudioPlayer explosion;
Minim minim;

// animation data
Gif[] explosions = new Gif[10];
Gif explosionEffect;

// starfield data
Star[] stars = new Star[700];
Star[] background = new Star[200];
BasicEnemy basic = new BasicEnemy();
CrossingEnemy crossing = new CrossingEnemy();

// image and display information data
PImage crosshair;
PImage start;
PImage start2;
PImage back;
float startTimer = 0;
PFont pixelated;
PFont pixelTitle;
int score = 0;
int hiScore = 0;
int timeLeft = 60000;
int startTime = 0;
boolean isInMenu = true;

// Enemy1 data
PImage basicEnemy;
boolean showEnemy = false;
boolean enemyDefeated = false;
int first = 0;
float enemyTimer = 0;
float scoreTimer = 100;
float crossX, crossY;

// Enemy2 data
PImage crossingEnemy;
boolean showCrossingEnemy = false;
boolean crossingEnemyDefeated = false;
float crossX2, crossY2;
float crossingScore = 200;


void settings() {
  size(1000, 1000);
}

void setup() {
  // minim library for animations
  minim = new Minim(this);
  
  crosshair = loadImage("crosshair.png");
  crosshair.resize(60,60);
  back = loadImage("back.png");
  back.resize(247, 113);
  start = loadImage("start.png");
  start.resize(247, 113);
  start2 = loadImage("start2.png");
  start2.resize(247, 113);
  
  basicEnemy = loadImage("destroyer.png");
  basicEnemy.resize(88, 120);
  crossingEnemy = loadImage("angel.png");
  crossingEnemy.resize(205, 185);
  
  laser = minim.loadFile("laser.aiff");
  explosion = minim.loadFile("explosion.aiff");
  BGMMenu = minim.loadFile("Komiku_-_59_-_Together_we_are_stronger.mp3");
  BGMBattle = minim.loadFile("Komiku_-_58_-_Universe_big_takedown.mp3");
  BGMMenu.play();
  
  for (int i = 0; i < explosions.length; i++) {
    explosions[i] = new Gif(this, "explosion.gif");
    explosions[i].ignoreRepeat();
  }
  
  pixelated = loadFont("pixelated.vlw");
  pixelTitle = loadFont("pixelatedtitle.vlw");
  textFont(pixelated);
  
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
  
  for (int i = 0; i < background.length; i++) {
    background[i] = new Star(); 
  }
}

void draw() {
  background(0);
  noCursor();

  if (isInMenu) {   
    // start button
    image(start, 370, 450);
    if (mouseX > 370 && mouseX < 617 && mouseY > 450 && mouseY < 563) {
      image(start2, 370, 450);
    }
   
    // title text
    textFont(pixelTitle);
    text("Hyperspeed", 275, 220);
    text("Fighters", 340, 330);
    
    text("HISCORE:", width/2 - 175, 730);
    text(hiScore + " POINTS", width/2 - 175 - (24 * (String.valueOf(hiScore).length() - 1)), 830);

    for (int i = 0; i < stars.length; i++) {
      stars[i].menuShow();
    }   //for background stars
    for (int i = 0; i < background.length; i++) {
      background[i].backgroundUpdate();
      background[i].backgroundShow();
    }
  }

  // ENEMY LOGIC
  if (!isInMenu && (timeLeft + (startTime - millis()) >= 0)) {
    if (!showEnemy) {
      enemyTimer++;
      if (!enemyDefeated && enemyTimer%((int)random(100, 150)/(1 + first)) == 0) {
        showEnemy = true;
      }
      if (enemyDefeated) {
        image(explosions[0], crossX, crossY);
        if (!explosions[0].isPlaying()) {
          enemyDefeated = false;
        }
      }      
    }
 
    if (!showCrossingEnemy) {
      enemyTimer++;
      if (!crossingEnemyDefeated && first == 1 && enemyTimer%200 == 0) {
        showCrossingEnemy = true; 
      }
      if (crossingEnemyDefeated) {
        image(explosions[1], crossX2, crossY2);
        if (!explosions[1].isPlaying()) {
          crossingEnemyDefeated = false;
        }
      }
    }
  
    // show the basic enemy on screen
    if (showEnemy) {
      basic.update();
      image(basicEnemy, basic.getX(), basic.getY());
      if (scoreTimer > 10) {
        scoreTimer -= 1;
      }
    }
  
    // show the crossing enemy on screen
    if (showCrossingEnemy) {
      crossing.update();
      image(crossingEnemy, crossing.getX(), crossing.getY());
      if (crossingScore > 10) {
        crossingScore -= 1;
      }
   
      if (crossing.getX() > width + 100 || crossing.getX() < -width - 100 || crossing.getY() > height + 100 || crossing.getY() < -height - 100) {
        crossing.reset();
      }
    }
  }
  
  // VISUAL LOGIC
  if (!isInMenu && timeLeft + (startTime - millis()) <= 0) {
    textFont(pixelTitle);
    text("GAME OVER", 290, 300);
    text("SCORE:", width/2 - 135, 730);
    text(score + " POINTS", width/2 - 175 - (24 * (String.valueOf(score).length() - 1)), 830);
    image(back, 370, 450);
  }
  
  // display the crosshair above all necessary objects
  image(crosshair, mouseX - 30, mouseY - 30);
  
  if (!isInMenu && timeLeft + (startTime - millis()) > 0) {
    // for moving starfield
    translate(width/2, height/2);
    for (int i = 0; i < stars.length; i++) {
      stars[i].update(startTimer);
      stars[i].show();
    }
    if (startTimer < 40) {
      startTimer += 0.5;
    }
    textFont(pixelated);
    text ("SCORE: " + score, width/4 - 50, -height/3 - 60);
    text ("HISCORE: " + hiScore, width/4 - 50, -height/3 - 120);
    text ("TIME: " + (timeLeft + (startTime - millis()))/1000, width/16 - 200, -height/3 - 120);
    
    // for background stars
    for (int i = 0; i < 150; i++) {
      background[i].backgroundUpdate();
      background[i].backgroundShow();
    }
  }
}

void mouseClicked() {
  if (isInMenu && mouseX > 370 && mouseX < 617 && mouseY > 450 && mouseY < 563) {
    startTime = millis();
    isInMenu = false; 
    BGMMenu.pause();
    BGMMenu.rewind();
    BGMBattle.loop();
  } else if (!isInMenu) {
    if (timeLeft + (startTime - millis()) <= 0) {
      if (mouseX > 370 && mouseX < 617 && mouseY > 450 && mouseY < 563) {
        isInMenu = true;
        startTimer = 0;
        if (hiScore < score) {
          hiScore = score;
        }
        score = 0;
        BGMBattle.pause();
        BGMBattle.rewind();
        BGMMenu.loop();
      }
    } else {
      laser.play(1);
      if (showEnemy && mouseX > basic.getX() && mouseX < basic.getX() + 80 && mouseY > basic.getY() && mouseY < basic.getY() + 110) {
        crossX = mouseX - 45;
        crossY = mouseY - 45;
        explosion.play(1);
        explosions[0].play();
        score += scoreTimer;
        showEnemy = false;
        enemyDefeated = true;
        first = 1;
        basic.setLocation();
        scoreTimer = 100;
        if (hiScore < score) {
          hiScore = score;
        }
      }
    }
    if (showCrossingEnemy && mouseX > crossing.getX() && mouseX < crossing.getX() + 205 && mouseY > crossing.getY() && mouseY < crossing.getY() + 185) {
      crossX2 = mouseX - 45;
      crossY2 = mouseY - 45;
      explosion.play(1);
      explosions[1].play();
      score += scoreTimer + 100;
      showCrossingEnemy = false;
      crossingEnemyDefeated = true;
      crossing.reset();
      crossingScore = 200;
      if (hiScore < score) {
        hiScore = score;
      }
    }
  }
}   

void keyPressed() {
 if (keyCode == ESC) {
   key = 0;
   if (!isInMenu) {
     isInMenu = true;
     startTimer = 0;
     if (hiScore < score) {
       hiScore = score;
     }
     score = 0;
     BGMBattle.pause();
     BGMBattle.rewind();
     BGMMenu.loop();
   }
 } 
}

  

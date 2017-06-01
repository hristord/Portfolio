/* Quintana, Josue, and Ramirez-Diaz, Hristo
   05/28/2017
   Student ID(s): 1629460 & 1633203
   This program runs a game simulation in which the hero must
   fire "W's" at the rapid-moving professor in his classroom. 
   
   This Program also uses music "Bring It Back" by Lil Yachty and
   "Bounce Back" by Big Sean. */
  
class HealthBar {
  float value, max, x, y, w, h;
  color backing, bar;
  HealthBar() {
    value = 100;
    max = 100;
    x = 100;
    y = 20;
    w = 550;
    h = 30;
    backing = color(255, 0, 0);
    bar = color(0, 255, 0);
  } // creates a health bar using new code, with front and back color
  
  void draw(){
    fill(backing); // fills the back of the bar with red
    stroke(0); // sets the stroke
    rect(x, y, w, h); // creates the health bar dimensions
    fill(bar); // fills the visible part of the bar with green
    rect(x, y, map(value, 0, max, 0, w), h); // allows the bar to be adjusted
  }
}
 
HealthBar hb0;
int burdx = 720;
int burdy = 50;
int dantx = 710;
int danty = 800;
int deskx = 0;
int desky = 0;
int bullx; 
int bully;
int drct;
int victory= 0;
float rightrand = random(750, 1420); // sets float for villain random movement (right)
float leftrand = random(10, 600); // sets float for villain random movement (left)

import processing.sound.*; // allows Processing to use sound
SoundFile file; // names the sound file "file"
SoundFile yatchy; // names the sound file "yatchy"

void setup () {
  size(1500, 1000); // sets the pixel dimensions of digital canvas
  smooth(); // sets a different type of smoothness to geometry 
  bullx = 35; // value of bullx
  hb0 = new HealthBar(); // sets new function from previous function
  drct = 1; // allows the villain character to enable its established movement
  if(victory == 0) { // sets background music while playing the game
    yatchy = new SoundFile(this, "bring.mp3"); // calls the audio file "bring.mp3" to be played
    yatchy.jump(30); // progresses through the audio file 30 seconds
  }
}

void draw () {
  background(0); // creates the all-black background
  fill(252, 125, 20); // produces an orange fill
  rect(100, 100, 1300, 800); // creates a rectangle that simulates a classroom floor
  villain(); // calls the "villain" method that produces a character
  hero(); // calls the "hero" method that produces interactive character
  desks(); // calls the method that uses a for () to create classroom desks
  hb0.draw(); // calls the method that creates the health bar in the class
  if (bullx > 0) {
   fill(255); // white fill
   textSize(50); // sets the size of text
   text("W", bullx, bully); // produces desired projectile
   bully = bully - 35; // sets the speed of the projectile
   if (bully < 0) bullx = -1;
  } // sets up the position and speed of projectile through conditions
  hitMarker(); // calls the method that produces condition for lowering health bar
  endCredits(); // calls the method that produces the ending of the game when completed
  if(victory == 1) {
      file = new SoundFile(this, "bounce.mp3"); // calls the audio file
      file.jump(72.3); // advances through the audio file in seconds
  } // produces a conditional statement that plays an audio file when victory is achieved
    if(victory == 1) { 
    yatchy.stop(); // audio file stops when condition of winning is achieved
  }
}

/* This method creates the game's villain-character's
   structure and movement. The movement is controlled by
   the system itself, thus produces random jerk movements
   for increased difficulty. */

void villain() {
fill(252, 234, 222);
  rect(burdx, burdy, 80, 60);
  fill(222, 234, 133);
  rect(burdx, burdy + 60, 80, 40);
  for(int i = 0; i < random(0, 50); i++) { //loop for random movements
    if(burdx < rightrand && drct == 1) {
      burdx = burdx + 3* drct; //moves right
    }
    if(burdx >= rightrand) { //moves left
      drct = -1;
    }
    if(drct == -1 && burdx >= leftrand) { //moves right
      burdx = burdx + 3 * drct;
    }
    if(burdx <= leftrand) {
     drct = 1; 
    }
  }
  rightrand = random(1300, 1500);
}

/* This method creates the structure and movement of
   the hero character. Parameters are used to control 
   hero movement, and conditions of movement follow. */

void hero() {
  fill(182, 88, 34);
  rect(dantx, danty, 80, 80);
  fill(0, 0, 255);
  rect(dantx, danty + 80, 80, 90);
  if (keyPressed) { // adds left right movement for hero
    if (keyCode == LEFT) {
      dantx = max(dantx - 15, 0);
    } else if (keyCode == RIGHT) {
      dantx = min(dantx + 15, 1420);
    }
  }
}

/* This method is used for the background of the game.
   The "for ()" creates multiple desks, a 6 x 3 setup. */

void desks() {
  fill(198, 122, 64);
  for (int i = 0; i < 600; i=i+100) {
    for ( int j = 0; j < 300; j=j+100) {
    rect(deskx + 200 + 2*i, desky + 200 + 2*j, 100, 60);
    }
  }
}

/* This method sets up the "if" statement that produces a
   projectile heading upwards of the shooter's current
   position. This is done by pressing the "UP" key. */

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
    if (bullx >= 0) return;
      bullx = dantx + 20;
      bully = danty ;
    }
  }
}

/* This method calls the condition that lowers the health bar.
   The designed projectile must be within proximity of burdx and
   burdy. */

void hitMarker() {
  if (bully <= burdy + 60 && bully >= burdy && bullx <= burdx + 80 && bullx >= burdx){
    hb0.value = (hb0.value - 6);
  }
}

/* This method calls the winning condition. In other words, this
   method is called only when the health bar is brought less than 
   1 pixel. A congratulatory remark displays along with music. */
   
void endCredits() {
  if (hb0.value < 1) {
    victory++;
    background(0);
    textSize(100);
    fill(random(255), random(255), random(255));
    text("YOU BOUNCED BACK", 250, 500);
    text("Based on a True Story", 250, 700);
  }
}
/*
COMP 3490 Fall 2022
 Assignment 3
 Tara Boulanger
 7922331
 
 BoulangerTaraA3
   This is the file containing the main methods required to
 run the program. Go crazy!
   Somehow I got everything to work as I wanted?? There's no
 lerping for the camera, but everything else should be good
 to go! Enjoy flying Blue the dragon against his mortal
 enemies - the Grey legion!
 
   The textured 3D mode is kind of ugly and slow, but it's
 there!
*/

//Globals needed for the operation of the program
World world; //The world we're building
Character blue; //Our favorite protagonist, the main character blue

//The near and far Z planes
final int NEAR = -150;
final int FAR = -350;

//Is the game over yet????
boolean gameOver = false;


void setup() {
  size(640, 640, P3D);
  colorMode(RGB, 1.0f);
  textureMode(NORMAL); // use normalized 0..1 texture coords
  textureWrap(REPEAT);
  
  setupPOGL();
  setupProjections();
  setProjection(projectOrtho);
  resetMatrix(); //don't reset camera in draw!!!
  camera(0, 0, 100, 0, 0, 0, 0, 1, 0);
  
  //Creating the world!
  world = new World();
  world.drawWorld();
}//end setup


void draw() {
  clear();
  //Who runs the world? GIRLS! - Actually displays and moves the world
  world.drawWorld();
}

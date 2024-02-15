/*
COMP 3490 Fall 2022
 Assignment 3
 Tara Boulanger
 7922331
 
 Modes
    This is the file containing the code to watch for keystrokes then changing
  globals based off of those reactions.
*/

final char KEY_VIEW = 'r'; // switch between orthographic and perspective views

// player character
final char KEY_LEFT = 'a';
final char KEY_RIGHT = 'd';
final char KEY_UP = 'w';
final char KEY_DOWN = 's';
final char KEY_SHOOT = ' ';

// useful for debugging to turn textures or collisions on/off
final char KEY_TEXTURE = 't';
final char KEY_COLLISION = 'c';

final char KEY_BONUS = 'b';

boolean doProjection = false;

boolean doBonus = false;
boolean doTextures = false;
boolean doCollision = false;

void keyPressed()
{
  if ( key == KEY_UP ) { //GOING UP
    blue.movingUp = true;
  }//end up
  if ( key == KEY_DOWN ) { //GOING DOWN
    blue.movingDown = true;
  }//end down
  if ( key == KEY_RIGHT ) { //GOING RIGHT
    blue.movingRight = true;
  }//end right
  if ( key == KEY_LEFT ) { //GOOING LEFT
    blue.movingLeft = true;
  }//end left

  //BLUE IS SHOOTING
  if ( key == ' ' ) {
    blue.shooting = true;
  }//end shoot

  //Change the texture of the terrain
  if ( key == KEY_TEXTURE ) {
    if ( doTextures ) {
      doTextures = false;
    } else {
      doTextures = true;
    }//end if-else
  }//end if

  //Change the perspective
  if ( key == KEY_VIEW ) {
    if ( doProjection ) {
      doProjection = false;
      setProjection(projectOrtho);
      resetMatrix();
      camera(0, 0, 100, 0, 0, 0, 0, 1, 0);
    } else {
      doProjection = true;
      setProjection(projectPerspective);
      resetMatrix();
      camera(width/2.0, -height/2.0-125, 300.0, width/2.0, -height/2, 0, 0, 1, 0);
    }//end if-else
  }//end if
  
}//end keyPressed


void keyReleased() {

  if ( key == KEY_UP ) { //NO LONGER GOING UP
    blue.movingUp = false;
  }//end up
  if ( key == KEY_DOWN ) { //NO LONGER GOING DOWN
    blue.movingDown = false;
  }//end down
  if ( key == KEY_RIGHT ) { //NO LONGER GOING RIGHT
    blue.movingRight = false;
  }//end right
  if ( key == KEY_LEFT ) { //NO LONGER GOING LEFT
    blue.movingLeft = false;
  }//end left
  
  //Blue is no longer shooting :(
  if ( key == ' ' ) {
    blue.shooting = false;
  }//end if
  
}//end keyReleased

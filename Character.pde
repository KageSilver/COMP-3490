/*
COMP 3490 Fall 2022
 Assignment 3
 Tara Boulanger
 7922331
 
 Character
   This is the file containing the code for the main character.
 Watch as the protagonist, Blue, comes to life!
*/
 
public class Character {
  //Center coordinates of Blue
  int centerX;
  int centerY;
  int z;

  final int CHARACTER_Z_3D = NEAR+20; //The z value while in 3D

  final color FILL_COLOR = color(0.4, 0.4, 1); //Color for testing - best purplish blue ever #6666ff

  final int SIZE = 70; //Diameter of the character

  //2D boundaries for which it cannot cross
  final int TOP_BOUNDARY = 0;
  final int BOTTOM_BOUNDARY = -height;
  final int LEFT_BOUNDARY = 0;
  final int RIGHT_BOUNDARY = width;

  //3D boundaries for which it cannot cross
  final int TOP_BOUNDARY_3D = -height/5;
  final int BOTTOM_BOUNDARY_3D = -height*4/5;
  final int LEFT_BOUNDARY_3D = 100;
  final int RIGHT_BOUNDARY_3D = width-100;

  //E.T. PHONE HOME - Coordinates for Blue to return to
  final PVector HOME = new PVector(width/2, -height*0.7);

  //Which way is Blue moving?
  boolean movingUp = false;
  boolean movingDown = false;
  boolean movingRight = false;
  boolean movingLeft = false;

  //Blue moves THIS fast
  int moveFactor = 4;
  //BANK! MAKE BANK!! - How far to do the rotation
  final float ROTATION = PI/12;

  //All of the fireballs Blue has shot
  Projectiles shots;
  boolean shooting = false;
  int numProjectiles = 0;

  //Texture stuff
  final int NUM_FRAMES = 4;
  final float ANIMATION_PER_FRAME = 1.0/8.0;
  PImage[] blueMove = new PImage[NUM_FRAMES];
  int frameIndex = 0;
  float frame = 0;
  int sceneCount = 0;

  //The radius of Blue, collision testing
  float radius = pow(SIZE/2, 2);

  //The explosion that Blue does
  Explosion explosion;


  //Constructor for creating Blue
  Character () {
    //Starts at home
    centerX = (int)HOME.x;
    centerY = (int)HOME.y;
    z = CHARACTER_Z_3D;
    shots = new Projectiles();

    setupTextures(); //CALL FORTH THE PROTAGONIST
  }//end Character constructor


  //Method to move Blue. No parameters, no return values.
  void moveCharacter() {
    //If the game isn't over, then Blue can move
    if ( !gameOver) {
      //If it's in 3D, use those boundaries. If it's 2D, use those one
      if ( doProjection ) {
        if ( movingUp && centerY+moveFactor < TOP_BOUNDARY_3D ) {
          centerY += moveFactor;
        }
        if ( movingDown && centerY-moveFactor > BOTTOM_BOUNDARY_3D ) {
          centerY -= moveFactor;
        }
        if ( movingRight && centerX+moveFactor < RIGHT_BOUNDARY_3D ) {
          centerX += moveFactor;
        }
        if ( movingLeft && centerX-moveFactor > LEFT_BOUNDARY_3D ) {
          centerX -= moveFactor;
        }
      } else {
        if ( movingUp && centerY+moveFactor < TOP_BOUNDARY ) {
          centerY += moveFactor;
        }
        if ( movingDown && centerY-moveFactor > BOTTOM_BOUNDARY ) {
          centerY -= moveFactor;
        }
        if ( movingRight && centerX+moveFactor < RIGHT_BOUNDARY ) {
          centerX += moveFactor;
        }
        if ( movingLeft && centerX-moveFactor > LEFT_BOUNDARY ) {
          centerX -= moveFactor;
        }
      }//end if-else
    }//end outer if
  }//end moveCharacter


  //Method to move Blue back to its home position. Only works when
  //Blue isn't currently moving. No parameters, no return values.
  void returnHome() {
    //If the game isn't over, move Blue back gradually
    if ( !gameOver ) {
      //If Blue isn't moving, move it back gradually
      if ( !(movingUp || movingDown || movingRight || movingLeft) ) {
        if ( centerX > HOME.x ) {
          centerX -= 1;
        } else if ( centerX < HOME.x ) {
          centerX += 1;
        }//end if-else
        if ( centerY > HOME.y ) {
          centerY -= 1;
        } else if ( centerY < HOME.y ) {
          centerY += 1;
        }//end else-if
      }//end outer if
    }//end outest if
  }//end returnHome


  //Used for drawing Blue in 2D. Commented-out code is for the square he
  //used to be. No parameters, no return values.
  void drawCharacter2D() {
    /*beginShape(QUAD);
     fill(FILL_COLOR);
     vertex(centerX-SIZE/2, centerY+SIZE/2); //Top left
     vertex(centerX+SIZE/2, centerY+SIZE/2); //Top right
     vertex(centerX+SIZE/2, centerY-SIZE/2); //Bottom right
     vertex(centerX-SIZE/2, centerY-SIZE/2); //Bottom left
     endShape();*/
    //If the game isn't over, then draw Blue's texture. If it is, draw the explosion
    if ( !gameOver ) {
      image( blueMove[frameIndex], centerX-SIZE/2, centerY-SIZE/2, SIZE, SIZE );
    } else {
      //If the explosion hasn't been created yet
      if ( explosion == null )
        explosion = new Explosion(centerX, centerY);
      explosion.drawExplosion(); //KABOOM
    }//end if-else
  }//end drawCharacter2D


  //Used for drawing Blue in 3D. Commented-out code is for the square he
  //used to be. No parameters, no return values.
  void drawCharacter3D() {
    //If the game isn't over, draw Blue. If it is, draw the explosion
    if ( !gameOver ) {
      //Start making modifications to the matrix based on which way Blue is moving
      push();
      if ( movingUp ) {
        translate(-centerX, centerY, CHARACTER_Z_3D);
        rotateX(-ROTATION);
        translate(centerX, -centerY, -CHARACTER_Z_3D);
      }
      if ( movingDown ) {
        translate(-centerX, centerY, CHARACTER_Z_3D);
        rotateX(ROTATION);
        translate(centerX, -centerY, -CHARACTER_Z_3D);
      }
      if ( movingRight ) {
        translate(centerX, -centerY, CHARACTER_Z_3D);
        rotateY(ROTATION);
        translate(-centerX, centerY, -CHARACTER_Z_3D);
      }
      if ( movingLeft ) {
        translate(centerX, -centerY, CHARACTER_Z_3D);
        rotateY(-ROTATION);
        translate(-centerX, centerY, -CHARACTER_Z_3D);
      }//end if-else-if chain

      /*beginShape(QUAD);
       fill(FILL_COLOR);
       vertex(centerX-SIZE/2, centerY+SIZE/2, z); //Top left
       vertex(centerX+SIZE/2, centerY+SIZE/2, z); //Top right
       vertex(centerX+SIZE/2, centerY-SIZE/2, z); //Bottom right
       vertex(centerX-SIZE/2, centerY-SIZE/2, z); //Bottom left
       endShape();*/
       
      //Draw Blue in all his glory
      image( blueMove[frameIndex], centerX-SIZE/2, centerY-SIZE/2, SIZE, SIZE );

      pop();
    } else {
      //If the explosion hasn't already been made
      if ( explosion == null )
        explosion = new Explosion(centerX, centerY);
      explosion.drawExplosion(); //KABOOM (but 3D)
    }//end if-else
  }//end drawCharacter3D

  
  //Draw the fireballs that Blue is shooting as long as the game isn't over.
  //No return value, no parameters.
  void drawProjectiles() {
    if ( !gameOver )
      shots.drawProjectiles();
  }//end drawProjectiles

  //Add fireballs to the string of fire that Blue is shooting, given that the
  //game isn't over. No return value, no parameters.
  void addProjectiles() {
    if ( !gameOver)
      shots.addProjectile(new Projectile(centerX, centerY+SIZE/2, false));
  }//end addProjectiles


  //Used for grabbing the images that make up Blue's glorious and majestic
  //figure. No parameters, no return values.
  void setupTextures() {
    for ( int i=1; i<=NUM_FRAMES; i++ ) {
      blueMove[i-1] = loadImage("c" + i + ".png");
    }//end for
  }//end setupTextures

  //Used for getting the correct frame to show for Blue and his fireballs.
  //No parameters or return values.
  void updateAnimation() {
    frame = ( frame + ANIMATION_PER_FRAME ) % NUM_FRAMES;
    frameIndex = (int)frame;
    if ( frameIndex == 0 ) {
      sceneCount = ( sceneCount+1 ) % NUM_FRAMES;
    }//end if
    shots.updateAnimations();
  }//end updateAnimation
}//end Character class

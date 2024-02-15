/*
COMP 3490 Fall 2022
 Assignment 3
 Tara Boulanger
 7922331
 
 Projectile
    This is the file containing the code to create each of the individual
  projectiles in a string fire. Their color and direction is different based
  on who's shooting.
*/

public class Projectile {
  //Center location of this fireball
  int centerX;
  int centerY;
  
  final int PROJECTILE_Z = NEAR+19; //Z location of it

  final color FILL_COLOR = color(0.88,0.78,0.6); //Beige for before textures
  
  final int SIZE = 20;
  
  //2D boundaries
  final int TOP_BOUNDARY = 0;
  final int BOTTOM_BOUNDARY = -height;

  //3D boundaries
  final int TOP_BOUNDARY_3D = height/4;
  final int BOTTOM_BOUNDARY_3D = -height*4/5;

  //How fast it moves
  final int MOVE_FACTOR = 4;
  
  boolean moving;
  boolean alive;
  boolean enemy;
  
  //The radius of this fireball
  float radius = pow(SIZE/2,2);

  //Texture things
  final int NUM_FRAMES = 8;
  final float ANIMATION_PER_FRAME = 1.0/10.0;
  PImage[] enemyFireMove = new PImage[NUM_FRAMES];
  PImage[] blueFireMove = new PImage[NUM_FRAMES];
  int frameIndex = 0;
  float frame = 0;
  int sceneCount = 0;

  
  //Constructor for this fireball. Takes in the starting location and whether it's
  //an enemy projectile or not.
  Projectile ( int centerX, int centerY, boolean enemy ) {
    this.centerX = centerX;
    this.centerY = centerY;
    alive = true;
    this.enemy = enemy;
    
    setupTextures(); //Setup the textures of the fireball
  }//end Projectile constructor
  
  
  //Used for moving the projectile, either up or down depending on if it's an enemy
  //fireball or not. It takes in nothing and returns nothing.
  void moveProjectile() {
    //If it's alive
    if ( alive ) {
      //If it's an enemy's projectile, move down. Blue's goes up
      if ( enemy ) {
        centerY -= MOVE_FACTOR;
      } else {
        centerY += MOVE_FACTOR;
      }//end if-else
    }//end if
  }//end moveProjectile
  
  
  //Used for drawing the fireball in 2D. Takes in nothing, returns nothing.
  //The image changes based off of whether it's Grey's or Blue's. Commented
  //out code is used for the old fireballs.
  void drawProjectile2D() {
    /*beginShape(QUAD);
    fill(FILL_COLOR);
    vertex(centerX-SIZE/2,centerY-SIZE/2); //Top left
    vertex(centerX+SIZE/2,centerY-SIZE/2); //Top right
    vertex(centerX+SIZE/2,centerY+SIZE/2); //Bottom right
    vertex(centerX-SIZE/2,centerY+SIZE/2); //Bottom left
    endShape();*/
    if ( enemy ) {
      image( enemyFireMove[frameIndex] , centerX-SIZE/2 , centerY-SIZE/2 , SIZE , SIZE );
    } else {
      image( blueFireMove[frameIndex] , centerX-SIZE/2 , centerY-SIZE/2 , SIZE , SIZE );
    }//end if-else
  }//end drawProjectile2D
  
  //Used for drawing the fireball in 3D. Takes in nothing, returns nothing.
  //The image changes based off of whether it's Grey's or Blue's. Commented
  //out code is used for the old fireballs.
  void drawProjectile3D() {
    /*beginShape(QUAD);
    fill(FILL_COLOR);
    vertex(centerX-SIZE/2,centerY-SIZE/2,PROJECTILE_Z); //Top left
    vertex(centerX+SIZE/2,centerY-SIZE/2,PROJECTILE_Z); //Top right
    vertex(centerX+SIZE/2,centerY+SIZE/2,PROJECTILE_Z); //Bottom right
    vertex(centerX-SIZE/2,centerY+SIZE/2,PROJECTILE_Z); //Bottom left
    endShape();*/
    if ( enemy ) {
      image( enemyFireMove[frameIndex] , centerX-SIZE/2 , centerY-SIZE/2 , SIZE , SIZE );
    } else {
      image( blueFireMove[frameIndex] , centerX-SIZE/2 , centerY-SIZE/2 , SIZE , SIZE );
    }//end if-else
  }//end drawProjectile3D
  
  
  //Used for both moving the fireballs and checking if it's alive or not. Takes
  //nothing, gives nothing.
  void run() {
    moveProjectile();
    living();
  }//end run
  
  
  //Used to check if the projectile is still alive, depends on 2D and 3D. 
  //Takes in nothing, returns nothing.
  void living() {
    if ( doProjection ) {
      if ( centerY < BOTTOM_BOUNDARY_3D ) alive = false;
      if ( centerY > TOP_BOUNDARY_3D ) alive = false;
    } else {
      if ( centerY < BOTTOM_BOUNDARY ) alive = false;
      if ( centerY > TOP_BOUNDARY ) alive = false;      
    }//end if-else
  }//end borders
  
  
  //Used to setup the textures of the fireballs. Depends on if it's Grey or Blue
  //shooting. Gives nothing, takes nothing.
  void setupTextures() {
    for ( int i=1; i<=NUM_FRAMES; i++ ) {
      if ( enemy ) {
        enemyFireMove[i-1] = loadImage("ep" + i + ".png");
      } else {
        blueFireMove[i-1] = loadImage("cp" + i + ".png");
      }//end if-else
    }//end for
  }//end setupTextures
  
  
  //Used to get the right frames for each of the fireballs at a specific point.
  void updateAnimation() {
    frame = ( frame + ANIMATION_PER_FRAME ) % NUM_FRAMES;
    frameIndex = (int)frame;
    if ( frameIndex == 0 ) {
      sceneCount = ( sceneCount+1 ) % NUM_FRAMES;
    }//end if
  }//end updateAnimation
  
  
  //Updates the state of the fireball.
  void dead() {
    alive = false;
  }//end dead
  
}//end Projectile class

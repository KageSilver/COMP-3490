/*
COMP 3490 Fall 2022
 Assignment 3
 Tara Boulanger
 7922331
 
 Enemy
   This is the file containing the code for the individual antagonists.
 This is the great Grey dragon, fear him for he shall roar!
*/
 
public class Enemy {
  //Center coordinates
  float centerX;
  float centerY;
  int z;
  final int ENEMY_Z_3D = NEAR+20;

  //Lerping stuff
  float counter;
  float speed;

  final int MAX_SPEED = 500;
  final int MIN_SPEED = 300;
  final int DIFFICULTY_MODIFIER = 20; //How much it'll speed up

  //starting position for lerping
  float startX;
  float startY;
  //ending position for lerping
  float endX;
  float endY;

  final color FILL_COLOR = color(0, 0, 1); //The color it used to be

  final int SIZE = 50; //Diameter of the enemy

  //Boundaries in 2D
  final int TOP_BOUNDARY = 0;
  final int BOTTOM_BOUNDARY = -height*3/5;
  final int LEFT_BOUNDARY = 0;
  final int RIGHT_BOUNDARY = width;

  //Boundaries in 3D
  final int TOP_BOUNDARY_3D = -height/5;
  final int BOTTOM_BOUNDARY_3D = -height/2;
  final int LEFT_BOUNDARY_3D = 100;
  final int RIGHT_BOUNDARY_3D = width-100;

  int moveFactor = 4;//How fast they begin moving

  //The string of fireballs this Grey has shot
  Projectiles shots;
  boolean shooting = false;
  int numProjectiles = 0;

  //This Grey has the audacity to be alive??
  boolean alive = true;
  
  //Used for modifying the difficulty
  int numDead;

  final int MAX_ENEMIES = 4; //Max number of enemies

  //Buffers for shooting to make the game easier
  int enemyShotBuffer;
  int enemyStartBuffer;
  final int SHOT_RATE = 5; //How fast they shoot
  final int GAME_START = 100; //How long they wait


  //Texture stuff
  final int NUM_FRAMES = 4;
  final float ANIMATION_PER_FRAME = 1.0/10.0;
  PImage[] greyMove = new PImage[NUM_FRAMES];
  int frameIndex = 0;
  float frame = 0;
  int sceneCount = 0;

  //Radius of this Grey
  float radius = pow(SIZE/2, 2);


  //Constructor for this Grey
  Enemy () {
    //Starts off at a random location
    centerX = randomX();
    centerY = randomY();

    startX = centerX;
    startY = centerY;

    endX = randomX();
    endY = randomY();

    z = ENEMY_Z_3D;
    shots = new Projectiles();

    counter = 0;
    numDead = 0;
    speed = randomSpeed(); //How fast this one will move

    enemyShotBuffer = 0;
    enemyStartBuffer = 0;

    setupTextures(); //Call forth the dragon
  }//end Character constructor


  //Give this grey a random speed by returning a random value that gets returned.
  //This random value is affected by the difficulty modifiers.
  float randomSpeed() {
    return random(MIN_SPEED+DIFFICULTY_MODIFIER*numDead, MAX_SPEED+DIFFICULTY_MODIFIER*numDead);
  }//end randomSteps

  //Give this Grey a random X position by returning a value between the boundaries.
  float randomX() {
    return random(LEFT_BOUNDARY, RIGHT_BOUNDARY);
  }//end randomX

  //Give this Grey a random Y position by returning a value between the boundaries.  
  float randomY() {
    return random(BOTTOM_BOUNDARY, TOP_BOUNDARY);
  }//end randomY

  //Give this Grey a random X position by returning a value between the 3D boundaries.
  float randomX3D() {
    return random(LEFT_BOUNDARY_3D, RIGHT_BOUNDARY_3D);
  }//end randomX3D

  //Give this Grey a random Y position by returning a value between the 3D boundaries.
  float randomY3D() {
    return random(BOTTOM_BOUNDARY_3D, TOP_BOUNDARY_3D);
  }//end randomY3D


  //Move this Grey! It takes in all of the end positions of the other Greys just so that it
  //doesn't end in the same place as them, just makes the game harder. At least, that's how
  //the code is supposed to work, not sure if that's actually the case annd this might all be
  //useless code......
  void moveEnemy ( ArrayList<PVector> endPositions ) {
    //Used for lerping the enemy's positions
    if ( counter <= speed ) {
      float t = counter/speed;
      float tPrime = (1-cos(PI*t))/2;
      lerpEnemy(tPrime);
      counter++;
    }//end if

    //Once the enemy has made it here ...
    if ( centerX == endX && centerY == endY ) {
      startX = endX;
      startY = endY;
      //If were' in 3D, get random positions for the 3D location and make sure they aren't
      //ending in the same location as other Greys. If it's 2D, do the same thing but just
      //in 2D instead.
      if ( doProjection ) {
        endX = randomX3D();
        endY = randomY3D();

        boolean found = false;
        int loopCount = 0;
        int arrayCount = 0;
        //Going through all of the Grey's end positions
        while ( !found && arrayCount < endPositions.size() ) {
          loopCount = 0;
          while ( loopCount < endPositions.size() ) {
            if ( endX+SIZE/2 <= endPositions.get(loopCount).x && endX-SIZE/2 >= endPositions.get(loopCount).x ) {
              if ( endY+SIZE/2 <= endPositions.get(loopCount).y && endY-SIZE/2 >= endPositions.get(loopCount).y ) {
                endY = randomY3D();
                endX = randomX3D();
              }//end if
            }//end if
            loopCount++;
          }//end while
          if ( endX+SIZE/2 >= endPositions.get(arrayCount).x && endX-SIZE/2 <= endPositions.get(arrayCount).x ) {
            if ( endY+SIZE/2 >= endPositions.get(arrayCount).y && endY-SIZE/2 <= endPositions.get(arrayCount).y ) {
              found = true;
            }//end if
          }//end if
          arrayCount++;
        }//end while
      } else {
        endX = randomX();
        endY = randomY();

        boolean found = false;
        int loopCount = 0;
        int arrayCount = 0;
        while ( !found && arrayCount < endPositions.size() ) {
          loopCount = 0;
          while ( loopCount < endPositions.size() ) {
            if ( endX+SIZE/2 <= endPositions.get(loopCount).x && endX-SIZE/2 >= endPositions.get(loopCount).x ) {
              if ( endY+SIZE/2 <= endPositions.get(loopCount).y && endY-SIZE/2 >= endPositions.get(loopCount).y ) {
                endY = randomY();
                endX = randomX();
                println(endX);
                println(endPositions.get(loopCount));
              }//end if
            }//end if
            loopCount++;
          }//end while
          if ( endX+SIZE/2 >= endPositions.get(arrayCount).x && endX-SIZE/2 <= endPositions.get(arrayCount).x ) {
            if ( endY+SIZE/2 >= endPositions.get(arrayCount).y && endY-SIZE/2 <= endPositions.get(arrayCount).y ) {
              found = true;
            }//end if
          }//end if
          arrayCount++;
        }//end while
      }//end if-else

      counter = 0;
    }//end if

    //If the current location of the Grey matches Blue's location, it's going to shoot!
    if ( centerX+SIZE/2 <= blue.centerX+blue.SIZE/2 && centerX-SIZE/2 >= blue.centerX-blue.SIZE/2 ) {
      //As long as the grace period has been passed.
      if ( enemyShotBuffer%SHOT_RATE == 0 && enemyStartBuffer > GAME_START ) {
        addProjectiles();
      }//end if
    }//end if
    drawProjectiles();
    enemyShotBuffer++;
    if ( enemyStartBuffer <= GAME_START )
      enemyStartBuffer++;
  }//end moveEnemy


  //Used for drawing this Grey in 2D. Takes in nothing, returns nothing.
  //The commented out code is for the inferior form.
  void drawEnemy2D() {
    /*beginShape(QUAD);
     fill(FILL_COLOR);
     vertex(centerX-SIZE/2, centerY+SIZE/2); //Top left
     vertex(centerX+SIZE/2, centerY+SIZE/2); //Top right
     vertex(centerX+SIZE/2, centerY-SIZE/2); //Bottom right
     vertex(centerX-SIZE/2, centerY-SIZE/2); //Bottom left
     endShape();*/
    //It has to be alive to be drawn, silly!
    if ( alive ) {
      image( greyMove[frameIndex], centerX-SIZE/2, centerY-SIZE/2, SIZE, SIZE );
    }//end if
  }//end drawEnemy


  //Used for drawing this Grey in 3D. Takes in nothing, returns nothing.
  //The commented out code is for the inferior form.
  void drawEnemy3D() {
    /*z = ENEMY_Z_3D;
     beginShape(QUAD);
     fill(FILL_COLOR);
     vertex(centerX-SIZE/2, centerY+SIZE/2, z); //Top left
     vertex(centerX+SIZE/2, centerY+SIZE/2, z); //Top right
     vertex(centerX+SIZE/2, centerY-SIZE/2, z); //Bottom right
     vertex(centerX-SIZE/2, centerY-SIZE/2, z); //Bottom left
     endShape();*/
    //If it's alive, then draw it
    if ( alive ) {
      image( greyMove[frameIndex], centerX-SIZE/2, centerY-SIZE/2, SIZE, SIZE );
    }//end if
  }//end drawEnemy


  //Used for drawing the string of fireballs this Grey is shooting. Takes
  //in no parameters, returns nothing.
  void drawProjectiles() {
    shots.drawProjectiles();
  }//end drawProjectiles

  //Used for adding a fireball to this Grey's list. Takes nothing,
  //gives nothing.
  void addProjectiles() {
    shots.addProjectile(new Projectile((int)centerX, (int)centerY-SIZE/2, true));
  }//end addProjectiles


  //Updates the center location of this Grey by lerping both the
  //x and y positions using the t value passed in. It returns
  //nothing.
  void lerpEnemy ( float t ) {
    centerX = lerp(centerX, endX, t);
    centerY = lerp(centerY, endY, t);
  }//end lerpEnemy


  //Makes the game harder by updating the amount of dead Greys in the
  //legion. Takes in an int, updates the local int, returns nothing.
  void addDifficulty ( int numDead ) {
    this.numDead = numDead;
  }//end addDifficulty


  //Make the Grey actually look like a dragon. Takes in nothing,
  //returns nothing.
  void setupTextures() {
    for ( int i=1; i<=NUM_FRAMES; i++ ) {
      greyMove[i-1] = loadImage("e" + i + ".png");
    }//end for
  }//end setupTextures


  //Updates which frame should be displayed so the Grey can fly.
  //Takes nothing, gives nothing.
  void updateAnimation() {
    frame = ( frame + ANIMATION_PER_FRAME ) % NUM_FRAMES;
    frameIndex = (int)frame;
    if ( frameIndex == 0 ) {
      sceneCount = ( sceneCount+1 ) % NUM_FRAMES;
    }//end if
  }//end updateAnimation


  //Returns the Explosion this Grey caused, and it's now declared dead.
  //Takes in nothing.
  Explosion doExplosion() {
    alive = false;
    return new Explosion(centerX, centerY);
  }//end doExplosion
}//end Character class

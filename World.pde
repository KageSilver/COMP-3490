/*
COMP 3490 Fall 2022
 Assignment 3
 Tara Boulanger
 7922331
 
 World
    This is the file containing the code to create the whole wide
  world. It creates the Grey legion, the terrain, and our favorite
  protagonist, Blue!
*/

public class World {
  //Forces the character to shoot slower
  int characterShotBuffer;
  final int SHOT_RATE = 15; //Change if you want more of a challenge
    
  //Terrain grids
  SquareGrid ground1;
  SquareGrid ground2;
  
  Enemies enemies; //The Grey legion
  
  //Texture stuff
  final int NUM_SCENES = 2;
  final int NUM_TEXTURES = 2;
  PImage[][] textures = new PImage[NUM_SCENES][NUM_TEXTURES];
  
  PImage gameEnd; //Image for the game over display
  
  
  //Constructor that initializes everything and calls all of the
  //creation functions for the components of this world.
  World () {
    setupTextures();
    
    int chosenTexture = (int)random(0,NUM_SCENES);
    
    ground1 = new SquareGrid(textures[chosenTexture]);
    ground2 = new SquareGrid(textures[chosenTexture]);
    
    ground1.createGrid();
    ground2.createGrid();
    
    translateGround2D();
    
    characterShotBuffer = 0;
    
    blue = new Character();
    enemies = new Enemies();
  }//end constructor
  
  
  //Used for drawing all of the components of the world. Draws the grids in 2D
  //or 3D. Draws Blue in 2D or 3D, then moves Blue accordingly, or brings it back
  //home. It then does the same thing with the Grey legion. Then it checks to see
  //if any collisions have happened. Then checks if the game has ended, show the
  //game over screen. Finally moves the whole world. Takes in nothing, returns nothing.
  void drawWorld() {
    //Drawing the grids
    if ( doProjection ) {
      ground1.draw3DGrid();
      ground2.draw3DGrid();
    } else {
      ground1.draw2DGrid();
      ground2.draw2DGrid();
    }//end if-else 
    
    //Drawing Blue
    if ( doProjection ) { 
      blue.drawCharacter3D();
    } else {      
      blue.drawCharacter2D();
    }
    blue.moveCharacter();
    blue.returnHome();
    blue.updateAnimation();
    
    if ( blue.shooting && characterShotBuffer%SHOT_RATE == 0 ) {
      blue.addProjectiles();
    }//end if
    blue.drawProjectiles();
    
    characterShotBuffer++;
    
    //Drawing the enemies
    enemies.drawEnemies();
    enemies.moveEnemies();
    enemies.updateAnimations();
    
    testCollisions();
    
    if ( gameOver ) {
      if ( doProjection ) {
        push();
        translate(0,0,blue.CHARACTER_Z_3D+5);
        image(gameEnd, 125, -100, width-250, -height+250);
        pop();
      } else {
        image(gameEnd, 0, 0, width, -height);        
      }//end if-else
    }//end if
    
    moveWorld();
  }//end drawWorld
  
  
  //Used for translating the ground at the start so that the grids don't overlap.
  //Takes in nothing, returns nothing.
  void translateGround2D() {
    ground2.translateGrid(height);
  }//end translateGround
  
  
  //Used for moving the ground of the world. Takes nothing, returns nothing.
  void moveWorld() {
    ground1.moveGrid();
    ground2.moveGrid();
  }//end move
  
  
  //Used for setting up the textures of the grids. Takes in nothing, returns nothing.
  void setupTextures() {
    int counter = 1;
    for ( int i=0; i<NUM_SCENES; i++ ) {
      for ( int j=0; j<NUM_TEXTURES; j++ ) {
        textures[i][j] = loadImage("bg" + counter + ".png");
        counter++;
      }//end for
    }//end for
  }//end setupTextures
  
  
  //Used for testing the collisions of all of the appropriate collisions outlined in the
  //assignment instructions. Takes in nothing and returns nothing.
  void testCollisions() {
    
    //Enemy - Character
    testEnemyCharacterCollision();
    
    //Character - Enemy
    testCharacterEnemyCollision();
    
    //Enemy Projectile - Character
    testEnemyHit();
    
    //Character Projectile - Enemy
    testCharacterHit();
    
    //Enemy Projectile - Character Projectile
    testProjectiles();
    
  }//end testCollisions
  
  
  //This is used for testing the collision between a Grey and Blue. It performs the hit circle test thing
  //after looping through the ArrayList of Greys. It takes in nothing and returns nothing.
  void testEnemyCharacterCollision() {
    //get the radius, and center then combine
    PVector[] enemyCenters = new PVector[4];
    float[] enemyRadii = new float[4];
    
    //character center
    PVector characterCenter = new PVector(blue.centerX,blue.centerY);
    
    //enemy radius and center
    for ( int i=0; i<enemies.enemies.size(); i++ ) {
      enemyCenters[i] = new PVector(enemies.enemies.get(i).centerX, enemies.enemies.get(i).centerY);
      enemyRadii[i] = enemies.enemies.get(i).radius;
      //compare values 
      if ( hitCircle(characterCenter.x,characterCenter.y,enemyCenters[i].x,enemyCenters[i].y,enemyRadii[i]) ){
        characterDies();
        enemies.killEnemy(enemies.enemies.get(i));
      }//end if
    }//end for
    
  }//end testEnemyCharacterCollision
  
  
  //This is used for testing the collision between Blue and a Grey. It performs the hit circle test thing
  //after looping through the ArrayList of Greys. It takes in nothing and returns nothing.
  void testCharacterEnemyCollision() {
    //enemy center
    PVector[] enemyCenters = new PVector[4];
    
    //character center
    PVector characterCenter = new PVector(blue.centerX,blue.centerY);
    //character radius
    float characterRadius = blue.radius;
    
    //enemy center
    for ( int i=0; i<enemies.enemies.size(); i++ ) {
      enemyCenters[i] = new PVector(enemies.enemies.get(i).centerX, enemies.enemies.get(i).centerY);
      //compare values 
      if ( hitCircle(characterCenter.x,characterCenter.y,enemyCenters[i].x,enemyCenters[i].y,characterRadius) ) {
        characterDies();
        enemies.killEnemy(enemies.enemies.get(i));
      }//end if
    }//end for
    
  }//end testCharacterEnemyCollision
  
  
  //This is used for testing the collision between a Grey's fireball and Blue. It performs the hit circle test thing
  //after looping through the ArrayList of Greys and their fireballs. It takes in nothing and returns nothing.
  void testEnemyHit() {    
    //enemy projectile center
    ArrayList<PVector> enemyProjectileCenters = new ArrayList<PVector>();
    
    //character center
    PVector characterCenter = new PVector(blue.centerX,blue.centerY);
    //character radius
    float characterRadius = blue.radius;
    
    //enemy center
    for ( int i=0; i<enemies.enemies.size(); i++ ) {
      for ( int j=0; j<enemies.enemies.get(i).shots.shots.size(); j++ ) {
        enemyProjectileCenters.add(new PVector(enemies.enemies.get(i).shots.shots.get(j).centerX, enemies.enemies.get(i).shots.shots.get(j).centerY));
        //compare values 
        if ( hitCircle(characterCenter.x,characterCenter.y,enemyProjectileCenters.get(j).x,enemyProjectileCenters.get(j).y,characterRadius) )
          characterDies();
      }//end inner for
    }//end for
    
  }//end testEnemyHit
  
  
  //This is used for testing the collision between Blue's fireball and a Grey. It performs the hit circle test thing
  //after looping through the list of Greys' centers and Blue's fireballs. It takes in nothing and returns nothing.
  void testCharacterHit() {    
    //enemy center and radius
    PVector[] enemyCenters = new PVector[4];
    float[] enemyRadii = new float[4];
    
    //character projectile center
    ArrayList<PVector> characterProjectileCenters = new ArrayList<PVector>();
    
    //character projectile center
    for ( int i=0; i<enemies.enemies.size(); i++ ) {
      enemyCenters[i] = new PVector(enemies.enemies.get(i).centerX, enemies.enemies.get(i).centerY);
      enemyRadii[i] = enemies.enemies.get(i).radius;
      for ( int j=0; j<blue.shots.shots.size(); j++ ) {
        characterProjectileCenters.add(new PVector(blue.shots.shots.get(j).centerX, blue.shots.shots.get(j).centerY));
        //compare values 
        if ( hitCircle(enemyCenters[i].x,enemyCenters[i].y,characterProjectileCenters.get(j).x,characterProjectileCenters.get(j).y,enemyRadii[i]) ) {
          enemies.killEnemy(enemies.enemies.get(i));
          blue.shots.shots.get(j).dead();
        }//end if
      }//end inner for
    }//end for
    
  }//end testCharacterHit
  
  
  //This is used for testing the collision between a Grey's fireballs and Blue's fireballs. It performs the hit circle test thing
  //after looping through the ArrayList of Greys and their fireballs and Blue's fireballs. It takes in nothing and returns nothing.
  void testProjectiles() {    
    //enemy center and radius
    ArrayList<PVector> enemyProjectileCenters = new ArrayList<PVector>();
    float enemyRadii = 0;
    
    //character projectile center
    ArrayList<PVector> characterProjectileCenters = new ArrayList<PVector>();
    float characterRadii = 0;
    
    //character projectile center
    for ( int i=0; i<enemies.enemies.size(); i++ ) {
      for ( int j=0; j<blue.shots.shots.size(); j++ ) {
        characterRadii = blue.shots.shots.get(j).radius;
        for ( int h=0; h<enemies.enemies.get(i).shots.shots.size(); h++ ) {
          enemyRadii = enemies.enemies.get(i).shots.shots.get(h).radius;
          characterProjectileCenters.add(new PVector(blue.shots.shots.get(j).centerX, blue.shots.shots.get(j).centerY));
          enemyProjectileCenters.add(new PVector(enemies.enemies.get(i).shots.shots.get(h).centerX, enemies.enemies.get(i).shots.shots.get(h).centerY));
          //compare values 
          if ( hitCircle(enemyProjectileCenters.get(h).x,enemyProjectileCenters.get(h).y,characterProjectileCenters.get(j).x,characterProjectileCenters.get(j).y,enemyRadii)
                && hitCircle(characterProjectileCenters.get(j).x,characterProjectileCenters.get(j).y,enemyProjectileCenters.get(h).x,enemyProjectileCenters.get(h).y,characterRadii)) {
            enemies.enemies.get(i).shots.shots.get(h).dead();
            blue.shots.shots.get(j).dead();
          }//end if
        }//end inner for
      }//end inner for
    }//end for
    
  }//end testProjectiles
  
  
  //This is used for checking if a point is within a circle. Takes in the coordinates of said point,
  //the coordinates of the center of the circle and the radius of the circle. Returns a boolean of
  //if that point is in the circle.
  boolean hitCircle ( float pointX, float pointY, float centerX, float centerY, float radius ) {
    boolean result = false;
    
    float firstTerm = pow(pointX-centerX,2);
    float secondTerm = pow(pointY-centerY,2);
    
    //The actual comparison function
    if ( firstTerm+secondTerm <= radius ) {
      result = true;
    }//end if
    
    return result;
  }//end hitCircle
  
  
  //This is used to update the state of the game. Takes in nothing, returns nothing.
  void characterDies() {
    gameOver();
  }//end enemyCharacterDeath
  
  
  //This is used to show the game over message. Takes in nothing and returns nothing.
  void gameOver() {
    gameOver = true;
    gameEnd = loadImage("gameOver.png");
  }//end gameOver
  
}//end World class

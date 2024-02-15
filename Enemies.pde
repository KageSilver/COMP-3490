/*
COMP 3490 Fall 2022
 Assignment 3
 Tara Boulanger
 7922331
 
 Enemies
   This is the file containing the code for the group of antagonists,
 the Grey legion! FEAR THEM for they are mighty.
*/

public class Enemies {
  //ArrayList containing all of the enemies in the legion
  ArrayList<Enemy> enemies;
  //ArrayList containing the individual explosions for the legion
  ArrayList<Explosion> explosions;
      
  final int MAX_ENEMIES = 4; //Max amount of enemies there can be
  
  //Used for keeping track of how many enemies are dead for the difficulty modifier
  int numDead = 0; 
  
  
  //Constructor for creating the legion
  Enemies() {
    enemies = new ArrayList<Enemy>();
    addEnemy(new Enemy());
    addEnemy(new Enemy());
    addEnemy(new Enemy());
    addEnemy(new Enemy());
    explosions = new ArrayList<Explosion>();
  }//end Enemies
  
  
  //Draw the legion. Go through the whole list and draw them either
  //in 3D or 2D. Then just draw the explosions here because why not.
  //Takes nothin', returns nothin' (western accent???).
  void drawEnemies() {
    //Go through the entire ArrayList legion
    for ( int i=0; i<enemies.size(); i++ ) {
      //If it's in 3D, draw in 3D. If it isn't, draw in 2D
      if ( doProjection ) {
        enemies.get(i).drawEnemy3D();
      } else {
        enemies.get(i).drawEnemy2D();
      }//end if-else
    }//end for
    drawExplosions(); //KABOOOOOOM - lots of explosions
  }//end drawEnemy
  
  
  //Move the legion and collect all of their ending positions for comparing
  //and collaboration. Take in no parameters, returns nothing.
  void moveEnemies() {
    //If the game isn't over, move them!
    if ( !gameOver ) {
      ArrayList<PVector> endPositions = new ArrayList<PVector>();
      //Storing the end positions
      for ( int i=0; i<enemies.size(); i++ ) { 
        endPositions.add(new PVector(enemies.get(i).endX,enemies.get(i).endY));
      }//end for
      //Moving the enemies individually
      for ( int i=0; i<enemies.size(); i++ ) { 
        enemies.get(i).moveEnemy(endPositions);
      }//end for
    }//end if
  }//end moveEnemies
  
  
  //Add an enemy to the ArrayList. Takes in an Enemy so that it can
  //be added to the ArrayList. Returns nothing.
  //THEY JUST KEEP COMING BLUE, KEEP FIGHTING!!
  void addEnemy ( Enemy enemy ) {
    enemies.add(enemy);
  }//end addEnemies
  
  
  //Kill the given enemy. Returns nothing. Makes the game harder
  //and then adds a new enemy.
  //Blue did so good! He killed a Grey!
  void killEnemy ( Enemy enemy ) {
    //Given enemy goes POOF
    explosions.add(enemy.doExplosion());
    enemies.remove(enemy); //Remove the enemy from the list, it's dead
    //If the game isn't over yet, add a new enemy in and increase the difficulty
    if ( !gameOver) {
      addEnemy(new Enemy());
      numDead++;
      //Adding difficulty to all of the Greys
      for ( int i=0; i<enemies.size(); i++ ) {
        enemies.get(i).addDifficulty(numDead);
      }//end for 
    }//end if
  }//end killEnemy
  
  
  //Used for updating the animation for each of the Greys. Takes
  //in nothing, returns nothing.
  void updateAnimations() {
    //Update every Grey in the legion, including their fireballs
    for ( int i=0; i<enemies.size(); i++ ) {
      enemies.get(i).updateAnimation();
      enemies.get(i).shots.updateAnimations();
    }//end for
  }//end updateAnimations
  
  
  //Used for drawing the explosions of each of the deceased Greys.
  //Takes in nothing, returns nothing.
  void drawExplosions() {
    for ( int i=0; i<explosions.size(); i++ ) {
      explosions.get(i).drawExplosion();
    }//end for
  }//end drawExplosions
  
}//end Enemies

/*
COMP 3490 Fall 2022
 Assignment 3
 Tara Boulanger
 7922331
 
 Projectiles
    This is the file containing the code to create each of the strings of fireballs
  for one of the characters of the game.
*/

public class Projectiles {
  //ArrayList to hold the string of fireballs
  ArrayList<Projectile> shots;
  
  
  //Constructor for the string of fireballs
  Projectiles() {
    shots = new ArrayList<Projectile>();
  }//end constructor
  
  
  //Used for drawing this string of fireballs. Takes in nothing, returns nothing.
  void drawProjectiles() {
    //Going through the whole list
    for ( int i=0; i<shots.size(); i++ ) {
      shots.get(i).run();
      //Only draw it if the fireball is alive
      if ( shots.get(i).alive ) {
        if ( doProjection ) {
          shots.get(i).drawProjectile3D();
        } else {
          shots.get(i).drawProjectile2D();
        }//end if-else
      } else {
        //If it's dead, remove it
        shots.remove(i); 
      }//end if-else
    }//end for
  }//end drawProjectiles
  
  
  //Used for adding a fireball to the list. Takes in a Projectile, which
  //is going to be added to the ArrayList. Returns nothing.
  void addProjectile ( Projectile shot ) {
    shots.add(shot);
  }//end addProjectile
  
  
  //Used for updating all of the individual animations of each fireball.
  //Takes in nothing, returns nothing.
  void updateAnimations() {
    //Go through the whole string of fireballs
    for ( int i=0; i<shots.size(); i++ ) {
      shots.get(i).updateAnimation();
    }//end for
  }//end updateAnimations
  
  
}//end Projectiles class

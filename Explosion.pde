/*
COMP 3490 Fall 2022
 Assignment 3
 Tara Boulanger
 7922331
 
 Explosion
    This is the file containing the code to create each of the individual
  explosions. They have a random direction and color. Kind of looks like
  a form of blood spatter. ANNIHILATION.
*/

public class Explosion {
  //ArrayList for the explosion of all of the blood particles
  ArrayList<ExplosionParticle> particles = new ArrayList<ExplosionParticle>();
  
  //Starting location of each of the particles
  float startingX;
  float startingY;
  
  //Random range of numbers of particles that can show up
  final int MAX_NUM_PARTICLES = 150;
  final int MIN_NUM_PARTICLES = 100;
  
  int numParticles; //What the actual number is
  
  
  //Constructor for the Explosion. Takes in the location of where it originates.
  Explosion ( float startingX, float startingY ) {
    this.startingX = startingX;
    this.startingY = startingY;
    
    numParticles = randomNumParticles(); //Setting them to a random number
    
    createExplosion();
  }//end Explosion
  
  
  //Used for drawing this explosion. It loops through the list and draws the particles
  //in either 2D or 3D. Takes in nothing, returns nothing.
  void drawExplosion() {
    //Looping through the whole explosion
    for ( int i=0; i<particles.size(); i++ ) {
      //If it's 3D, draw in 3D. If it's 2D, draw in 2D
      if ( doProjection ) {
        particles.get(i).drawParticle3D();
      } else { 
        particles.get(i).drawParticle2D();
      }//end if-else
      //Move the particles each frame
      particles.get(i).moveParticle();
    }//end for
  }//end drawExplosion
  
  
  //Used for creating the explosion by adding the specified number of particles. 
  //Takes in nothing, returns nothing.
  void createExplosion() {
    for ( int i=0; i<numParticles; i++ ) {
      particles.add(new ExplosionParticle(startingX,startingY,randomZ(),randomColor()));
    }//end for
  }//end createExplosion
  
  
  //Returns a random integer of particles between the range. Takes in nothing.
  int randomNumParticles() {
    return (int)random(MIN_NUM_PARTICLES,MAX_NUM_PARTICLES);
  }//end randomParticles
  
  //Returns a random integer Z value for the particle. Takes in nothing.
  float randomZ() {
    return random(2,35); //Just random z values suggested by a friend
  }//end randomZ
  
  //Returns a random bloody color for each of the particles. Takes in nothing.
  color randomColor() {
    color[] randomColor = {#7b0000,#800000,#850000,#8a0303,#8f0c07,#94130b,#991a0f};
    
    color result = randomColor[(int)random(0,7)];
    
    return result;
  }//end randomColor
  
}//end Explosion

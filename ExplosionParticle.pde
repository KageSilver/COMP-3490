/*
COMP 3490 Fall 2022
 Assignment 3
 Tara Boulanger
 7922331
 
 ExplosionParticle
    This is the file containing the code to create each of the individual
  particles in an explosion of bloooood. They have a random direction and color.
    This probably slows down the code significantly since they still exist in
  memory but just aren't being drawn.
*/

public class ExplosionParticle {
  //Values for the position of the particle
  float x;
  float startX;
  float y;
  float startY;
  final int MAX_EDGE = 5;
  float z;
  float startZ;

  //Color of the particle
  color fillColor;

  //How long it lives
  final int MAX_LIFESPAN = 100;
  int lifespan = 0;

  
  //Constructor for each of the particles. Takes in the positions and the color it needs to be.
  ExplosionParticle ( float x, float y, float z, color fillColor ) {
    this.x = x;
    this.y = y;
    this.z = z;

    startX = x;
    startY = y;
    startZ = z;

    this.fillColor = fillColor;
  }//end ExplosionParticle


  //Used for drawing the particle in 2D if the lifespan hasn't been exceeded.
  //Takes in nothing, returns nothing.
  void drawParticle2D() {
    if ( lifespan < MAX_LIFESPAN ) {
      beginShape(QUAD);
      strokeWeight(0);
      fill(fillColor);
      vertex(x, y); //Top left
      vertex(x+MAX_EDGE, y); //Top right
      vertex(x+MAX_EDGE, y-MAX_EDGE); //Bottom right
      vertex(x, y-MAX_EDGE); //Bottom left
      endShape();
    }//end if
  }//end drawParticle2D


  //Used for drawing the particle in 3D if the lifespan hasn't been exceeded.
  //Takes in nothing, returns nothing.
  void drawParticle3D() {
    if ( lifespan < MAX_LIFESPAN ) {
      beginShape(QUAD);
      fill(fillColor);
      vertex(x, y, z); //Top left
      vertex(x+MAX_EDGE, y, z); //Top right
      vertex(x+MAX_EDGE, y-MAX_EDGE, z); //Bottom right
      vertex(x, y-MAX_EDGE, z); //Bottom left
      endShape();
    }//end if
  }//end drawParticle3D


  //Used for moving the particle in random directions.
  //Takes in nothing, returns nothing.
  void moveParticle() {
    x+=randomMove();
    y+=randomMove();
    z+=randomMove();
    lifespan++;
  }//end moveParticle


  //Returns the random value of the direction that the particle would move.
  //Returns a float, takes in nothing.
  float randomMove() {
    return random(-2, 2);
  }//end randomX
}//end ExplosionParticle

/*
COMP 3490 Fall 2022
 Assignment 3
 Tara Boulanger
 7922331
 
 Square
    This is the file containing the code to create each of the individual
  squares within a grid. Whether it's textured or just a random color.
*/

public class Square {
  final float MAX_EDGE = width/20; //Size of it

  //Top left of the square
  int x;
  int y;
  int z;

  //Colors needed for drawing each square
  color fillColor;
  color shadeColor;

  //Texture stuff
  int textureType;
  PImage texture;


  //Constructor taking in the position of the square, the fill and shade
  //color of the square for the random grid. 
  Square ( int x, int y, color fillColor, color shadeColor, int z ) {
    this.x = x;
    this.y = -y;
    this.fillColor = fillColor;
    this.z = z;
    this.shadeColor = shadeColor;
  }//end constructor

  //Constructor taking in the position of the square, the fill and shade
  //color of the square for the texture grid. 
  Square ( int x, int y, int z, PImage texture ) {
    this.x = x;
    this.y = -y;
    this.z = z;
    this.texture = texture;
  }//end constructor


  //Used for drawing the square in 2D. Takes in nothing, returns nothing.
  //It'll either draw with a texture or without one.
  void drawSquare2D() {
    if ( !doTextures ) {
      beginShape(QUAD);
      strokeWeight(0);
      fill(fillColor);
      vertex(x, y); //Top left
      vertex(x+MAX_EDGE, y); //Top right
      vertex(x+MAX_EDGE, y-MAX_EDGE); //Bottom right
      vertex(x, y-MAX_EDGE); //Bottom left
      endShape();
    } else {
      image( texture, x, y-MAX_EDGE, MAX_EDGE, MAX_EDGE );
    }//end if-else
  }//end draw


  //Used for drawing the square in 3D. Takes in nothing, returns nothing.
  //It'll either draw with a texture or without one. It'll draw the
  //columns accordingly as well.
  void drawSquare3D() {
    if ( !doTextures ) {
      beginShape(QUAD);
      fill(fillColor);
      vertex(x, y, z); //Top left
      vertex(x+MAX_EDGE, y, z); //Top right
      vertex(x+MAX_EDGE, y-MAX_EDGE, z); //Bottom right
      vertex(x, y-MAX_EDGE, z); //Bottom left
      endShape();
    } else {
      //Needs to be translated in order to show at the right position
      push();
      translate(0, 0, z);
      image( texture, x, y-MAX_EDGE, MAX_EDGE, MAX_EDGE );
      pop();
    }//end if-else

    //Different column modes, textured or just shades
    if ( !doTextures ) {
      drawColumns();
    } else {
      drawColumnTextures();
    }//end if-else
  }//end draw


  //Used for drawing the columns of the square without textures. Takes in nothing, returns nothing.
  void drawColumns() {
    beginShape(QUAD);
    fill(shadeColor);
    vertex(x+MAX_EDGE, y-MAX_EDGE, z); //Top right of column
    vertex(x+MAX_EDGE, y-MAX_EDGE, FAR); //Bottom right of column
    vertex(x, y-MAX_EDGE, FAR); //Bottom left of column
    vertex(x, y-MAX_EDGE, z); //Top left of column
    endShape();

    beginShape(QUAD);
    fill(shadeColor);
    vertex(x+MAX_EDGE, y-MAX_EDGE, z); //Top left of column
    vertex(x+MAX_EDGE, y-MAX_EDGE, FAR); //Bottom left of column
    vertex(x+MAX_EDGE, y, FAR); //Bottom right of column
    vertex(x+MAX_EDGE, y, z); //Top right of column
    endShape();

    beginShape(QUAD);
    fill(shadeColor);
    vertex(x, y-MAX_EDGE, z); //Top right of column
    vertex(x, y-MAX_EDGE, FAR); //Bottom right of column
    vertex(x, y, FAR); //Bottom left of column
    vertex(x, y, z); //Top left of column
    endShape();

    beginShape(QUAD);
    fill(shadeColor);
    vertex(x, y, z); //Top right of column
    vertex(x, y, FAR); //Bottom right of column
    vertex(x+MAX_EDGE, y, FAR); //Bottom left of column
    vertex(x+MAX_EDGE, y, z); //Top left of column
    endShape();
  }//end drawColumns
  
  
  //Used for drawing the columns of the square with textures. Takes in nothing, returns nothing.
  void drawColumnTextures() {
    beginShape();
    texture(texture);
    vertex(x+MAX_EDGE, y-MAX_EDGE, z, 1, 0); //Top right of column
    vertex(x+MAX_EDGE, y-MAX_EDGE, FAR, 1, 1); //Bottom right of column
    vertex(x, y-MAX_EDGE, FAR, 0, 1); //Bottom left of column
    vertex(x, y-MAX_EDGE, z, 0, 0); //Top left of column
    endShape();

    beginShape();
    texture(texture);
    vertex(x+MAX_EDGE, y-MAX_EDGE, z, 0, 0); //Top left of column
    vertex(x+MAX_EDGE, y-MAX_EDGE, FAR, 0, 1); //Bottom left of column
    vertex(x+MAX_EDGE, y, FAR, 1, 1); //Bottom right of column
    vertex(x+MAX_EDGE, y, z, 1, 0); //Top right of column
    endShape();

    beginShape();
    texture(texture);
    vertex(x, y-MAX_EDGE, z, 1, 0); //Top right of column
    vertex(x, y-MAX_EDGE, FAR, 1, 1); //Bottom right of column
    vertex(x, y, FAR, 0, 1); //Bottom left of column
    vertex(x, y, z, 0, 0); //Top left of column
    endShape();

    beginShape();
    texture(texture);
    vertex(x, y, z, 1, 0); //Top right of column
    vertex(x, y, FAR, 1, 1); //Bottom right of column
    vertex(x+MAX_EDGE, y, FAR, 0, 1); //Bottom left of column
    vertex(x+MAX_EDGE, y, z, 0, 0); //Top left of column
    endShape();
  }//end drawColumnTextures


  //Used for moving the location of the square. Takes in the y value to move it by, returns nothing.
  void moveSquare ( int moveY ) {
    y += moveY;
  }//end moveSquare
}//end Square class

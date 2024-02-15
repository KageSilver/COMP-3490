/*
COMP 3490 Fall 2022
 Assignment 3
 Tara Boulanger
 7922331
 
 SquareGrid
    This is the file containing the code to create each of the grids.
  Can be textured or just random colors.
*/

public class SquareGrid {
  //Max width of a square
  final float MAX_EDGE = width/20;
  
  final int MAX_X = (int)(width/MAX_EDGE);
  final int MAX_Y = (int)(height/MAX_EDGE);

  final int EXTRA_X = 14; //Extra amount to add for 3D rendering

  //Max amount of squares for the grid
  final int MAX_SQUARES = (int)((width/MAX_EDGE + EXTRA_X) * height/MAX_EDGE);

  //Affects how quickly it can scroll
  final int SCROLL_RATE = 2;

  //how much to shade the color for the square
  final float SHADE_FACTOR = 0.5;

  Square[] squareGrid; //Random squares
  Square[] textureGrid; //Textured squares
  
  
  //For texturing
  final int NUM_SCENES = 2;
  final int NUM_TEXTURES = 2;
  PImage[] textures = new PImage[NUM_TEXTURES];

  
  //Constructor that takes in the textured array and initializes the grid arrays.
  SquareGrid ( PImage[] textures ) {
    squareGrid = new Square[MAX_SQUARES];
    textureGrid = new Square[MAX_SQUARES];
    this.textures = textures;
  }//end SquareGrid
  

  //Creates both the textured and random grids by adding the edge value to each of them until
  //it reaches the max value. Takes in nothing, returns nothing.
  void createGrid() {
    int numSquares = 0;

    for ( int x=(int)(-EXTRA_X/2*MAX_EDGE); x<width + (EXTRA_X/2*MAX_EDGE); x+=MAX_EDGE ) {
      for ( int y=0; y<height; y+=MAX_EDGE ) {
        float r = random(0, 1);
        float g = random(0, 1);
        float b = random(0, 1);
        color fillColor = color(r, g, b); //color of square
        color shadeColor = color(r*SHADE_FACTOR, g*SHADE_FACTOR, b*SHADE_FACTOR); //color of column
        squareGrid[numSquares] = new Square(x, y, fillColor, shadeColor, (int)randomZ());
        int texture = (int)random(0,NUM_TEXTURES); //grabbing the random texture
        textureGrid[numSquares] = new Square(x,y,(int)randomZ(),textures[texture]);
        numSquares++;
      }//end y for
    }//end x for
  }//end randomGrid


  //Used for grabbing a random Z value for the column. Returns a float, takes in nothing.
  float randomZ() {
    return random(FAR, NEAR);
  }//end randomColor


  //Used for drawing the grid in 2D and either textured or not. Calls each of the square's
  //draw functions. Takes in nothing and returns nothing.
  void draw2DGrid() {
    for ( int i=0; i<MAX_SQUARES; i++ ) {
      if ( doTextures ) {
        textureGrid[i].drawSquare2D();
      } else { 
        squareGrid[i].drawSquare2D();
      }//end if-else
    }//end for
  }//end draw2DGrid


  //Used for drawing the grid in 3D and either textured or not. Calls each of the square's
  //draw functions. Takes in nothing and returns nothing.
  void draw3DGrid() {
    for ( int i=0; i<MAX_SQUARES; i++ ) {
      if ( doTextures ) {
        textureGrid[i].drawSquare3D();
      } else { 
        squareGrid[i].drawSquare3D();
      }//end if-else
    }//end for
  }//end draw2DGrid


  //Used for moving the grids. If the individual square hits the top of the screen, move it to the bottom
  //of the other grid and keep cycling upwards. Takes in nothing, returns nothing.
  void moveGrid() {
    int numSquares = 0;
    for ( int x=(int)(-EXTRA_X/2*MAX_EDGE); x<width + (EXTRA_X/2*MAX_EDGE); x+=MAX_EDGE ) {
      for ( int y=0; y<height; y+=MAX_EDGE ) {
        if ( squareGrid[numSquares].y >= height ) {
          squareGrid[numSquares].moveSquare(-height*2);
          textureGrid[numSquares].moveSquare(-height*2);
        }//end if
        squareGrid[numSquares].moveSquare(SCROLL_RATE);
        textureGrid[numSquares].moveSquare(SCROLL_RATE);
        numSquares++;
      }//end for
    }//end for
  }//end moveGrid


  //Used for translating the grids. Called for moving entire grids at the start. Takes
  //in the integer to move the grid by, then moves each square accordingly. Returns nothing.
  void translateGrid ( int moveY ) {
    int numSquares = 0;
    for ( int x=(int)(-EXTRA_X/2*MAX_EDGE); x<width + (EXTRA_X/2*MAX_EDGE); x+=MAX_EDGE ) {
      for ( int y=0; y<height; y+=MAX_EDGE ) {
        squareGrid[numSquares].moveSquare(moveY);
        textureGrid[numSquares].moveSquare(moveY);
        numSquares++;
      }//end for
    }//end for
  }//end translateGrid
  
  
}//end SquareGrid

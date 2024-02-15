/*
COMP 3490 Fall 2022
 Assignment 3
 Tara Boulanger
 7922331
 
 Transforms3D
    This is the file containing the functions to manipulate the projection
  and camera matrices.
*/

PMatrix3D projectOrtho, projectPerspective;


void setupProjections() {
  ortho(0.0,width,height,0.0); //left right top bottom near far
  projectOrtho = getProjection();
  
  perspective(PI/3.0,width/height,-NEAR,FAR);
  fixFrustumYAxis();
  projectPerspective = getProjection();
}

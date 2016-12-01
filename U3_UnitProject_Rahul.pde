
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

// A blob skeleton
// Could be used to create blobbly characters a la Nokia Friends
// http://postspectacular.com/work/nokia/friends/start

import shiffman.box2d.*;

import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.dynamics.joints.*;

// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;


// An ArrayList of coins that will fall on the surface
ArrayList<Coin> coins;

// Our "blob" object
Skeleton blob;

// Just a single box this time
Box box;
// The Spring that will attach to the box from the mouse
Spring spring;

// Draw creature design or skeleton?
boolean skeleton;

//Images
PImage playerImg;
PImage icePlatformImg;
PImage goldCoinImg;


void setup() {
  size(640, 360);
  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  // Turn on collision listening!
  box2d.listenForCollisions();


  // Add some boundaries
  boundaries = new ArrayList<Boundary>();

//  boundaries.add(new Boundary(  width/2,   height-5,   width,   10));
  boundaries.add(new Boundary(  width/4,      height-5,    (width/2)-50,  10));
  boundaries.add(new Boundary(  3*(width/4),  height-50,    (width/2)-50,  10));
  
  boundaries.add(new Boundary(  width/2,   5,          width,   10));       // Top wall
  boundaries.add(new Boundary(  width-5,   height/2,   10,       height));  // Right wall
  boundaries.add(new Boundary(  5,         height/2,   10,       height));  // Left wall

  // Make a new blob
  blob = new Skeleton();

  // Make the box
  box = new Box(width/2, 100);

  // Make the spring (it doesn't really get initialized until the mouse is clicked)
  spring = new Spring();
  
  
    // Create the empty list
  coins = new ArrayList<Coin>();
  
    goldCoinImg = loadImage("Gold_coin_2.png");
    playerImg = loadImage("Mario.png");
}

// When the mouse is released we're done with the spring
void mouseReleased() {
  spring.destroy();
}

// When the mouse is pressed we. . .
void mousePressed() {
  // Check to see if the mouse was clicked on the box
  if (box.contains(mouseX, mouseY)) {
    // And if so, bind the mouse position to the box with a spring
    spring.bind(mouseX, mouseY, box);
  }
}

void draw() {
  //background(255);
  background(50 , 128, 255);

  if (random(1) < 0.01) {
    float sz = random(4, 8);
    coins.add(new Coin(random(width), 20, sz));
  }


  // We must always step through time!
  box2d.step();


  // Show the blob!
  if (skeleton) {
    blob.displaySkeleton();
  } 
  else {
    blob.displayCreature();
  }

  // Show the boundaries!
  for (Boundary wall: boundaries) {
    wall.display();
  }

  // Always alert the spring to the new mouse position
  spring.update(mouseX, mouseY);

  // Draw the box
  box.display();
  // Draw the spring (it only appears when active)
  spring.display();
  
    // Look at all coins
  for (int i = coins.size()-1; i >= 0; i--) {
    Coin p = coins.get(i);
    p.display();
    // Coins that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (p.done()) {
      coins.remove(i);
    }
  }
  
  

  fill(0);
  text("Space bar to toggle creature/skeleton.\nClick and drag the box.", 20, height-30);
}


void keyPressed() {
  if (key == ' ') {
    skeleton = !skeleton;
  }
}



// Collision event functions!
void beginContact(Contact cp) {
  // Get both shapes
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();

  if (o1.getClass() == Coin.class && o2.getClass() == Coin.class) {
    Coin p1 = (Coin) o1;
    p1.delete();
    Coin p2 = (Coin) o2;
    p2.delete();
  }

  if (o1.getClass() == Boundary.class) {
    Coin p = (Coin) o2;
    p.change();
  }
  if (o2.getClass() == Boundary.class) {
    Coin p = (Coin) o1;
    p.change();
  }


}

// Objects stop touching each other
void endContact(Contact cp) {
}
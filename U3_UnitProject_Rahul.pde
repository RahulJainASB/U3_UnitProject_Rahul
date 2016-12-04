
// A Mario Game
//

import shiffman.box2d.*;

import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import org.jbox2d.dynamics.joints.*;

import java.util.Iterator;

// A reference to our box2d world
Box2DProcessing box2d;

// Global variables
ArrayList<Boundary> boundaries;      // A list we'll use to track fixed objects
ArrayList<Coin>     coins;           // An ArrayList of coins that will fall on the surface


Track_Builder  track_builder;
Scoreboard  scoreboard;
Mario mario;
Sky   sky;

//Images
PImage playerImg;
PImage goldCoinImg;


void setup() {
  size(1024, 720);

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // Turn on collision listening!
  box2d.listenForCollisions();

  // Load the images
  goldCoinImg = loadImage("Gold_coin_s_2.png");
  playerImg   = loadImage("Mario_s.png");

  // Add boundaries
  boundaries = new ArrayList<Boundary>();
  boundaries.add(new Boundary(  width/2, height-5, width, 10, "Bottom")); // Bottom wall
  boundaries.add(new Boundary(  width/2, 5, width, 10, "Top"));       // Top wall
  boundaries.add(new Boundary(  width-5, height/2, 10, height, "Right"));  // Right wall
  boundaries.add(new Boundary(  5, height/2, 10, height, "Left"));  // Left wall

  track_builder = new Track_Builder();    // Build the Track Builder
  coins         = new ArrayList<Coin>();  
  mario         = new Mario(width/4, 200, playerImg, true);    
  scoreboard    = new Scoreboard();
  sky           = new Sky();
}


void draw() {
  background(50, 128, 255);

  // We must always step through time!
  box2d.step();

  // Add more coins
  if (random(1) < 0.005) {
    coins.add(new Coin(random(width), 20, 6));
  }

  for (Boundary wall : boundaries) {      // Show the boundaries!
    wall.display();
  }

  track_builder.display();              // Show the tracks and create more
  sky.display();
  mario.Draw();                        // Show Mario

  // Show the coins
  for (int i = coins.size()-1; i >= 0; i--) {
    Coin p = coins.get(i);
    p.display();
    
    // Coins that leave the screen, we delete them
    // (note they have to be deleted from both the box2d world and our list
    if (p.done()) {
      coins.remove(i);
    }
  }

  scoreboard.draw();            // Show the score
}


void keyPressed() {
  //print("Inside keyPressed");

  if ( key == CODED) {                  // check if key is CODED. This is for special keys
    if ( keyCode == LEFT ) {            // if left key is pressed, move left
      mario.applyHorzForce(false);
    } else if ( keyCode == RIGHT ) {    // if right key is pressed, move right
      mario.applyHorzForce(true);
    } else if ( keyCode == UP ) {    // if up key is pressed, move up
      mario.applyVertForce(true);
    } else if ( keyCode == DOWN ) {    // if down key is pressed, move down
      mario.applyVertForce(false);
    }
  }
  if (key == 'q') {
    exit();
  }
}



// Collision event functions!
void beginContact(Contact cp) {
  //print("\n Inside begin Contact \n");


  // Get both shapes
  Fixture f1 = cp.getFixtureA();
  Fixture f2 = cp.getFixtureB();
  // Get both bodies
  Body b1 = f1.getBody();
  Body b2 = f2.getBody();

  // Get our objects that reference these bodies
  Object o1 = b1.getUserData();
  Object o2 = b2.getUserData();


  // Mario hits the coin
  if (o1.getClass() == Mario.class && o2.getClass() == Coin.class) {
    scoreboard.hitCoin();
    Coin p2 = (Coin) o2;
    p2.delete();
  }
  else if (o1.getClass() == Coin.class && o2.getClass() == Mario.class) {
    scoreboard.hitCoin();
    Coin p2 = (Coin) o1;
    p2.delete();
  }


  // Mario hits a wall
  if ( (o1.getClass() == Mario.class    && o2.getClass() == Boundary.class) ) 
  {
    Boundary b = (Boundary) o2;
    if( b.getName().equals("Bottom") == true) {
      scoreboard.updateLives(-1);
    }
  } else if ( (o1.getClass() == Boundary.class && o2.getClass() == Mario.class   ) ) {
    Boundary b = (Boundary) o1;
    if( b.getName().equals("Bottom") == true) {
      scoreboard.updateLives(-1);
    }
  }



  // Mario hits Goomba
  if ( (o1.getClass() == Mario.class  && o2.getClass() == Goomba.class)  ) {
    scoreboard.updateLives(-1);    
    Goomba g = (Goomba) o2;
    g.delete();
  }
  if (  (o1.getClass() == Goomba.class && o2.getClass() == Mario.class ) ) {
    scoreboard.updateLives(-1);    
    Goomba g = (Goomba) o1;
    g.delete();
  }

  // Coin hits the wall
  if (o1.getClass() == Coin.class && o2.getClass() == Boundary.class) {
    Coin p1 = (Coin) o1;
    p1.delete();
  }
  if (o1.getClass() == Boundary.class && o2.getClass() == Coin.class) {
    Coin p1 = (Coin) o2;
    p1.delete();
  }
}

// Objects stop touching each other
void endContact(Contact cp) 
{
}

void showMessage()
{
  if ( scoreboard.getLives() <= 0 )
  {
    textSize(24);
    text("Game Over", 75, 400);
  }
}
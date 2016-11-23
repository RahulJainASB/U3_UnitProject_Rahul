import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;

// Classes
Coins coins;
Flag flag;
Goomba goomba;
Ground ground;
Mario mario;
Score score;

//Images
PImage marioImg;
PImage goombaImg;
PImage coinImg;
PImage brickImg;


void setup()
{
  fullScreen(P3D);
  colorMode(HSB);
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0, -100);
  box2d.setContinuousPhysics(true);

  goombaImg = loadImage("Goomba.png");
  marioImg = loadImage("Mario.png");


  coins        = new Coins();
  flag         = new Flag();
  goomba       = new Goomba();
  ground       = new Ground();
  mario        = new  Mario(width/2, height/2, marioImg, true);
  score        = new Score();

  mario = new Mario (width/2, height/2, marioImg, true);
}

void draw()
{
  mario.Draw();
  mario.Update();
  // coins.draw();
  // flag.draw();
  //goomba.draw();
  //ground.draw();
  // mario.draw();
  // score.draw();
}
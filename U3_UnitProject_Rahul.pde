Coins coins;
Flag flag;
Goomba goomba;
Ground ground;
Mario mario;
Score score;



void setup()
{
  fullScreen(P3D);
  
  coins        = new Coins();
  flag         = new Flag();
  goomba       = new Goomba();
  ground       = new Ground();
  mario        = new Mario();
  score        = new Score();
  
}

void draw()
{
  coins.draw();
  flag.draw();
  goomba.draw();
  ground.draw();
  mario.draw();
  score.draw();
}
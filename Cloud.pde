// class Cloud
// Draws and moves the cloud


class Cloud {

  // The Cloud tracks position, velocity, and acceleration 
  PVector position;
  PVector velocity;
  PVector acceleration;
  // The Cloud's maximum speed
  float topspeed;
  int              _imgH;
  int              _imgW;
  private float    _x;
  private float    _y;
    private PImage   _img;



  Cloud(PImage cloudImg) {
    
    _imgH = cloudImg.height;        //This is the scalar size of the box that we're going to create
    _imgW = cloudImg.width;        // we can grab these from an image OR use typical width & height of rectangle
    _img = cloudImg;

    
    // Start in the center
    _x = width+_imgW - 10;
    _y = _imgH/2;
    position = new PVector( _x, _y);
    velocity = new PVector(-3,0);
    acceleration = new PVector(-0.001,0);
    
    topspeed = -100;
  }

  void update() {
    // Velocity changes according to acceleration
    velocity.add(acceleration);
    // Limit the velocity by topspeed
    //velocity.limit(topspeed);
    // position changes by velocity
    position.add(velocity);
  }

  void display() {
    
    imageMode(CENTER);
   // pushMatrix();
    _x = position.x;  _y = position.y;    // Store the Pixel coordinates
    //translate( _x, _y);   //print(" ( ", pos.x, " , ", pos.y, " ) ");
    //rotate(-a);
    image(_img, _x, _y);     //We draw it at 0,0 because we've already TRANSLATED to the correct
    //popMatrix();                 // x,y using the translate function and x,y returned from box2d

  }



  float   GetX() { return _x; }
  float   GetY() { return _y; }
  int     GetWidth() { return  _imgW; }
  float getLeftX()  { return (_x-(_imgW/2)); }
  float getRightX() { return (_x+(_imgW/2)); }

}
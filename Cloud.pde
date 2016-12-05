// class Cloud
// Draws and moves the cloud


class Cloud {

  // The Cloud tracks position, velocity, and acceleration 
  private PVector _position;
  private PVector _velocity;
  private PVector _acceleration;
  private float   _topspeed;            // The Cloud's maximum speed
  private int     _imgH;
  private int     _imgW;
  private float    _x;
  private float    _y;
  private PImage   _img;



  Cloud(PImage cloudImg) 
  {

    _imgH = cloudImg.height;        //This is the scalar size of the box that we're going to create
    _imgW = cloudImg.width;        // we can grab these from an image OR use typical width & height of rectangle
    _img = cloudImg;

  if( (_imgH > height ) || (_imgW > width) )
  {
    float aspectRatio = _imgW/_imgH;
    int newH = height - 200;
    int newW = (int)(aspectRatio * newH);
    _imgW = newW;
    _imgH = newH;
  }


    // Start in the center
    _x = width+_imgW - 10;
    _y = _imgH/2;
    _position = new PVector( _x, _y);
    _velocity = new PVector(-3, 0);
    _acceleration = new PVector(-0.001, 0);

    _topspeed = -100;
  }

  void update() {
    // Velocity changes according to acceleration
    _velocity.add(_acceleration);

    // Limit the velocity by topspeed
    //velocity.limit(topspeed);
    
    // position changes by velocity
    _position.add(_velocity);
  }

  void display() {

    imageMode(CENTER);
    _x = _position.x;  
    _y = _position.y;    // Store the Pixel coordinates
    image(_img, _x, _y, _imgW, _imgH);     //We draw it at 0,0 because we've already TRANSLATED to the correct
  }



  float   GetX() { 
    return _x;
  }
  float   GetY() { 
    return _y;
  }
  int     GetWidth() { 
    return  _imgW;
  }
  float getLeftX() { 
    return (_x-(_imgW/2));
  }
  float getRightX() { 
    return (_x+(_imgW/2));
  }
}
// Class Track
// A track class that moves to the left with time

class Track {

  // A boundary is a simple rectangle with x,y,width,and height, It moves to the left at constant velocity
  private float     _x;
  private float     _y;
  private float     _w;
  private float     _h;
  private PImage   _img;
 private float     _xSpeed;
  
  // But we also have to make a body for box2d to know about it
  private Body      _b;

  Track(float x,float y, float w, float h) {
    _x = x;
    _y = y;
    _w = w;
    _h = h;
    _xSpeed = -5;                    // Speed of moving the tracks
    _img = loadImage("Ground_1.png");
    
    

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.KINEMATIC;
    bd.fixedRotation = true;          // Do not rotate this object
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    _b = box2d.createBody(bd);
    
    _b.setLinearVelocity(new Vec2(_xSpeed,0));  // Speed of moving the tracks
    
    // Attached the shape to the body using a Fixture
    _b.createFixture(sd,1);
    _b.setUserData(this);
  }
  

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(_b);
    float a = _b.getAngle();
    _x = pos.x; 
    _y = pos.y;
    pushMatrix();
    translate(pos.x,pos.y);
    stroke(0);
    rectMode(CENTER);
    image(_img, 0, 0, _w, _h); 
    popMatrix();
    
  }
  
  float getLeftX()  { return (_x - (_w/2)); }
  float getRightX() { return (_x + (_w/2)); }
  float getX()      { return _x;         }
  float getY()      { return _y; }
  float getWidth()  { return _w; }
  float getHeight() { return _h; }
  float getSpeed()  { return _xSpeed; }
  Body  getBody() { return  _b; }
}
// A track class that moves to the left with time

class Track {

  // A boundary is a simple rectangle with x,y,width,and height, It moves to the left at constant velocity
  float x;
  float y;
  float w;
  float h;
  PImage img;
  float x_speed;
  
  // But we also have to make a body for box2d to know about it
  Body b;

  Track(float x_,float y_, float w_, float h_) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    
    //int image_num = (int) random(1,5);
    //String s = "Ground_" + image_num + ".png";
    //img = loadImage(s);
    img = loadImage("Ground_1.png");
    //w = img.width;
    //h = img.height;
    
    
    x_speed = -5;                    // Speed of moving the tracks

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
    b = box2d.createBody(bd);
    
    b.setLinearVelocity(new Vec2(x_speed,0));  // Speed of moving the tracks
    
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
    b.setUserData(this);
  }
  

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(b);
    float a = b.getAngle();
    x = pos.x; y = pos.y;
 
    pushMatrix();
    translate(pos.x,pos.y);
    //rotate(-a);
    //fill(175);
    stroke(0);
    rectMode(CENTER);
    image(img, 0, 0, w, h); 
    popMatrix();
    
  }
  
  float getLeftX()  { return (x-(w/2)); }
  float getRightX() { return (x+(w/2)); }

}
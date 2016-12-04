// A fixed boundary class

class Boundary {

  // A boundary is a simple rectangle with x,y,width,and height
  private  float   _x;
  private  float   _y;
  private  float   _w;
  private  float   _h;
  private  String  _name;
  
  // But we also have to make a body for box2d to know about it
  private Body _b;

  Boundary(float x_,float y_, float w_, float h_, String type) {
    _x = x_;
    _y = y_;
    _w = w_;
    _h = h_;
    _name = type;

    // Define the polygon
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(_w/2);
    float box2dH = box2d.scalarPixelsToWorld(_h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld( _x, _y));
    _b = box2d.createBody(bd);
    
    // Attached the shape to the body using a Fixture
    _b.createFixture(sd,1);
    _b.setUserData(this);
  }

  // Draw the boundary, if it were at an angle we'd have to do something fancier
  void display() {
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(_x, _y, _w, _h);
  }
  
  String  getName() { return _name; }

} // end of Class
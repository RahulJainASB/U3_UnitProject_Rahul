// class Coins
// Draws the coins


class Coin {

  // We need to keep track of a Body and a radius
  private Body      _body;
  private float     _r;
  private boolean   delete = false;


  Coin(float x, float y, float r) {
    _r = r;
    // This function puts the particle in the Box2d world
    makeBody(x, y, r);
    _body.setUserData(this);
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(_body);
  }

  void delete() {
    delete = true;
  }

  // Is the particle ready for deletion?
  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(_body);
    
    // Is it off the bottom of the screen?
    if (pos.y > (height+(_r*2)) || delete) {
      killBody();
      return true;
    }
    return false;
  }

  // Draw 
  void display() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(_body);
    
    // Get its angle of rotation
    float a = _body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    imageMode(CENTER);
    image(goldCoinImg, 0, 0, 40, 40);     //We draw it at 0,0 because we've already TRANSLATED to the correct
    popMatrix();
  }

  // Here's our function that adds the particle to the Box2D world
  void makeBody(float x, float y, float r) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    _body = box2d.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.01;
    fd.restitution = 0.3;

    // Attach fixture to body
    _body.createFixture(fd);
    _body.setUserData(this);
    _body.setAngularVelocity(random(-10, 10));
  }
}
//  Class Mario
// It draws Mario and moves it based on key input
//

class Mario extends Entity
{
  private PVector _moveSpeed;

  Mario(float x, float y, PImage img, boolean isActive)
  {
    super(x, y, img, "Mario", isActive);
    super.CreateBody(BodyType.DYNAMIC);
    _moveSpeed = new PVector(50, 0);

    super._body.setUserData(this);
  }


  void applyHorzForce(boolean direction)
  {
    float G = 4000; // Strength of force
    if ( direction == true)
    {
      //print(": Right ;; ");
      Vec2 force = new Vec2( G, 0);
      super._body.applyForce(force, super._body.getWorldCenter());
    } else {
      //print(": Left ;; ");
      Vec2 force = new Vec2( -1 * G, 0);
      super._body.applyForce(force, super._body.getWorldCenter());
    }
  }

  void applyVertForce(boolean direction)
  {
    if ( direction == true)
    {
      float G = map(GetY(), 0, height, 0, 120000);
      //print(": Up:  ", G, "  ; "); 
      Vec2 force = new Vec2(0, G);
      super._body.applyForce(force, super._body.getWorldCenter());
    } else {
      //print(": Down || ");
      float G = -100000; // Strength of force 
      Vec2 force = new Vec2(0, G);
      super._body.applyForce(force, super._body.getWorldCenter());
    }
  }
} // end of class
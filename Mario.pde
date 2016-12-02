class Mario extends Entity
{
//  private boolean _keyLeft;
//  private boolean _keyRight;
//  private boolean _keyJump;
  private PVector _moveSpeed;
//  private int     _jumpStrength;

  Mario(float x, float y, PImage img, boolean isActive)
  {
    super(x, y, img, "Mario", isActive);
    super.CreateBody(BodyType.DYNAMIC);
    _moveSpeed = new PVector(50, 0);

    super._body.setUserData(this);
    
    //This is not a great method of doing jumping
//    _jumpStrength = 20000;
    // but it works for now.
  }


  void applyHorzForce(boolean direction)
  {
    float G = 4000; // Strength of force
    if ( direction == true)
    {
      Vec2 force = new Vec2( G, 0);
      super._body.applyForce(force, super._body.getWorldCenter());
    }
    else 
    {
      Vec2 force = new Vec2( -1 * G, 0);
      super._body.applyForce(force, super._body.getWorldCenter());
    }
  }

  void applyVertForce(boolean direction)
  {
    if ( direction == true)
    {

      float G = 120000; // Strength of force 
      Vec2 force = new Vec2(0, G);
      super._body.applyForce(force, super._body.getWorldCenter());
    } else {
      float G = -100000; // Strength of force 
      Vec2 force = new Vec2(0, G);
      super._body.applyForce(force, super._body.getWorldCenter());
    }
  }
} // end of class
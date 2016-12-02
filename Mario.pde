class Mario extends Entity
{
  private boolean _keyLeft;
  private boolean _keyRight;
  private boolean _keyJump;
  private PVector _moveSpeed;
  private int     _jumpStrength;

  Mario(float x, float y, PImage img, boolean isActive)
  {
    super(x, y, img, "Mario", isActive);
    super.CreateBody(BodyType.DYNAMIC);
    _moveSpeed = new PVector(50, 0);

    super._body.setUserData(this);
    
    //This is not a great method of doing jumping
    _jumpStrength = 20000;
    // but it works for now.
  }

  public void Update()
  {
    KeyInputs();
    HandleMovement();
  }

  private void KeyInputs()
  {
    print("Inside Mario Key Input");
    if (keyPressed)
    {
      if (key == 'd')
      {
        _keyRight = true;
      }
      if (key == 'a')
      {
        _keyLeft = true;
      }
      if (key == 'w')
      {
        _keyJump = true;
      }
    } else
    {
      _keyLeft  = false;
      _keyRight = false;
      _keyJump  = false;
    }
  }

  private void HandleMovement()
  {
    //
    //For more info on Moving bodies: http://www.iforce2d.net/b2dtut/forces
    //

    Vec2 currentVelocity = super._body.getLinearVelocity();


    //edit the current velocity based on what we're doing
    if (_keyRight)
    {
      currentVelocity.x = 1 * _moveSpeed.x;
    } else if (_keyLeft)
    {
      currentVelocity.x = -1 * _moveSpeed.x;
    } else
    {
      currentVelocity.x = 0;
    }
    super._body.setLinearVelocity(currentVelocity);

    //
    // THIS IS AN AWFUL WAY OF DOING JUMP
    // PLEASE NOTE THIS DOWN AND DO NOT USE IT IN YOUR FINAL CODE!
    // Jump should be based on when you "hit the ground" NOT BY USING
    // VELOCITY!
    //

    if (_keyJump && currentVelocity.y < 1 && currentVelocity.y > -1)
    {
      _moveSpeed.y = _jumpStrength;
      super._body.applyLinearImpulse( new Vec2(0, _jumpStrength), super.GetWorldCenter(), false);
    }
  }

  void applyHorzForce(boolean direction)
  {
    float G = 1000000; // Strength of force
    if ( direction == true)
    {
      //print(": Right ;; ");

      //Vec2 force = new Vec2( 5000000, 100000);
      Vec2 force = new Vec2( 3500, 0);
      super._body.applyForce(force, super._body.getWorldCenter());

      /*      
       // clone() makes us a copy
       Vec2 pos = super._body..getWorldCenter();
       
       Vec2 moverPos = m.body.getWorldCenter();
       // Vector pointing from mover to attractor
       Vec2 force = pos.sub(moverPos);
       float distance = force.length();
       // Keep force within bounds
       distance = constrain(distance,1,5);
       force.normalize();
       // Note the attractor's mass is 0 because it's fixed so can't use that
       float strength = (G * 1 * m.body.m_mass) / (distance * distance); // Calculate gravitional force magnitude
       force.mulLocal(strength);         // Get force vector --> magnitude * direction
       return force;
       */
    } else {
      //print(": Left ;; ");
      //Vec2 force = new Vec2( -1*G, 0);
      Vec2 force = new Vec2( -1 * 3550, 0);
      super._body.applyForce(force, super._body.getWorldCenter());
    }
  }

  void applyVertForce(boolean direction)
  {
    if ( direction == true)
    {
      //print(": Up  ||  ");
      float G = 150000; // Strength of force 
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
class Mario extends Entity
{
  private boolean _keyLeft;
  private boolean _keyRight;
  private boolean _keyJump;
  private PVector _moveSpeed;
  private int     _jumpStrength;
  
  Mario(float x, float y, PImage img, boolean isActive)
  {
    super(x, y, img, "Player", isActive);
    super.CreateBody(BodyType.DYNAMIC);
    _moveSpeed = new PVector(50,0);
    
    
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
    }
    else
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
    }
    else if (_keyLeft)
    {
      currentVelocity.x = -1 * _moveSpeed.x;
    }
    else
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
}
// class Goomba
// Draws and moves the goomba

class Goomba extends Entity
{
  private PImage   _picture;
  private boolean   _delete = false;
  private Track    _track;            // Track on which Goomba sits
  private float    _xSpeed;
  private float    _ySpeed;
  private int      _ySpeedFlipCounter = 20;
  

  Goomba(float x, float y, PImage img, boolean isActive, Track t)
  {
    super(x, y, img, "Goomba", isActive);
    super.CreateBody(BodyType.KINEMATIC);  
    super._body.setUserData(this);
    _track       = t;
    _xSpeed      = t.getSpeed() * 2;
    _ySpeed      = 5;
  }

  void delete() {
    _delete = true;
  }
  
  float setHorizontalSpeed()
  {
    if( _xSpeed < 0 )   // Traveling left
    { 
      if( GetX() <= _track.getLeftX())
      {
        _xSpeed = -1 * _track.getSpeed() * 3;
      }
    }
    else if (_xSpeed > 0)  // Traveling right  
    { 
      if (GetX() >= _track.getRightX()) {
        _xSpeed = _track.getSpeed() * 2;
      }
    }
    return _xSpeed;
  }

  
  float setVerticalSpeed()
  {
    _ySpeedFlipCounter--;
    if ( _ySpeedFlipCounter <= 0) 
    {
      _ySpeed = -1 * _ySpeed;  // Flip the y Speed
      _ySpeedFlipCounter = 20;
    }
    return _ySpeed;
  }

  
  float getHorizontalSpeed() { return _xSpeed; }
  float getVerticalSpeed()   { return _ySpeed; }
  boolean getDeleteStatus()  { return _delete; }
  
} // end of class
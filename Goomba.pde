// class Goomba
// Draws and moves the goomba

class Goomba extends Entity
{
  PImage picture;
  boolean delete = false;
  Track  track;            // Track on which Goomba sits
  float  x_speed;

  Goomba(float x, float y, PImage img, boolean isActive, Track t)
  {
    super(x, y, img, "Goomba", isActive);
    super.CreateBody(BodyType.KINEMATIC);  
    super._body.setUserData(this);
    track = t;
    x_speed = t.x_speed * 2;
  }

  void delete() {
    delete = true;
  }
  
  float SetSpeed()
  {
    if( x_speed < 0 )   // Traveling left
    { 
      if( GetX() <= track.getLeftX())
      {
        x_speed = -1 * track.x_speed * 3;
      }
    }
    else if (x_speed > 0)  // Traveling right  
    { 
      if (GetX() >= track.getRightX()) {
        x_speed = track.x_speed * 2;
      }
    }
    return x_speed;
  }
  
} // end of class
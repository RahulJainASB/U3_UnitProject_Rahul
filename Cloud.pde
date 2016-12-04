
class Cloud extends Entity
{
  boolean delete = false;
  float  x_speed = -8;

  Cloud(float x, float y,PImage img, boolean isActive)
  {
    super(x, y, img, "Cloud", isActive);
    super.CreateBody(BodyType.KINEMATIC);  
    super._body.setUserData(this);
    
    x_speed = -1 * ((int) random (6, 9));
    super.GetBody().setLinearVelocity(new Vec2(x_speed, 0));  // Speed of moving the clouds    
  }

  void delete() {
    delete = true;
  }
  
} // end of class
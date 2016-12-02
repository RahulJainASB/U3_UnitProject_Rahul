// class Goomba
// Draws and moves the goomba

class Goomba extends Entity
{
  PImage picture;
    boolean delete = false;

   Goomba(float x, float y, PImage img, boolean isActive)
   {
    super(x, y, img, "Goomba", isActive);
    super.CreateBody(BodyType.KINEMATIC);  
     super._body.setUserData(this);
  }
  
  void delete() {
    delete = true;
  }

}
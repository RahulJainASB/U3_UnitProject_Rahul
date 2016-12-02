// class Goomba
// Draws and moves the goomba

class Goomba extends Entity
{
  PImage picture;
    boolean delete = false;

   Goomba(float x, float y, PImage img, boolean isActive)
   {
    super(x, y, img, "Goomba", isActive);
    //super.CreateBody(BodyType.DYNAMIC);
    super.CreateBody(BodyType.KINEMATIC);
    //_moveSpeed = new PVector(50, 0);
  
     super._body.setUserData(this);
  }
  
  void delete() {
    delete = true;
  }

}
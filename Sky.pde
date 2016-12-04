class Sky {
 
 // A boundary is a simple rectangle with x,y,width,and height, It moves to the left at constant velocity
 float                cloud_height;
 ArrayList<Cloud>     clouds;
 
 
 Sky() {
 clouds          = new ArrayList<Cloud>();
 cloud_height    =  50;
 }
 
 
 void display()
 {
 createCloud();
 killCloud();
 
 for (Cloud c : clouds) {
 //c.Draw();
 c.update();
 c.display();
 }
 }
 
 void createCloud()
 {
 
 // Get the right X of the last cloud. Then based on a random distance, decide if to add a new cloud or wait.
 boolean addCloud = true;
 if ( clouds.size() > 0) 
 {
 Cloud c = clouds.get(  (clouds.size() - 1));
 float rightX = c.getRightX();
 if ( width < rightX ) 
 {
 addCloud = false;
 }
 else
 {
 float spacing = random(150, 300);
 if ( (width - rightX) < spacing) {
 addCloud = false;
 }
 }
 }
 
 if ( addCloud == true )
 {
 print("Added Cloud  ; ");
 float x = width - 2;
 float y = random(50, (height/6) ); // Draw the cloud between 50 and height/6 height.
 
 
 int image_num = 1; //(int)random(1, 11);
 String s = "Cloud_" + image_num + ".png";
 PImage cloudImg      = loadImage(s);
 
 
 //      Cloud newCloud = new Cloud(x, y, cloudImg, true);
 Cloud newCloud = new Cloud(cloudImg);
 clouds.add( newCloud);
 }
 }
 
 
 
 void killCloud()
 {
 
 // Check if the right edge of the cloud in the array has gone beyond the left wall, kill that cloud 
 Iterator<Cloud> it = clouds.iterator();
 while (it.hasNext() ) {
 Cloud c = it.next();
 if ( c.getRightX() < 0 ) {
 box2d.destroyBody(c.GetBody());    //This object can now be safely deleted from an ArrayList
 it.remove();
 }
 }
 
 }
 
 } //end of class 
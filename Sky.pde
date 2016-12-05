//
// Class Sky
// This class builds new clouds in the sky and manages them
//

class Sky {

  // A boundary is a simple rectangle with x,y,width,and height, It moves to the left at constant velocity
  private ArrayList<Cloud>     _clouds;
  private ArrayList<PImage>    _cloudImgs;
  private int                  _cloudIndex = 0;
  private int                  _maxCloudImg = 7;

  Sky() {
    _clouds            = new ArrayList<Cloud>();
    _cloudImgs         = new ArrayList<PImage>();

    // Load all the images to use for creating cloud; Start with 1
    for ( int i = 1; i < (_maxCloudImg+1); i++)
    {
      int image_num = i;
      String s = "Cloud_" + image_num + ".png";
      PImage cloudImg      = loadImage(s);
      _cloudImgs.add( cloudImg);
    }
  }

  void display()
  {
    createCloud();
    killCloud();

    for (Cloud c : _clouds) {
      c.update();
      c.display();
    }
  }

  void createCloud()
  {

    // Get the right X of the last cloud. Then based on a random distance, decide if to add a new cloud or wait.
    boolean addCloud = true;
    float   lastCloudRightX = width;

    if ( _clouds.size() > 0) 
    {
      Cloud c = _clouds.get(  (_clouds.size() - 1));
      lastCloudRightX = c.getRightX();            // Get the right edge position of the last cloud
      if ( width < lastCloudRightX )           // The cloud is still not fully displayed. Don't add new cloud yet
      {
        addCloud = false;
      }
    }

    if ( addCloud == true )
    {
      int getNewCloudIndex = getCloudIndex();
      int newCloudWidth = _cloudImgs.get(getNewCloudIndex).width;

      float spacing = random(10, 300);  // Add random spacing between the cloud

      float x = lastCloudRightX + spacing + (newCloudWidth/2);
      float y = random(50, (height/6) ); // Draw the cloud between 50 and height/6 height.

      //      Cloud newCloud = new Cloud(x, y, cloudImg, true);
      Cloud newCloud = new Cloud(_cloudImgs.get(getNewCloudIndex));
      _clouds.add( newCloud);
    }
  }

  int getCloudIndex()
  {  
    _cloudIndex++;
    if ( _cloudIndex >= _maxCloudImg )
    {
      _cloudIndex = 0;
    }
    return _cloudIndex;
  }

  void killCloud()
  {
    // Check if the right edge of the cloud in the array has gone beyond the left wall, kill that cloud 
    Iterator<Cloud> it = _clouds.iterator();
    while (it.hasNext() ) {
      Cloud c = it.next();
      if ( c.getRightX() < 0 ) {
        it.remove();
      }
    }
  }
} //end of class 
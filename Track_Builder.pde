//
// Class Track_Builder
// This class builds new tracks and manages them
//

class Track_Builder {

  // A boundary is a simple rectangle with x,y,width,and height, It moves to the left at constant velocity
  private float                _trackHeight;
  private PImage               _goombaImg;
  private ArrayList<Track>     _tracks;
  private ArrayList<Goomba>    _goombas;         // An ArrayList
  private int                  _numTracksCrossed;


  Track_Builder() {
    _goombaImg       = loadImage("Goomba_s.png");
    _tracks          = new ArrayList<Track>();
    _goombas         = new ArrayList<Goomba>();
    _trackHeight    =  50;
    _numTracksCrossed = 0;

    // Create 3 tracks to begin with. Rest will be added dynamically
    _tracks.add(new Track(  width/4, height-25, (width/2),     _trackHeight));
    _tracks.add(new Track(  3*(width/4), height-75, (width/4), _trackHeight));
    _tracks.add(new Track(  5*(width/4), height-30, (width/2), _trackHeight));

    //addGoomba(_tracks.get(0));      // Don't add Goomba to 1st two tracks
    //addGoomba(_tracks.get(1));
    addGoomba(_tracks.get(2));
  }


  void display()
  {
    createTrack();
    killTrack();
    killGoomba();


    for (Track t : _tracks) {
      t.display();
    }

    for (Goomba g : _goombas) {      // Show the Goomba!
      float speed = g.SetSpeed();    // Sets new speed and returns the value
      g.GetBody().setLinearVelocity(new Vec2( speed, 0));
      
      g.Draw();
    }
  }

  void createTrack()
  {
    // Check if the right edge of the last track in the array is close to the right edge of the frame 
    // If so, create a new track
    if ( _tracks.size() > 1) {
      Track last_track = _tracks.get(  (_tracks.size() - 1));
      if ( (last_track.getLeftX() < width) && (last_track.getRightX() > width) ) {
        // last track has entered the game. Create another track.
        float w_ = getNewTrackWidth(last_track);
        float x_ = getNewTrackX(last_track, w_);
        float y_ = getNewTrackY(last_track);

        Track newTrack = new  Track(  x_, y_, w_, _trackHeight);
        _tracks.add( newTrack);
        addGoomba(newTrack);
      }
    }
  }


  void addGoomba(Track onTrack) {
    PImage img = loadImage("Goomba_s.png");

    Goomba goomba = new Goomba( onTrack.getX(), (onTrack.getY() - (onTrack.getHeight()/2)), img, true, onTrack);
    goomba.GetBody().setLinearVelocity(new Vec2(goomba.getSpeed(), 0));  // Speed of moving the tracks
    _goombas.add(goomba);
    //print("Added Goomba\n");
  }


  void killTrack()
  {
    // Check if the right edge of the track in the array has gone beyond the left wall, kill that track 
    Iterator<Track> it = _tracks.iterator();
    while (it.hasNext() ) {
      Track t = it.next();
      if ( t.getRightX() < 0 ) {
        box2d.destroyBody(t.getBody());    //This object can now be safely deleted from an ArrayList
        it.remove();
        _numTracksCrossed++;
      }
    }
  }

  void killGoomba() 
  {
    Iterator<Goomba> git = _goombas.iterator();
    while (git.hasNext() ) {
      Goomba g = git.next();
      if ( (g.GetX() < 0 ) || (g.getDeleteStatus() == true)) {
        g.CleanUpDeadObject();        // Removes from box2d
        git.remove();
      }
    }
  }

  float getNewTrackWidth( Track prev)
  {
    float w_;
    w_ = random( (width/6), ((3*width)/4) );
    return w_;
  }

  float getNewTrackY( Track prev)
  {
    float h_;
    h_ = random( (height - 400), (height-_trackHeight) );
    return h_;
  }

  float getNewTrackX( Track prev, float new_width)
  {
    float x_;
    int spacing = (int)random( 90.0, 150.0);      // Space betweeen two tracks
    x_ = prev.getX() + (prev.getWidth()/2) + spacing + (new_width/2);  
    return x_;
  }

  int GetNumTracksCrossed() { return _numTracksCrossed; }
  
} //end of class 
//
// Class Track_Builder
// This class builds new tracks and manages them
//

class Track_Builder {

  // A boundary is a simple rectangle with x,y,width,and height, It moves to the left at constant velocity
  float                track_height;
  PImage               goombaImg;
  ArrayList<Track>     tracks;
  ArrayList<Goomba>    goombas;         // An ArrayList
  int                  numTracksCrossed;


  Track_Builder() {
    goombaImg       = loadImage("Goomba_s.png");
    tracks          = new ArrayList<Track>();
    goombas         = new ArrayList<Goomba>();
    track_height    =  40;
    numTracksCrossed = 0;

    // Create 3 tracks to begin with. Rest will be added dynamically
    tracks.add(new Track(  width/4, height-25, (width/2),     track_height));
    tracks.add(new Track(  3*(width/4), height-75, (width/4), track_height));
    tracks.add(new Track(  5*(width/4), height-30, (width/2), track_height));

    //addGoomba(tracks.get(0));      // Don't add Goomba to 1st two tracks
    //addGoomba(tracks.get(1));
    addGoomba(tracks.get(2));
  }


  void display()
  {
    createTrack();
    killTrack();
    killGoomba();


    for (Track t : tracks) {
      t.display();
    }

    for (Goomba g : goombas) {      // Show the Goomba!
      float speed = g.SetSpeed();    // Sets new speed and returns the value
      g.GetBody().setLinearVelocity(new Vec2( speed, 0));
      
      g.Draw();
    }
  }

  void createTrack()
  {
    // Check if the right edge of the last track in the array is close to the right edge of the frame 
    // If so, create a new track
    if ( tracks.size() > 1) {
      Track last_track = tracks.get(  (tracks.size() - 1));
      if ( (last_track.getLeftX() < width) && (last_track.getRightX() > width) ) {
        // last track has entered the game. Create another track.
        float w_ = getNewTrackWidth(last_track);
        float x_ = getNewTrackX(last_track, w_);
        float y_ = getNewTrackY(last_track);

        Track newTrack = new  Track(  x_, y_, w_, track_height);
        tracks.add( newTrack);
        addGoomba(newTrack);
      }
    }
  }


  void addGoomba(Track onTrack) {
    PImage img = loadImage("Goomba_s.png");

    Goomba goomba = new Goomba( onTrack.x, (onTrack.y - (onTrack.h/2)), img, true, onTrack);
    goomba.GetBody().setLinearVelocity(new Vec2(goomba.x_speed, 0));  // Speed of moving the tracks
    goombas.add(goomba);
    //print("Added Goomba\n");
  }


  void killTrack()
  {
    // Check if the right edge of the track in the array has gone beyond the left wall, kill that track 
    Iterator<Track> it = tracks.iterator();
    while (it.hasNext() ) {
      Track t = it.next();
      if ( t.getRightX() < 0 ) {
        box2d.destroyBody(t.b);    //This object can now be safely deleted from an ArrayList
        it.remove();
        numTracksCrossed++;
      }
    }
  }

  void killGoomba() 
  {
    Iterator<Goomba> git = goombas.iterator();
    while (git.hasNext() ) {
      Goomba g = git.next();
      if ( (g.GetX() < 0 ) || (g.delete == true)) {
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
    h_ = random( (height - 400), height );
    return h_;
  }

  float getNewTrackX( Track prev, float new_width)
  {
    float x_;
    int spacing = (int)random( 90.0, 150.0);      // Space betweeen two tracks
    x_ = prev.x + (prev.w/2) + spacing + (new_width/2);  
    return x_;
  }
} //end of class 
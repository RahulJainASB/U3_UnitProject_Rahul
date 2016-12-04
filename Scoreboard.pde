//    This is Class Scoreboard.                                 
//    It keeps the scoreboard score, lives remaining and level.

class Scoreboard
{
  private int _score;
  private int _level;
  private int _lives;
  private int _numCoinsHit;

  // This is the constructer to build the scoreboard
  Scoreboard()
  {
    reset();
  }

  void draw()
  {
    // Show the user's score and level

    fill(255);
    textSize(14);
    text("Level: ", width-280, 25);
    text (_level, width-230, 25);

    text("Score: ", width-280, 50);
    text (getScore(), width-230, 50);

    if ( _lives < 1 )
      fill(255, 0, 0);
    text("Lives: ", width-280, 75);
    text (_lives, width-230, 75);
  }

  void reset()
  {
    _score     = 0;
    _level     = 1;
    _lives     = 3;
    _numCoinsHit  = 0;
  }

  void hitCoin()
  {
    _numCoinsHit++;
  }

  int getScore()
  {
    _score = _numCoinsHit + (track_builder._numTracksCrossed * 5 * _level);
    updateLevel();
    return _score;
  }

  void updateLevel()
  {
    _level = 1 + ((int)(_score / 30));
  }

  void updateLives(int i ) { 
    _lives = _lives + i;
  }

  int getLives()
  {
    return _lives;
  }

  boolean stopGame()
  {
    boolean stopGame = false;
    if (_lives <= 0)
    {
      stopGame = true;
    }
    return stopGame;
  }
}
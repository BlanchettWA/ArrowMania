public class GameSystem
{

  float elapsedSeconds = 0;
  int frameNumber = 0;

  float minDelay = 0.3;
  float maxDelay = 0.8;

  float lastLeftArrow = 0;
  float lastRightArrow = 0;

  float nextLeftArrow = random(minDelay,maxDelay);
  float nextRightArrow = random(minDelay,maxDelay);

  float minArrowSpeed = .05;
  float maxArrowSpeed = .15;

  float lTarget = 412;
  float rTarget = 612;

  int streak = 0;
  int hitArrows = 0;
  int missArrows = 0;
  int bestStreak = 0;

  float deadZor = 512;

  ArrayList<Arrow> leftArrowQueue;
  ArrayList<Arrow> rightArrowQueue;


  public GameSystem() 
  {
    initGame();
  }

  public String getBestStreak()
  {
    return "Highest streak: " + bestStreak;
  }

  private void initGame()
  {
    elapsedSeconds = 0;
    frameNumber = 0;

    minDelay = 0.75;
    maxDelay = 1;

    lastLeftArrow = 0;
    lastRightArrow = 0;

    nextLeftArrow = random(minDelay,maxDelay);
    nextRightArrow = random(minDelay,maxDelay);

    minArrowSpeed = .08;
    maxArrowSpeed = .081;

    lTarget = 412;
    rTarget = 612;

    streak = 0;
    hitArrows = 0;
    missArrows = 0;

    deadZor = 512;

    leftArrowQueue = new ArrayList<Arrow>();
    rightArrowQueue = new ArrayList<Arrow>();
  }


  public String checkKeys()
  {
    String result = "null";
    if (key == CODED)
    {
    
      if (keyCode == UP){result = checkRightArrow("UP");}
  
      else if (keyCode == DOWN){result = checkRightArrow("DOWN");}
    
      else if (keyCode == LEFT){result = checkRightArrow("LEFT");}
    
      else if (keyCode == RIGHT){result = checkRightArrow("RIGHT");}
    
    }
    
    else //Look for other keys
    {    
      if (key == 'w') {result = checkLeftArrow("UP");}
    
      else if (key == 'a'){result = checkLeftArrow("LEFT");}
    
      else if (key == 's'){result = checkLeftArrow("DOWN");}

      else if (key == 'd'){result = checkLeftArrow("RIGHT");}
    }
  
    return result;
  }

  private String checkLeftArrow(String ky)
  {
    String result = "null";

    if (leftArrowQueue.size() > 0) //Make sure the array isn't empty. If it is do nothing. 
    {

      Arrow target = leftArrowQueue.get(0);
  
      if ((target.getArrowFront() >= lTarget) && (target.getArrowFront() <= deadZor)) //Is the arrow still valid?
      {
        if (target.hitTarget(ky))
        {
          result = giveHitState("OK");
          streak += 1;
          hitArrows += 1;
        }

        else {result = missedArrow();} //wrong key was hit
      }

      else { result = missedArrow(); } //Arrow touched the red line

    leftArrowQueue.remove(0);
    }

    return result;
  }

  private String checkRightArrow(String ky)
  {
    String result = "null";
    
    if (rightArrowQueue.size() > 0) //Confirm the array isn't empty
    {
      Arrow target = rightArrowQueue.get(0);
  
      if ((target.getArrowFront() <= rTarget) && (target.getArrowFront() >= deadZor)) //Make sure the arrow hasn't touched the line yet
      {
        if (target.hitTarget(ky))
        {
          result = giveHitState("OK");
          streak += 1;
          hitArrows += 1;
      
          if (streak > bestStreak) {bestStreak = streak;}
        }

        else { result = missedArrow(); } //Incorrect key was used
      }
    
      else {result = missedArrow();} //Arrow hit the Deadzor zone
    
      rightArrowQueue.remove(0);
    }
  return result;
  }

  private String giveHitState(String cal)
  {
    String result = "HIT";

    if (cal == "OK") { result = "HIT";}
    else if (cal == "BAD"){ result = "MISS";}
    else if (cal == "WORSE") {result = "COMBO";}

    return result;
  }

  private String missedArrow()
  {
    String result; 
    missArrows += 1;
  
    if (streak > 3) {result = giveHitState("WORSE");} //The streak was broken. Ouch. 
      
    else { result = giveHitState("BAD"); } //Just an arrow was missed. Not tooo bad. 

    streak = 0;

    return result;
  }

  public String getStreak()
  {
    return ("Streak: " + streak + "  |  Best:  " + bestStreak);
  }

  public String getRatio()
  {
    String result = "Ratio: (0 / 0)";
    if ((hitArrows + missArrows) > 0)
    {
      result =  ("Ratio: (" + hitArrows + " / " + (hitArrows + missArrows) + ")");
    }

    return result;
  }



  private void drawArrows()
  {
    for (int i = 0; i < leftArrowQueue.size();i++)
    {
      if (i > 0) //Offset arrows to avoid clumping 
      {
        if (leftArrowQueue.get(i).getArrowFront() > leftArrowQueue.get(i-1).getArrowBack())
        {
          leftArrowQueue.get(i).offsetArrow(maxArrowSpeed);
        }
      }
    
    leftArrowQueue.get(i).drawArrow();
    }
  
    for (int i = 0; i < rightArrowQueue.size(); i++)
    {
      if (i > 0)
      {
        if (rightArrowQueue.get(i).getArrowFront() < rightArrowQueue.get(i-1).getArrowBack())
        {
          rightArrowQueue.get(i).offsetArrow(maxArrowSpeed);
        }
      }
    
      rightArrowQueue.get(i).drawArrow();
    }
  }

  private String arrowDeadZone()
  {
    String result = "OK";
  
    for (int i = 0; i < leftArrowQueue.size();i++)
    {
      if (leftArrowQueue.get(i).getArrowFront() > deadZor)
      {
        result = missedArrow();
        leftArrowQueue.remove(i);
      }  
    }
  
    for (int i = 0; i < rightArrowQueue.size(); i++)
    {
      if (rightArrowQueue.get(i).getArrowFront() < deadZor)
      {
        rightArrowQueue.remove(i);
        result = missedArrow();
      }
    
    }
    return result;
  }

  private String randomDirection()
  {
    String result = "BLANK";

    int dice = int(random(100));

    if (dice > 10)
    {
      int dice2 = int(random(4));
    
      switch (dice2)
      {
        case 0:
          result = "UP";
          break;
        case 1:
          result = "LEFT";
          break;
        case 2:
          result = "DOWN";
          break;
        case 3:
          result = "RIGHT";
          break;
      }
    }
    return result;
  }

  private void genRightArrow()
  {
    lastRightArrow = elapsedSeconds;
    nextRightArrow = lastRightArrow + random(minDelay,maxDelay);
  
    String d = randomDirection();
  
    if (!(d == "BLANK"))
    {
      float spd = random((-1*minArrowSpeed),(-1*maxArrowSpeed));
      float pos = 1024;
    
      Arrow a = new Arrow(d,pos,"RIGHT",spd);
      rightArrowQueue.add(a);
    }
  }


  private void genLeftArrow()
  {
    lastLeftArrow = elapsedSeconds;
    nextLeftArrow = lastLeftArrow + random(minDelay,maxDelay);
  
    String d = randomDirection();
  
    if (!(d == "BLANK"))
    {
      float spd = random((minArrowSpeed),(maxArrowSpeed));
      float pos = 1;
    
      Arrow a = new Arrow(d,pos,"LEFT",spd);
      leftArrowQueue.add(a);
    }
  }


  public String drawRunningGame()
  {
    String result = "OK";
    frameNumber += 1;
    elapsedSeconds = frameNumber / 60.00;
  
    clear();
  
    //Checks for time and arrow generation
    if (elapsedSeconds >= nextRightArrow) { genRightArrow(); }
  
    if (elapsedSeconds >= nextLeftArrow) { genLeftArrow();  }

    //Draw the arrow track
    fill(100,100,100,100);
    rect(0,520,1024,100);

    //Draw the target zone
    fill(100,50,100,220);
    rect(lTarget,520,rTarget-lTarget,100);

    //Draw the DEADZONE
    fill(220,50,50);
    rect(509.5,410,5,250);
  
    //draw arrows
    drawArrows();
  
    //Check if the arrows reached deadzone
    result = arrowDeadZone();
    return result;
  }

}
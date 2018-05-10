public class Arrow
{
  float x;
  float speed;
  PImage sprite;
  String match;
  String side; 
  
  public Arrow(String type, float position, String dir, float spd)
  {
    if (type == "UP"){sprite = loadImage("sprites/upArrowSprite.png");}
    
    else if (type == "DOWN"){sprite = loadImage("sprites/downArrowSprite.png");}
    
    else if (type == "LEFT"){sprite = loadImage("sprites/leftArrowSprite.png");}
    
    else if (type == "RIGHT"){sprite = loadImage("sprites/rightArrowSprite.png"); }
    
    match = type;
    x = position;
    side = dir;
    speed = spd;
  }
  
  public void drawArrow()
  {
    x += (60.00 * speed);
    
    if ((match == "UP") || (match == "DOWN")) { image(sprite,x,545);}
    
    else{ image(sprite,x,557.5); }
  }
  
  public void offsetArrow(float spd)
  {
    //For every .03, give more offset. Thus, mod 0 is 3 to 5, mod 1 is 8 to 10, etc. 
    
    float mod = spd % .03;
    float minOff = ((mod * 5) + 3);
    
    //Arrow is too close to previous, so offset the position by...a bit. 
    
    if (side == "LEFT") { x -= random(minOff,(minOff+2)); }
    else { x += random(minOff,(minOff+2));}
  }
  
  public boolean hitTarget(String hit) {return (hit == match);}
  
  public float getArrowFront()
  {
    float result;
    
    if (side == "LEFT") //Arrow is on left side
    {
      if ((match == "UP") || (match == "DOWN")) { result = x + 25.0;}
      else { result = x + 50;}
    }
  
    else {result = x;} //Arrow is on Right side 
    return result;
  }
  
  
  public float getArrowBack()
  {
    float result;
    
    if (side == "RIGHT")
    {
      if ((match == "UP") || (match == "DOWN")) { result = x + 25.0; }
      else { result = x + 50; }   
    }
    
    else { result = x; } //Arrow is on LEFT side
    return result;
  }
}
//Menu for starting the game. Forces focus on the game at the start of the game...and provides an option for instructions.

public class GameMenu
{
  PImage logo;
  PImage opt1;
  PImage opt2;
  
  // Space to include more options if desired. 
  //  PImage opt3;  
  //  PImage opt4;
  
  public GameMenu()
  {
    logo = loadImage("sprites/arrowManiaLogo.png");
    opt1 = loadImage("sprites/startButton.png");
    opt2 = loadImage("sprites/instructionsButton.png");
  }
  
  public void drawMenu()
  {
    clear();

    //LOGO
    image(logo,256,96);

    //Menu Option 1 (128,384)
    image(opt1,128,384);

    //Menu Option 2 (640, 384)  
    image(opt2,640,384);
  
    //Menu Opt 3 (under opt 1, (128,534))
    //  rect(128,534,256,100);
  
    //Menu Opt 4
    //  rect(640,534, 256,100);
  }
  
  private boolean buttonContainsMouse(float rX, float rY)
  {
    boolean result; 
    
    if ((mouseX >= rX) && (mouseY >= rY) && (mouseX <= (rX+256)) && (mouseY <= (rY + 100)))
    {
        result = true;
    }
    
    else 
    {
      result = false;
    }
    
    return result;
    
  }
    
  
  public String checkClick()
  {
    String result = "MENU";
    
    if (buttonContainsMouse(128,384)){result = "RUNNING";} //Option 1
    else if (buttonContainsMouse(640,384)) {result = "INSTRUCTIONS";} //Option 2
    //Option 3 - (128,534)
    //option 4 - (640.534)
    
    return result;
  }
  
}
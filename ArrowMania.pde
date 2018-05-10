//ArrowMania! A game created in processing as a Game Programming Class Final
// April 2018
// Blanchettwa on GitHub 

//Sound is somewhat hit or miss in Processing. Sometimes it works, but sometimes it crashes the Java Virtual Machine.
//Sound does give the best experience.  
import processing.sound.*;
SoundFile song;
SoundFile gameMusic;
SoundFile[] gameSongs;
SoundFile[] menuSongs;

Lifebar playerLife;
GameMenu menu;
GameSystem sys;

//Java's virual machine has been having inconsistency issues for me. Sound may work, but it also may crash the game. Enable at your own risk.
Boolean enableMusic = false;

  PImage wasdInstructions;
  PImage arrowInstructions;
  PImage instruct;

String gameState = "MENU";

void setup()
{
  //Generate the display window. Hopefully, 1024x768 should run on most systems. 
  size(1024,768);

  //Required components for the game to run properly. 
  playerLife = new Lifebar();
  menu = new GameMenu();
  sys = new GameSystem();
    
  //If music is allowed, then load up all the songs. 
  if (enableMusic){  
    menuSongs = new SoundFile[2];
  
    menuSongs[0] = new SoundFile(this,"sounds/Peak.mp3");
    menuSongs[1] = new SoundFile(this,"sounds/Hype.mp3");

    gameSongs = new SoundFile[5];
    gameSongs[0] = new SoundFile(this,"sounds/Peak.mp3");
    gameSongs[1] = new SoundFile(this,"sounds/Hype.mp3");
    gameSongs[2] = new SoundFile(this,"sounds/Don.mp3");
    gameSongs[3] = new SoundFile(this,"sounds/Strike.mp3");
    gameSongs[4] = new SoundFile(this,"sounds/Crisis.mp3");
    playMenuSong();
  }
  
  wasdInstructions = loadImage("sprites/wasdDiagram.png");
  arrowInstructions = loadImage("sprites/arrowDiagram.png");
  instruct = loadImage("sprites/instructionsScreen.jpg");
  
}


void playMenuSong()
{
  int dice = (int)random(1,100);
  
  if (dice < 50){song = menuSongs[0];}
  else {song = menuSongs[1];}

  //Fix for looping to actually work: Play song, stop song, then loop song. 
  song.play();
  song.stop();
  song.loop();
}

void playGameMusic()
{
  int dice = (int)random(0,5);
  if (dice == 5) {dice = 4;}
  gameMusic = gameSongs[dice];
  
  gameMusic.play();
  gameMusic.stop();
  gameMusic.loop();
}

void keyPressed()
{
  //Check the game state and run the appropiate actions. 

  if (gameState == "RUNNING") 
  {
    String action = sys.checkKeys();

    if (action == "HIT") {playerLife.correctHit();}
    else if (action == "MISS") {playerLife.missedHit();}
    else if (action == "COMBO") {playerLife.missedCombo();}
  }
  
  else if (gameState == "INSTRUCTIONS")
  {
    gameState = "MENU";
  }
  
  else if (gameState == "OVER")
  {
    gameState = "MENU";
    if (enableMusic){playMenuSong();}
  }

  
}

void mouseClicked()
{
  if (gameState == "MENU")
  {
    gameState = menu.checkClick();

    if (enableMusic){
      song.stop();
      playGameMusic();
    }
    
    sys.initGame(); 
    playerLife.initHealth();
  }
  
  else if (gameState == "INSTRUCTIONS") {gameState = "MENU";}
  
  else if (gameState == "OVER")
  {
    gameState = "MENU";
    if (enableMusic) {playMenuSong();}
  }
}

void draw()
{
  clear();
  
  //Draw the proper elements based on the game state
  if (gameState == "MENU") { menu.drawMenu(); }
  
  else if (gameState == "INSTRUCTIONS") { image(instruct,0,0); }

  else if (gameState == "RUNNING") 
  {
    //Draw the game elements

    //Recieve constant information on the status of the game (if an arrow has touched the center)
    String status;
    status = sys.drawRunningGame();
    
    if (status == "MISS") {playerLife.missedHit();}
    else if (status == "COMBO") {playerLife.missedCombo();}

    //Draw the UI
    playerLife.drawBar();
    drawScore();

    //Check the lifebar for death
    float hp = playerLife.getLifeNum();

    if (hp <= 0)
    {
      gameState = "OVER";
      if (enableMusic){gameMusic.stop();}
    }

  }
  
  else if (gameState == "OVER") 
  {
    fill(150,10,10);
    textSize(60);
    text("Game Over",256,192);

    textSize(30);
    fill(255,255,255);
    text(sys.getBestStreak(),384,384);
    text("Press any key to continue",512,576);
  }
}

void drawScore()
{
  //Life num
  textSize(30);
  float hp = playerLife.getLifeNum();
  
  //Determine the color of the health text
  // 0 - 100 : RED |  200 - 800 : GREEN | 800+ : BLUE
  if (hp < 100){ fill(255,20,20);}
  else if (hp < 200) {fill (200,200,0);}
  else if (hp < 800) {fill(0,255,0);}
  else {fill(0,255,255);}
  
  hp = int(hp);
  text("HP: " + hp,10,80);
  
  //Streak Score
  fill(255,255,255);
  textSize(30);
  text(sys.getStreak(),10,120);
  
  //Game ratio
  text(sys.getRatio(), 10 , 160);
  
    //Draw instructions
  image(wasdInstructions,350,415);
  image(arrowInstructions,522,415);
  }
  

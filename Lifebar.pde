public class Lifebar
{
  float life = 800;

  //In pixels per second
  float decay = .0025;

  //Correct hit point add
  float hitAdd = 40;

  
  public Lifebar(){}
  
  public float getLifeNum(){return life;}
  
  public void initHealth(){life = 800;}
  
  public void correctHit()
  {
    life += hitAdd;
    if (life > 1200) {life = 1200;}
  }
  
  public void missedHit()
  {
    life = life * .80;
    if (life < 0) {life = 0;}
  }
  
  public void missedCombo()
  {
    life = life * .42;
    if (life < 0) {life = 0;}
  }
  
  public void barDecay()
  {
    life -= (frameRate*decay);  
    if (life < 0) {life = 0;}
  }
  
  public void drawBar()
  {
    barDecay();
    noStroke();

    if (life < 100){fill(100,0,0);}
    else if (life < 200){fill(50,100,0);}
    else if (life < 800){fill(0,200,0);}
    else {fill(0,250,250);}
  
    rect(0,0,life,50);
  }
}
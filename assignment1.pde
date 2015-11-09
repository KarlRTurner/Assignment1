void setup()
{
  size(800,450);
  ArrayList<ArrayList<Float>> data = new ArrayList<ArrayList<Float>> ();
  String[] lines =loadStrings("cars.csv");
  
  println();
  for (int i=0;i<19;i++)
  {
      String[] list = split(lines[i], ',');
      if(i>0)
      {
        for (int j=0; j<18;j++)
        {
          data.add(new ArrayList<Float>());
          data.get(j).add(Float.parseFloat(list[j]));
        }
      }
  }
  println(data.size());
  for(int i=0;i<18;i++)
  {
      for(int j=0;j<18;j++)
      {
        println(data.get(i).get(j));
      }
  }
  
  
  menuW = width/5;
  
   butH =height/15f;
   butW = menuW/1.5;
   origin= menuW/2f-butW/2f;
   bpress=false;
}
  float menuW;
  float butH;
  float butW;
  float origin;
  boolean bpress;
void draw()
{
  color BG = color(255);
  background (BG);
  menuAnimation();
}

void menuAnimation()
{
  color menucol = color(0,0,0);
  fill(menucol);
  stroke(menucol);
  rect(0,0,menuW,height);
 if(bpress==true)
  {
    menuW-=7;
  }
  else
  {
    if(menuW<width/5)
    {
      menuW+=7;
    }
    else
    {
      showmenu(menuW);
    }
  } 
  
}

void showmenu(float mwid)
{
  fill(0,255,0);
  
  stroke(0,255,0);
  rect(origin,butH,butW,butH);
  
  rect(origin,butH*3,butW,butH);


}

void mousePressed()
{
   if(origin+butW >mouseX && butH*2 > mouseY && origin < mouseX && butH < mouseY)
   {
     bpress=!bpress;
   }
}

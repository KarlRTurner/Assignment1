void setup()
{
  size(800,450);
  loadData();

}

ArrayList<Registered> cars = new ArrayList<Registered>();

void loadData()
{
  String[] lines = loadStrings("vehicles.csv");
  
  for (int i=1; i<lines.length; i++)
  {
    cars.add(new Registered(lines[i]));
  }
  
}

void draw()
{
  color BG = color(255);
  background (BG);
  fill(0);
  float padup = height/10f;
  float padin =width/10f;
  float vertinc=(height-(padup*2))/17;
  float horzinc=(width-(padin*2))/17;
  int press;
  
  press=(key-'0');
      if(press>-1 && press<19)
      {
        drawLineGraph(padin,padup,vertinc,horzinc,press);
      }
    
 
  axis(padin,padup,vertinc,horzinc);    
}


void axis(float padin, float padup, float vertinc, float horzinc)
{
  //draw the x and y axis
  stroke(0);
  line(padin,padup,padin,height-padup);
  line(padin, height-padup, width-padin, height-padup);
  textAlign(CENTER);

  for(int i=0;i< 18;i++)
  {
    line(padin,padup+(vertinc*i),padin-5,padup+(vertinc*i));
    line(padin+(horzinc*i),height-padup,padin+(horzinc*i),height-padup+5);
    
    text(i+1997,padin+(horzinc*i),height-padup+20);
  }
  
}

void drawLineGraph(float padin, float padup, float vertinc, float horzinc, int select )
{
    stroke(0,155,255);
    float x = padin;  
    float Xinc = (width-padin*2)/(cars.size()-1);
    int max = maxi(select);
    int min = mini(select);
    
    textAlign(CENTER);    
    text(cars.get(select).type, width/2,padup);
    textAlign(RIGHT);
    text(cars.get(select).amount[max],padin-5,padup);
    text('0',padin-5,height-padup);
    
    
    float numdec = cars.get(select).amount[max]/17f;

    
    for(int k=1;k<cars.size();k++)
    {
      float y1 = map(cars.get(select).amount[k], 0, cars.get(select).amount[max],  -padup, -(height-padup));
      float y2 = map(cars.get(select).amount[k-1],0, cars.get(select).amount[max],  -padup, -(height-padup));
      line(x,height+y2,x+Xinc,height+y1);
      
      text(round(cars.get(select).amount[max]-(numdec*k)), padin-5,padup+(vertinc*k));
      x+=Xinc;
    }
  
}

//find maximum
int maxi(int sel)
{
  int maxi=0;
  for(int i=0;i<cars.size();i++)
  {
    if(cars.get(sel).amount[maxi]<cars.get(sel).amount[i])
    {
      maxi=i;
    }
  }
  return maxi;
}

//find minimum
int mini (int sel)
{
  int mini=0;
  for(int i=0;i<cars.size();i++)
  {
    if(cars.get(sel).amount[mini]>cars.get(sel).amount[i])
    {
      mini=i;
    }
  }
  return mini;
}




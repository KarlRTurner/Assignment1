void setup()
{
  //size(800, 450);
  size(1600, 900);
  loadData();

  for (int i=0; i<18; i++)
  {
    colour[i]= color(0, random(10, 255), random(10, 255));
  }
  len=18;
  barmov=width;
  tremov=-width;
  press=0;
  menumov=0;
  grph=0;
  counter=0;
  display=0;
  graph=2;
  vertmov3= -height;
  vertmov2= height;
  vertmov1=0;
  trendmove=0;
}

int press;
int display;
int grph=0;
int counter=0;
int selection=0;
int graph;
int trendmove;
float len;
float vertmov1;
float vertmov2;
float vertmov3;
float barmov;
float tremov;
float menumov;
ArrayList<Registered> cars = new ArrayList<Registered>();
color colour[] = new color[18];

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
  
  background (#e1e1e1);
  fill(0);
  float padup = height/10f;
  float padin =width/10f;
  float vertinc=(height-(padup*2))/(len-1f);
  float horzinc=(width-(padin*2))/(len-1f);
  
  
  if(display==0 && trendmove==0)
  {
    println(press, menumov);
    pushMatrix();
    translate(menumov,0);
    if (selection==0)
    {
      if(press==2)
      {
        menumov-=width/25f;
      }
      if(press==1)
      {
        menumov+=width/25f;
      }
      if (press==0)
      {
        menumov=0;
      }
    }
    else
    {
      if(selection==2)
      {
        menumov+=width/25f;
      }
      if(selection==1)
      {
        menumov-=width/25f;
      }
    }
      counter++;
       if (counter ==60)
       {
        counter=0;
        grph++;
        if(grph==cars.size())
        {
          grph=0;
        }
       }
        Menu();
      
        pushMatrix();
          translate(width/2, height/3);
          scale(0.333, 0.333);
          textSize(11);
          axis(padin, padup);
          drawBarGraph(padin, padup, vertinc, horzinc);
        popMatrix();
       
        pushMatrix();
          translate((width/2)+(-width/3), height/3);
          scale(0.333, 0.333);
          axis(padin, padup);
          drawTrendGraph(padin, padup, vertinc, grph);
        popMatrix();
      popMatrix();
    
  }

  if(selection==0)
  {
    if(display>0)
    {
      press=display;
    }
    display=0;
    pushMatrix();
      
      if(press==1)
      {
        translate(barmov, 0);
        
        drawBarGraph(padin, padup, vertinc, horzinc);
        axis(padin, padup);
      }
      if(press==2)
      {
        translate(tremov, 0);
        
        drawTrendGraph(padin, padup, vertinc, graph);
        axis(padin, padup);
      }
      popMatrix();
      
      if(press==1)
      {
        barmov+=width/25f;
      }
      if(press==2)
      {
        tremov-=width/25f;
      }
      
      if (barmov>width)
      {
        barmov=width;
        press=0;
      }
      if (tremov<(-width))
      {
        tremov=-width;
        press=0;
      }
  }
  
  if(selection>0 && display==0 && trendmove==0)
  {
      pushMatrix();
      
      if(selection==1)
      {
        translate(barmov, 0);
        axis(padin, padup);
        drawBarGraph(padin, padup, vertinc, horzinc);
        
      }
      if(selection==2)
      {
        translate(tremov, 0);
        axis(padin, padup);
        drawTrendGraph(padin, padup, vertinc, graph);
      }
      popMatrix();
      
      if(selection==1)
      {
        barmov-=width/25f;
      }
      if(selection==2)
      {
        tremov+=width/25f;
      }
      
      if (barmov<0)
      {
        barmov=0;
        display=1;
      }
      if (tremov>0)
      {
        
        tremov=0;
        display=2;
      }
  }
  if(trendmove>0)
  {
    changetrend(padin, padup, vertinc);
  }
  

  if (selection==1 && display==1)
  {
    drawBarGraph(padin, padup, vertinc, horzinc);
    axis(padin, padup);
    
    strokeWeight( 5 );
    line(20,height/2, 30 , height/2 + height/50);
    line(20,height/2, 30 , height/2 - height/50);
    strokeWeight( 1 );
  }
  if (selection==2 && display==2)
  {
    drawTrendGraph(padin, padup, vertinc, graph);
    axis(padin, padup);
    
    strokeWeight( 5 );
    //back arrow
    line(width-20,height/2, width-30 , height/2 + height/50);
    line(width-20,height/2, width-30 , height/2 - height/50);
    
    //down arrow
    line(width/2, height-20, width/2 + height/50, height-30);
    line(width/2, height-20, width/2 - height/50, height-30);
    
    //up arrow
    line(width/2, 20, width/2 + height/50, 30);
    line(width/2, 20, width/2 - height/50, 30);
    
    strokeWeight( 1 );
  }
}

void mousePressed()
{
  if (selection==0)
  {
    if(mouseX> (width/2)-(width/3) && mouseY> height/3 && mouseX < width/2 && mouseY < 2*(height/3))
    {
      selection=2;
    }
    if(mouseX>width/2  && mouseY> height/3 && mouseX < (width/2)+(width/3) && mouseY < 2*(height/3))
    {
      selection=1;
    }
  }
  if(display==2)
  {
    if(mouseX> width/2 - height/45 && mouseY> 0 && mouseX <width/2 + height/45 && mouseY < 40)
    {
      trendmove=2;
      display=0;
      graph++;
      if(graph==cars.size())
      {
        graph=0;
      }
    }
    
    if(mouseX> width/2 - height/45 && mouseY> height-40  && mouseX <width/2 + height/45 && mouseY < height)
    {
      trendmove=1;
      display=0;
      graph--;
      if(graph<0)
      {
        graph=(cars.size()-1);
      }
    }
    
    
    if(mouseX> width-40 && mouseY> height/2 - height/50 && mouseX <width && mouseY < height/2 + height/50)
    {
      selection=0;
    }
  }
  
  if(mouseX> 0 && mouseY> height/2 - height/50 && mouseX < 40 && mouseY < height/2 + height/50 && display==1)
  {
    selection=0;
  }
  
}

void changetrend(float padin , float padup, float vertinc)
{
  if(trendmove==1 && vertmov2>0) 
  {
    
    pushMatrix();
      translate(0,vertmov1);
      axis(padin, padup);
      if (graph>0)
      {
        drawTrendGraph(padin, padup, vertinc, graph-1);
      }
      else
      {
        drawTrendGraph(padin, padup, vertinc, (cars.size()-1));
      }
      vertmov1-=width/25f;
    popMatrix();
    
    pushMatrix();
      translate(0,vertmov2);
      axis(padin, padup);
      drawTrendGraph(padin, padup, vertinc, graph);
      vertmov2-=width/25f;
    popMatrix();
  }
  
  if(trendmove==2 && vertmov3<0) 
  {
    
    pushMatrix();
      translate(0,vertmov1);
      axis(padin, padup);
      if (graph>0)
      {
        drawTrendGraph(padin, padup, vertinc, graph-1);
      }
      else
      {
        drawTrendGraph(padin, padup, vertinc, (cars.size()-1));
      }
      vertmov1+=width/25f;
    popMatrix();
    
    pushMatrix();
      translate(0,vertmov3);
      axis(padin, padup);
      drawTrendGraph(padin, padup, vertinc, graph);
      vertmov3+=width/25f;
    popMatrix();
  }
  if(vertmov3>0)
  {
    trendmove=0;
    vertmov3= -height;
    vertmov1=0;
    display=2;
  }
  
  if(vertmov2<0)
  {
    trendmove=0;
    vertmov2= height;
    vertmov1=0;
    display=2;
  }
}


void axis(float padin, float padup)
{
  //draw the x and y axis
  fill(0);
  stroke(0);
  line(padin, padup, padin, height-padup+5);
  line(padin-5, height-padup, width-padin, height-padup);
  textAlign(CENTER);
}

void drawTrendGraph(float padin, float padup, float vertinc, int select )
{
  fill(0);
  stroke(0, 155, 255);
  float x = padin;  
  float Xinc = (width-padin*2)/(len-1);
  int max = maxi(select);
  float numdec = cars.get(select).amount[max]/(len-1f);

  textAlign(CENTER);    
  text(cars.get(select).type, width/2, padup);

  stroke(0);
  
    for (int i=0; i<len; i++)
    {
      line(padin, height-padup-(vertinc*i), padin-5, height-padup-(vertinc*i));
      line(x, height-padup, x, height-padup+5);
      textAlign(CENTER);  
      text(i+1997, x, height-padup+20);
      textAlign(RIGHT);
      text(round(cars.get(select).amount[max]-(numdec*i)), padin-5, padup+(vertinc*i));
      x+=Xinc;
    }
  

  x = padin;

  stroke(0, 155, 255);
  for (int k=1; k<len; k++)
  {
    float y1 = map(cars.get(select).amount[k], 0, cars.get(select).amount[max], -padup, -(height-padup));
    float y2 = map(cars.get(select).amount[k-1], 0, cars.get(select).amount[max], -padup, -(height-padup));
    line(x, height+y2, x+Xinc, height+y1);
    x+=Xinc;
  }
}

void drawBarGraph(float padin, float padup, float vertinc, float horzinc)
{
  float barw = (width-padin*2f)/(len)*0.75f;
  float gap  = (width-padin*2f)/(len)*0.125f;
  float x = padin+gap;
  int max1 = maxi(0);
  float pos;
  float colkey = (width/2)/cars.size();
  float keypos =colkey*4;
  float numdec = cars.get(0).amount[max1]/(len-1f);
  boolean textpos=true;
  textAlign(LEFT);
  for (int i=2; i< 16; i++)
  {
    if (i!=11)
    {
      stroke(colour[i]);
      fill(colour[i]);
      rect(keypos,padup/4 , colkey*2, colkey);
      //fill(0);
      if(textpos)
      {
        text(cars.get(i).type,keypos,(padup/4)-2);
      }
      else
      {
         text(cars.get(i).type,keypos,(padup/4)+(colkey)+15);
      }
      textpos=!textpos;
      keypos+=colkey*2;
    }
  }

  for (int k=0; k<len; k++)
  {
    pos=0;
    for (int j=2; j<cars.size (); j++)
    {

      if (j!=11)
      {
        float y1 = map(cars.get(j).amount[k], 0, cars.get(0).amount[max1], 0, (padup*2-height));

        stroke(colour[j]);
        fill(colour[j]);
        rect(x, height-padup+pos, barw, y1);


        pos+=y1;
      }
    }
    stroke(0);
    fill(0);
    textAlign(CENTER);
    line(x+barw/2, height-padup, x+barw/2, height-padup+5);
    text(k+1997, x+barw/2, height-padup+20);
    line(padin, height-padup-(vertinc*k), padin-5, height-padup-(vertinc*k));
    textAlign(RIGHT);
    text(round((cars.get(0).amount[max1]-(numdec*k))/1000) + "k", padin-5, padup+(vertinc*k));
    x+=barw+(gap*2);
  }
}

//find maximum
int maxi(int sel)
{
  int maxi=0;
  for (int i=0; i<18; i++)
  {
    if (cars.get(sel).amount[maxi]<cars.get(sel).amount[i])
    {
      maxi=i;
    }
  }
  return maxi;
}

void Menu()
{
  //background(#e1e1e1);
  stroke(#003399);
  
  
  fill(#339966);
  textAlign(CENTER);
  textSize(width/35);
  text("select a graph you want displayed", width/2, height/4);
  fill(#226644);
  textSize(width/25);
  text("Cars Registered in Ireland 1997-2014", width/2, height/10);

  fill(#e1e1e1);
  rect(width/2, height/3, -width/3, height/3);
  rect(width/2, height/3, width/3, height/3);
}



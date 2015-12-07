void setup()
{
  size(1600, 900);
  
  loadData();

  for (int i=0; i<18; i++)
  {
    colour[i]= color(random(50, 200), random(50, 255), random(50, 255));
  }
  
  //intialize all global variables
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

//create all gloal variables
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
//array list of class Registered
ArrayList<Registered> cars = new ArrayList<Registered>();
color colour[] = new color[18];

//load data function which uses the a class to load in the data
void loadData()
{
  String[] lines = loadStrings("vehicles.csv");

  //loop through the data
  for (int i=1; i<lines.length; i++)
  {
    cars.add(new Registered(lines[i]));
  }
}

void draw()
{

  background (#e1e1e1);
  fill(0);
  //all varibles needed to draw the graph to same spec
  float padup = height/10f;
  float padin =width/10f;
  float vertinc=(height-(padup*2))/(len-1f);
  float horzinc=(width-(padin*2))/(len-1f);

  //group of if to deal with the graph to menu animation and menu to graph this if draws the menu
  if (display==0 && trendmove==0)
  {
    pushMatrix();
    translate(menumov, 0);
    if (selection==0)
    {
      if (press==2)
      {
        menumov-=width/25f;
      }
      if (press==1)
      {
        menumov+=width/25f;
      }
      if (press==0)
      {
        menumov=0;
      }
    } else
    {
      if (selection==2)
      {
        menumov+=width/25f;
      }
      if (selection==1)
      {
        menumov-=width/25f;
      }
    }
    //have the graohs cycle on the menu page
    counter++;
    if (counter ==60)
    {
      counter=0;
      grph++;
      if (grph==cars.size())
      {
        grph=0;
      }
    }
    Menu();
  
    //draw the mini bar chart on the menu
    pushMatrix();
    translate(width/2, height/3);
    scale(0.333, 0.333);
    textSize(24);
    axis(padin, padup);
    drawBarGraph(padin, padup, vertinc, horzinc);
    popMatrix();

    //draw the mini line chart on the menu
    pushMatrix();
    translate((width/2)+(-width/3), height/3);
    scale(0.333, 0.333);
    axis(padin, padup);
    drawTrendGraph(padin, padup, vertinc, grph);
    popMatrix();
    popMatrix();
  }

  //if statement to draw the graphs leaving the screen
  if (selection==0)
  {
    if (display>0)
    {
      press=display;
    }
    display=0;
    pushMatrix();

    if (press==1)
    {
      translate(barmov, 0);

      drawBarGraph(padin, padup, vertinc, horzinc);
      axis(padin, padup);
    }
    if (press==2)
    {
      translate(tremov, 0);

      drawTrendGraph(padin, padup, vertinc, graph);
      axis(padin, padup);
    }
    popMatrix();

    if (press==1)
    {
      barmov+=width/25f;
    }
    if (press==2)
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

  //render the graphs coming into the screen
  if (selection>0 && display==0 && trendmove==0)
  {
    pushMatrix();

    if (selection==1)
    {
      translate(barmov, 0);
      axis(padin, padup);
      drawBarGraph(padin, padup, vertinc, horzinc);
    }
    if (selection==2)
    {
      translate(tremov, 0);
      axis(padin, padup);
      drawTrendGraph(padin, padup, vertinc, graph);
    }
    popMatrix();

    if (selection==1)
    {
      barmov-=width/25f;
    }
    if (selection==2)
    {
      tremov+=width/25f;
    }
    
    //these 2 if are used to see if the animation is over, then sets display so it displays a static
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
  
  //if the trend graph ahs been told to change trend move will be > than 0
  if (trendmove>0)
  {
    // call the function to have trend graphs change
    changetrend(padin, padup, vertinc);
  }

  //if akk aniamations are finished and was asked to display the bar chart
  if (selection==1 && display==1)
  {
    //display a satic bar chart
    drawBarGraph(padin, padup, vertinc, horzinc);
    axis(padin, padup);

    //arrows to indicate where to click for the controls
    strokeWeight( 5 );
    line(20, height/2, 30, height/2 + height/50);
    line(20, height/2, 30, height/2 - height/50);
    strokeWeight( 1 );
  }
  
  //if all aniamations are finished and was asked to display the trend graph
  if (selection==2 && display==2)
  {
    //display a satic trend chart
    drawTrendGraph(padin, padup, vertinc, graph);
    axis(padin, padup);

    //arrows to indicate where to click for the controls
    strokeWeight( 5 );
    //back arrow
    line(width-20, height/2, width-30, height/2 + height/50);
    line(width-20, height/2, width-30, height/2 - height/50);

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
  // all mouse press loactions used for naviagtion
  if (selection==0)
  {
    if (mouseX> (width/2)-(width/3) && mouseY> height/3 && mouseX < width/2 && mouseY < 2*(height/3))
    {
      selection=2;
    }
    if (mouseX>width/2  && mouseY> height/3 && mouseX < (width/2)+(width/3) && mouseY < 2*(height/3))
    {
      selection=1;
    }
  }
  
  //ones for trend graphs  
  if (display==2)
  {
    if (mouseX> width/2 - height/45 && mouseY> 0 && mouseX <width/2 + height/45 && mouseY < 40)
    {
      trendmove=2;
      display=0;
      graph++;
      if (graph==cars.size())
      {
        graph=0;
      }
    }

    if (mouseX> width/2 - height/45 && mouseY> height-40  && mouseX <width/2 + height/45 && mouseY < height)
    {
      trendmove=1;
      display=0;
      graph--;
      if (graph<0)
      {
        graph=(cars.size()-1);
      }
    }


    if (mouseX> width-40 && mouseY> height/2 - height/50 && mouseX <width && mouseY < height/2 + height/50)
    {
      selection=0;
    }
  }

  //bar chart back button
  if (mouseX> 0 && mouseY> height/2 - height/50 && mouseX < 40 && mouseY < height/2 + height/50 && display==1)
  {
    selection=0;
  }
}

void changetrend(float padin, float padup, float vertinc)
{
  
  //if to see which way to change the graphs either up or down
  if (trendmove==1 && vertmov2>0) 
  {
    //the move old graph out
    pushMatrix();
    translate(0, vertmov1);
    axis(padin, padup);
    
    //draw the previous graph after the graph varible has been changed
    if (graph<(cars.size()-1))
    {
      drawTrendGraph(padin, padup, vertinc, graph+1);
    } else
    {
      drawTrendGraph(padin, padup, vertinc, 0);
    }
    vertmov1-=width/25f;
    popMatrix();
    
    //push new graoh to be displayed into the screen
    pushMatrix();
    translate(0, vertmov2);
    axis(padin, padup);
    drawTrendGraph(padin, padup, vertinc, graph);
    vertmov2-=width/25f;
    popMatrix();
  }

  //identical to last if only move graph up and out and have next graph
  if (trendmove==2 && vertmov3<0) 
  {

    pushMatrix();
    translate(0, vertmov1);
    axis(padin, padup);
    if (graph>0)
    {
      drawTrendGraph(padin, padup, vertinc, graph-1);
    } else
    {
      drawTrendGraph(padin, padup, vertinc, (cars.size()-1));
    }
    vertmov1+=width/25f;
    popMatrix();

    pushMatrix();
    translate(0, vertmov3);
    axis(padin, padup);
    drawTrendGraph(padin, padup, vertinc, graph);
    vertmov3+=width/25f;
    popMatrix();
  }
  //check if graph moving fro the top has reached 0 then reset it to -height
  if (vertmov3>0)
  {
    trendmove=0;
    vertmov3= -height;
    vertmov1=0;
    display=2;
  }
   //check if graph moving fro the bottom has reached 0 then reset it to height
  if (vertmov2<0)
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
  strokeWeight( 2 );
  line(padin, padup, padin, height-padup+5);
  line(padin-5, height-padup, width-padin, height-padup);
  strokeWeight( 1 );
}

void drawTrendGraph(float padin, float padup, float vertinc, int select )
{
  fill(0);
  stroke(0, 155, 255);
  float x = padin;  
  float Xinc = (width-padin*2)/(len-1);
  int max = maxi(select);
  float numdec = cars.get(select).amount[max]/(len-1f);
  
  //write title of the graph
  textAlign(CENTER);    
  text(cars.get(select).type, width/2, padup);

  //draw the values and marks on the axis
  stroke(0);
  strokeWeight( 2 );
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
  strokeWeight( 3 );

  x = padin;

  //draw the line graph
  stroke(0, 155, 255);
  for (int k=1; k<len; k++)
  {
    float y1 = map(cars.get(select).amount[k], 0, cars.get(select).amount[max], -padup, -(height-padup));
    float y2 = map(cars.get(select).amount[k-1], 0, cars.get(select).amount[max], -padup, -(height-padup));
    line(x, height+y2, x+Xinc, height+y1);
    x+=Xinc;
  }
  strokeWeight( 1 );
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
  
  textSize(11);
  textAlign(LEFT);
  
  //draw the colour key for the graph and label each
  for (int i=2; i< 16; i++)
  {
    if (i!=11)
    {
      stroke(colour[i]);
      fill(colour[i]);
      rect(keypos, padup/4, colkey*2, colkey);
      if (textpos)
      {
        text(cars.get(i).type, keypos, (padup/4)-2);
      } else
      {
        text(cars.get(i).type, keypos, (padup/4)+(colkey)+15);
      }
      textpos=!textpos;
      keypos+=colkey*2;
    }
  }
  
  // draw the bars
  textSize(14);
  strokeWeight( 2 );
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
    
    //draw the years and values 
    textAlign(CENTER);
    line(x+barw/2, height-padup, x+barw/2, height-padup+5);
    text(k+1997, x+barw/2, height-padup+20);
    
    textAlign(RIGHT);
    line(padin, height-padup-(vertinc*k), padin-5, height-padup-(vertinc*k));
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
  //draw the menu box and title and sub head
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


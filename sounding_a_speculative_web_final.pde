import oscP5.*;
import netP5.*;

//ArrayList<Circle> circles;
Circle[] circles = new Circle[5];
int numChildren = 6;

OscP5 oscP5;
NetAddress server;

int xPos;
int yPos;
float radius = 600;
float size = 40;

FloatList radiI;
FloatList sizeI;
float[] spiralRadius;
float[] spiralSize;

String[] touchMessage = {"/touch/1", "/touch/2", "/touch/3", "/touch/4", "/touch/5", "/touch/6"};
OscMessage[] tchMsg = new OscMessage[6];

boolean clicked = false;
int clickTime = 0;

String loremIpsum = "lorem ipsum";
int strL = loremIpsum.length();
float delta = TWO_PI / strL;
int ispsumRadius = strL * 10;
char[] letters = new char[0];

ArrayList<LoremIpsum> ipsumCircles;

String bigTechText = "in the big tech internet, noise must be filtered out for maximal functionality and efficiency";
String noisText = "noise therefore, is the foremost presentation of opposition";

void setup()
{
  fullScreen();
  //noCursor();
  background(#FF81F7);
  //background(#FFFE79);
  
  xPos = displayWidth / 2;  
  yPos = displayHeight / 2;
  
  //circles = new ArrayList<Circle>();
  radiI = new FloatList();
  sizeI = new FloatList();
  
  oscP5 = new OscP5(this, 7575);
  server = new NetAddress("192.168.0.11", 3743);
  
  float newRadius = radius;
  float newSize = size;
  //recursive(newRadius, newSize);
  
  ipsumCircles = new ArrayList<LoremIpsum>();
  
  for (int i = 0; i < numChildren; i++)
  {
    if (radius > 180)        // recursive circle parameters
    {
      radius = recursiveRadius(newRadius);
      size = recursiveSize(newSize);
      newRadius = radius;
      radiI.set(i, newRadius);
      newSize = size;
      sizeI.set(i, newSize);
      println(radius);
    }
  }
  
  spiralRadius = radiI.array();
  spiralSize = sizeI.array();
  
  for (int i = 0; i < spiralRadius.length; i++)
  {
    //circles.add(new Circle(xPos, yPos, spiralRadius[i], spiralSize[i]));
    circles[i] = new Circle(xPos, yPos, spiralRadius[i], spiralSize[i]);
  }
  
  for (int i = 0; i < 10; i++)
  {
    //if (radius > 180)
    //{
      radius = recursiveRadius(newRadius);
      size = recursiveSize(newSize);
      newRadius = radius;
      newSize = size;
      //println(radius);
      //circles.add(new Circle(xPos, yPos, radius, size));
      ipsumCircles.add(new LoremIpsum(xPos, yPos, radius));
    //}
  }
  
  for(int j = 0; j < strL; j++)
  {
    letters = append(letters, char(loremIpsum.charAt(j)));
  }
  
  textAlign(CENTER);
}


float recursiveRadius(float newRadius)
{
  return newRadius * 0.75f;
}

float recursiveSize(float newSize)
{
  return newSize * 0.75f;
}


void draw()
{
  float mX = mouseX;
  float mY = mouseY;
  //for (Circle circ : circles)
  for (int i = 0; i < circles.length; i++) 
  {
    circles[i].drawCircle();
    circles[i].onCollision(mX, mY);
    
    int[] values = {6, 5, 4, 3, 2, 1};
    //IntList intD;
    
    float d;
    //FloatList d;
    //FloatList tX;
    //FloatList tY;
    
    //d = new FloatList();
    //tX = new FloatList();
    //tY = new FloatList();
    //intD = new IntList();
    
    mX = mouseX;
    mY = mouseY; 
    
    
    //SimpleTouchEvt touches[] = touchscreen.touches();
    
    //for (int i = 0; i < touches.length; i++)
    //{
    //  tchMsg[i] = new OscMessage(touchMessage[i]);
      
    //  tX.set(i, (map(touches[i].x, 0.0, 1.0, 0.0, displayWidth))); 
    //  tY.set(i, (map(touches[i].y, 0.0, 1.0, 0.0, displayHeight))); 
      //println("touch x = " + tX);
      //println("touch y = " + tY);
    
      d = (dist(mX, mY, x, y));
      //d.set(i, (dist((tX.get(i)), (tY.get(i)), x, y)));
      //intD.set(i, (int(d.get(i))));
      
      //if ((d.get(i)) < 450 / 2)
      if (d < 450 / 2)
      {
        //if ((tX.get(i)) > x - (newRadius[i] / 2) && (tX.get(i)) < x + (newRadius[i] / 2) && 
        //    (tY.get(i)) < y + (newRadius[i] / 2) && (tY.get(i)) > y - (newRadius[i] / 2))
        //if (d > x - (newRadius[i] / 2) && d < x + (newRadius[i] / 2) && 
        //    d < y + (newRadius[i] / 2) && d > y - (newRadius[i] / 2))
        for (int ii = 0; ii < spiralRadius.length; ii++) 
        {
          //if (clickTime + (1 * 500) < millis())
          //{
            //if (tchMsg[i].get(1) != null)
            // {
            //   println("set");
            //   tchMsg[i].clear();
            // }
             clicked = false;
             if (mousePressed)
             { 
               //oscSend(intD[i]);
               //tchMsg[i].add(intD.get(i));
               //oscP5.send(tchMsg[i], server);
               clickTime = millis();
               //clicked = true;
               //if ((tX.get(i)) > x - (newRadius[i] / 2) && (tX.get(i)) < x + (newRadius[i] / 2) && 
               //    (tY.get(i)) < y + (newRadius[i] / 2) && (tY.get(i)) > y - (newRadius[i] / 2))
               if (mX > x - (spiralRadius[ii]) && mX < x + (spiralRadius[ii]) && 
                   mY < y + (spiralRadius[ii]) && mY > y - (spiralRadius[ii]))
               {
                 interactColour();
                 println("mouse = " + d);
                 println("clicked = " + ii);
               }
             //}
          //}
        }
      }
    }
  }
  
  for (LoremIpsum txt : ipsumCircles)
  {
    txt.display();
  }
}


class Circle
{
  int x;
  int y;
  float r;
  float s;
  color c;
  
  private int rndColour()
  {
    return (floor(random(125, 225)));
  }
  
  Circle(int xPos, int yPos, float radius, float size)
  {
    x = xPos;
    y = yPos;
    r = radius;
    s = size;
    
    //c = color(#FF79B1);
    c = color(#39FFAA);
  }
  
  void drawCircle()
  {
    noFill();
    strokeWeight(s);
    stroke(c);
    ellipse(x, y, r, r);
  }
  
  void onCollision(float mX, float mY)
  {
    
  }
  
  int interactColour()
  {
    c = color(255);
    return c;
  }
}


class LoremIpsum
{
  int x;
  int y;
  float r;
  
  LoremIpsum(int xPos, int yPos, float radius)
  {
    x = xPos;
    y = yPos;
    r = radius;
    //s = size;
  }
  
  void display()
  {
    smooth();
    translate(width / 2, height / 2);
    
    float arclength = 0f;
    
    //println("text");
    
    float angleStep = 360 / strL;
    for (int i = 0; i < strL; i++)
    {
      char currentChar = loremIpsum.charAt(i);
      float w = textWidth(currentChar); 
      arclength += w / 2;
      float theta = PI + arclength / r;
      //float myAng = i * angleStep;
      pushMatrix();
        translate(r * cos(theta), r * sin(theta)); 
        rotate(theta + PI / 2); 
        //float xPos = width / 2 + ispsumRadius * cos(i * delta);
        //float yPos = height / 2 + ispsumRadius * sin(1 * delta);
       
        //float xPos = sin(radians(180 - myAng)) * 40;
        //float yPos = cos(radians(180 - myAng)) * 40;
        //translate(xPos, yPos);
        //rotate(delta * i);
        fill(255);
        text(currentChar, 0, 0);
      popMatrix();  
    }
  }
}

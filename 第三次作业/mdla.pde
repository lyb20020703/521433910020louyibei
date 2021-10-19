//click the mouse to get the patterns
float hi,wi,h,xPos,yPos;
int wida,heia;
void setup()
{size(1000,1000);
h=50;
hi=random(0,height/2);}  
void draw()
{if(mousePressed==true)
{  hi=0;
wi=0;
h=350;
mdla();}}
void mdla()
{
  for(float i=50;i<=width;i=i+wi)
{ wi=random(0,width/5);
hi=random(0,height/5);
    stroke(0,0,0);
    strokeWeight(15); i+=wi;
 if(i>h)
{wida=int(random(i/2,i));
 rect(xPos,yPos,i-wida,h);
 fill(random(180,255));
 rect(xPos+i-wida,yPos,wida,h);}
 if(i<h)
{heia=int(random(h/2,h));
 rect(xPos,yPos,i,h-heia);
 fill(random(0,105));
 rect(xPos,yPos+h-heia,i,heia); }
 if(i==h)
{fill(random(0,200));
 rect(xPos,yPos,i,h);}
if(xPos>=width)
{xPos=0;yPos+=h;h+=hi; }
 else { xPos+=i; } }}
 

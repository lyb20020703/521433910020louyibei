PFont font;
color[]c={#1A3DB7,#7F96E5,#4871FF,#41B0E5,#30B8FA};
int x1,y1,r1,red1,green1,blue1;
float[] x = new float[100];
float[] y = new float[100];
float[] speed = new float[100];
float[] r = new float[100];
String []s;
void setup()
{size(1000,1000);
background(255);
font=loadFont(  "BrushScriptStd-48.vlw"  );
frameRate(2);
s=loadStrings("RAIN.txt");}
void draw()
{background(255);
int  i=0;
  while(i < s.length) {
x[i]=random(0,width);
y[i]=random(0,height);
speed[i]=random(10,30);
r[i]=random(30,80);
frameRate(1);
rain(i,int(x[i]),int( y[i]),int(r[i]));
 y[i] = y[i] + speed[i];
 if(y[i] >height) {
 y[i] = 0; }
  i = i + 1;}}
void rain(int i1,int x2,int y2,int rad)
{textSize(rad);
String x=s[i1];
fill(c[int(random(0,4))],random(0,255));
textFont(font);
text(x,x2,y2);
}

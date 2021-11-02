float amplitude=100;
float angle=random(10);
color [] a={#A1F5D9,#A1BDF5,#D3A1F5,#F5A1C1,#F4F5A,#CBCBC9,#AFAFAF};
void setup()
{
size(600,600);
background(0);
}
void draw()
{
//background(255);
float x=amplitude*cos(angle);
float y=amplitude*sin(angle);
float xx=x*random(1);
float yy=y*random(1);
stroke(0);
fill(a[int(random(0,6))]);
translate(mouseX,mouseY);
stroke(-1);
line(0,0,xx,yy);
noStroke();
ellipse(xx,yy,20,20);
angle+=random(0.1);
}

float rr,gg,bb,dd;
float sp,lw,alpha;
void setup()
{
size(600,800);
background(255);
}
void draw()
{
cl();
pattern();
}
void pattern()
{fill(rr,gg,bb,alpha);
noStroke();
arc(mouseX,mouseY,lw,lw,QUARTER_PI,PI);
if(mousePressed){
arc(mouseX+10,mouseY,random(5,15),random(5,15),QUARTER_PI,PI);
arc(mouseX,mouseY+10,random(10,20),random(10,20),QUARTER_PI,PI);
arc(mouseX+10,mouseY+10,random(5,10),lw,QUARTER_PI,PI);
arc(mouseX+30,mouseY+10,lw,random(5,10),QUARTER_PI,PI);
arc(mouseX+10,mouseY+20,random(5,15),lw,QUARTER_PI,PI);
arc(mouseX+20,mouseY+10,lw,lw,QUARTER_PI,PI);
}
if(keyPressed){
rect(mouseX+10,mouseY,random(5,15),random(5,15));
rect(mouseX,mouseY+10,random(10,15),random(10,20));
rect(mouseX+10,mouseY+10,random(5,10),lw);
rect(mouseX+30,mouseY+10,lw,random(5,10));
rect(mouseX+10,mouseY+20,random(5,10),lw);
rect(mouseX+20,mouseY+10,lw,lw);

}
}

void cl()
{rr=map(mouseX,0,width,0,255);
gg=map(mouseY,0,height,0,255);
dd=dist(mouseX,mouseY,width/2,height/2);
bb= map(dd,0,500,0,255);
sp=dist(pmouseX,pmouseY,mouseX,mouseY);
lw=map(sp,0,500,10,150);
alpha=map(sp,0,500,100,255);}

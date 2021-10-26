Particle [] p;
void setup(){
  frameRate(35);
  size(600,480);
  p=new Particle[100];
  for (int i=0;i<p.length;i++)
 { p[i]=new Particle();}
 background(255);
}
void draw()
{
 for (int i=0;i<p.length;i++)
 { p[i].drawparticle();
   p[i].checkEdge();}

}

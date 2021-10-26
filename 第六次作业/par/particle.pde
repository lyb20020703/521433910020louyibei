class Particle{
PVector location;
PVector velocity;
float psize;
color [] a={#A1F5D9,#A1BDF5,#D3A1F5,#F5A1C1,#F4F5A,#CBCBC9,#AFAFAF};
Particle(){
location=new PVector(random(width),random(height));
velocity=new PVector(random(-1,1),random(-1,1));

psize=random(10,20);

}

void drawparticle()
{
noStroke();
location.add(velocity);
fill(a[int(random(0,6))]);
rect(location.x,location.y,psize,psize);
if(mousePressed==true){
PVector m=new PVector(mouseX,mouseY);
PVector w=PVector.sub(m,location);
w.mult(0.2);
location.add(w);

}
}
void checkEdge(){
if(location.x>width||location.x<0){
velocity.x*=-1;}
if(location.y>height||location.y<0){
velocity.y*=-1;
}
}








}

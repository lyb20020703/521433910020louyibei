class Plant extends Creature { 

  Plant(PVector pos, DNA initDNA) {
    super(pos, initDNA);
    float lifetime = getLifetime();
    float speed = getMaxspeed();
   
    float size = getSize();

    lifetime = map(lifetime, 0, 1, 0.5, 1); 
    speed = map(speed, 0, 1, 0.5, 1);
    size = map(size, 0, 1, 0.5, 1);
    setLifetime(lifetime*5);
    setMaxspeed(speed*0.5);
    setSize(size*100);
    health = 100;

    maxLifetime=getLifetime();
    maxSize = getSize();
    maxHealth = health;


    breedProbability = 0.004;
  }

    void display() {
          color [] a={#F5A1C1,#CBCBC9};
    ellipseMode(CENTER);
    noStroke();

    float alpha = map(health, 0, maxHealth, 100, 255);

    r=map(lifetime, maxLifetime, 0, 0, 2*maxSize);
    if (r>maxSize) {
      r = maxSize;
    }
fill(a[int(random(0,1))],random(200));
    ellipse(position.x, position.y, r, r);

    fill(0);
    ellipse(position.x, position.y, 5, 5);
  }

    Plant breed() {
    if (r==maxSize&&random(1) < breedProbability) {
      DNA childDNA = dna.dnaCopy();
      childDNA.mutate(0.01); 
      PVector childPosition = new PVector(random(position.x-100, position.x+100), 
        random(position.y-100, position.y+100));
      return new Plant(childPosition, childDNA);
    } else {
      return null;
    }
  }

    void move() {
    float vx = map(noise(xoff), 0, 1, -maxspeed, maxspeed);
    float vy = map(noise(yoff), 0, 1, -maxspeed, maxspeed);
    velocity = new PVector(vx, vy); 
    xoff += 0.1;
    yoff += 0.1;

    velocity.add(acceleration); 
    velocity.limit(maxspeed);   
    position.add(velocity);  

    acceleration.mult(0);    
  }
    
}

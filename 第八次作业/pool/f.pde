class Fish extends Creature {
  Fish(PVector pos, DNA initDNA) {
    super(pos, initDNA);

    health = 100;
    maxHealth = 100;

    breedProbability = 0.001; 
    matingProbability = 0.01; 

    float lifetime = getLifetime();
    float speed = getMaxspeed();
    float size = getSize();

    lifetime = map(lifetime, 0, 1, 0.5, 1); 
    speed = map(speed, 0, 1, 0.5, 1);
    size = map(size, 0, 1, 0.5, 1);

   
    setLifetime(lifetime*100);
    setMaxspeed(speed*8);
    setSize(size*100);

    maxLifetime=getLifetime();
    maxSize = getSize();

    velocity = new PVector(random(-maxspeed, maxspeed), random(-maxspeed, maxspeed));
    velocity = velocity.limit(maxspeed);
   
    if (random(1)<0.5) {
      gender = true;
    } else {
      gender = false;
    }
    


   
    separateWeight = 2;
    alignWeight = 0;
    cohesionWeight = 0;

    
    isRut = false;
  }

  
    void update() {

    move();
  
    display();

    health -= 0.1; 
    lifetime-=0.01;
    if (health<maxHealth/2) {
      isRut = false;
    }
  }

 
    void display() {
    r = map(lifetime, maxLifetime, 0, 0, 2*maxSize);
    if (r>=maxSize) {
      r = maxSize;
    }
    float theta = velocity.heading2D() + radians(90);
    float alpha = map(health, 0, maxHealth, 100, 255);
    fill(random(255), alpha);
    strokeWeight(1);
    ellipse(0, 0-r/2, r/7, r/7);

  }



    Fish breed() {
    if (isPregnancy && random(1) < breedProbability) {
      DNA childDNA = dna.dnaCross(fatherDNA);
      childDNA.mutate(0.01); 
      return new Fish(position, childDNA);
    } else {
      return null;
    }
  }

    void flock(ArrayList<? extends Creature> Creatures) {
    if (isRut) {
      PVector mat = mating(Creatures);
      PVector sep = separate(Creatures);   
      PVector ali = align(Creatures);    
      PVector coh = cohesion(Creatures);   

      mat.mult(5);
      sep.mult(separateWeight);
      ali.mult(alignWeight);
      coh.mult(cohesionWeight);

      applyForce(mat);
      applyForce(sep);
      applyForce(ali);
      applyForce(coh);
    } else {
      PVector sep = separate(Creatures);   
      PVector ali = align(Creatures);    
      PVector coh = cohesion(Creatures);  

      sep.mult(separateWeight);
      ali.mult(alignWeight);
      coh.mult(cohesionWeight);

      applyForce(sep);
      applyForce(ali);
      applyForce(coh);
    }
  }




    void move() {

    velocity.add(acceleration); 
    velocity.limit(maxspeed);   
    position.add(velocity);
  acceleration.mult(0);    
  }

 
 
  
}

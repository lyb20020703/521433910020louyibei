class Module {
  float _xOffset, _yOffset,_unit, chaUnit;
  int _index;  
  float tt = 0;
  color _color;
  PVector velocity;
  PVector acceleration;  
  float maxspeed;   
  PVector _position ;
  float distance;
  PVector retarget = new PVector(width/4, height/4);
  boolean GGG = true;
  Module(int xOffsetTemp, int yOffsetTemp, float tempUnit, int tempIndex, color tempColor) {
    _xOffset = xOffsetTemp;
    _yOffset = yOffsetTemp; 
    _unit = tempUnit;
    _index = tempIndex;
    _color = tempColor;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, -2);
    _position = new PVector(_xOffset, _yOffset);
    maxspeed = 4;
  }

  void update(float _zhouqi, float xiangwei, float _banjing) {
    chaUnit = (_banjing+_unit)* sin(PI/_zhouqi * tt + _index*(xiangwei/(2*PI)));
    tt++;

    velocity.add(acceleration);
    velocity.limit(maxspeed);
    _position.add(velocity);
    acceleration.mult(0);  
  }

  void display(int isshape, float GG, float wave, int iseffect) {
    fill(_color);
    noStroke();
    pushMatrix();


    if (iseffect==1) {
      translate(_position.x, _position.y);
    } else {
      if (distance<100) {
        translate(_position.x-width/2+_xOffset, _position.y-height/2+_yOffset);
      } else {
        translate(_position.x-width/2+GG, _position.y-height/2+_yOffset);
      }
    }
    translate(0, -wave/2);

    if (isshape==0) {
       arc(0, 0, chaUnit+6, chaUnit+6,QUARTER_PI,PI);
          arc(0, 0, chaUnit, chaUnit,3*QUARTER_PI,PI);
     
    } else {
      rect(0, 0, chaUnit, chaUnit);
    }


    popMatrix();
  }



  void seek(PVector target, int iseffect) {
  

    distance = PVector.sub(target, _position).mag();
  
    if (iseffect==1) {
      if (distance >10 && GGG == true) {
        applyForce(PVector.sub(PVector.sub(target, _position), velocity));
      } else {
        applyForce(PVector.sub(PVector.sub(
          new PVector(_xOffset+target.x-width/2, _yOffset+target.y-height/2), _position), velocity));
        GGG = false;
      }
      if (retarget != target) {
        GGG = true;
      }
      retarget = target;
    } else {
      applyForce(PVector.sub(PVector.sub(target, _position), velocity));  
    }
  }


  void applyForce(PVector force) {

    acceleration.add(force);
  }
}

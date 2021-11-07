class World {

  ArrayList<Plant> plants;
  ArrayList<Fish> fishes;

  World(int plantsNum, int fleasNum, int fishNum) {
    plants = new ArrayList<Plant>();
    for (int i=0; i<plantsNum; i++) {
      PVector pos = new PVector(random(width), random(height));
      plants.add(new Plant(pos, new DNA()));
    }



    fishes = new ArrayList<Fish>();
    for (int i=0; i<fishNum; i++) {
      PVector pos = new PVector(random(width), random(height));
      fishes.add(new Fish(pos, new DNA()));
    }
  }

  void update() {
    for (int i = plants.size()-1; i >= 0; i--) {
      Plant p = plants.get(i);
      p.update();
      if (p.dead()) {
        plants.remove(i);
      }
      Plant newP = p.breed();
      if (newP!=null) {
        plants.add(newP);
      }
    }


   

    for (Fish f : fishes) {
      f.flock(fishes);
   
    }
    for (int i = fishes.size()-1; i >= 0; i--) {
      Fish f = fishes.get(i);
      f.update();
   
      if (f.dead()) {
        fishes.remove(i);
      }
      Fish newP = f.breed();
      if (newP!=null) {
        fishes.add(newP);
      }
    }
  }

  float getFishNum() {
    return fishes.size();
  }



  float getPlantNum() {
    return plants.size();
  }

  void addFish(PVector pvector) {
    fishes.add(new Fish(pvector, new DNA()));
  }



  void addPlant(PVector pvector) {
    plants.add(new Plant(pvector, new DNA()));
  }

  void reduceFish() {
    fishes.remove(0);
  }
  void reducePlant() {
    plants.remove(0);
  }

}

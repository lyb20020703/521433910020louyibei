World world; 


void setup() {
  size(800, 600);
  frameRate(60);

  world = new World(150, 50, 10);
  

}

void draw() {
  background(200);

  world.update();
  textSize(15);
  fill(50);
  text("Plants:" + (int)world.getPlantNum(), 20, 20);
  text("Fishes:" + (int)world.getFishNum(), 20, 40);


  }
  void mouseClicked() {

    if (mouseButton == LEFT) {
      world.addFish(new PVector(mouseX, mouseY));
    } 
    if (mouseButton ==RIGHT) {
      world.reduceFish();
    } 
  }

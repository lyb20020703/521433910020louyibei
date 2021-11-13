import controlP5.*;
import ddf.minim.*;
ControlP5 cp5;
int StartX = 0,StartY = 0;
int UIGroupX = 0;
int UIGroupY = 140;
Group _group;
Module[] mods;  
int gridX = 3;  
int gridY = 3;
int index = 0;  
RadioButton r_shapes, r_effects, r_music;
Toggle t1_shape, t2_shape, t1_effect, t2_effect, t1_music, t2_music;
int isshape = 0;
int iseffects = 0;
int ismusic = 0;
color[] colors = {
  #3C7AE3, #303131,#2D4CA5,#D3A1F5,#797979,#3C7AE3,#CBCBC9,#AFAFAF, 
  #303131, #797979, #FF95B0, #AAA8A9, #AAA8A9, #126AFF, #305CA5, #797979
};
color myTextColor = color(255, 255, 250);  
boolean isFocus = false;

PVector mouse = new PVector(width/2, height/2);
PVector xiangxin = new PVector(width/2, height/2);
float a1 = 0;
float b1 = 0;
float a2 = 0;
float b2 = 0;
float GG = 0;

Minim minim;
AudioPlayer kick;

void setup() {
  size(960, 540);
  startUI();
  createText();
  startModule();
  minim = new Minim(this);
  kick = minim.loadFile("BD.mp3");

}

void draw() {

  background(199,213,237);
  fill(196,216,255);
  noStroke();
  rect(0, 0, width/4, height);

  if (cp5.get(Textfield.class, "_input").isMouseOver()) {   
    isFocus = true;
  } else {                                      
    if (isFocus == true) {                
      createText();
      startModule();
    }
    isFocus = false;
  } 

  for (int i = 0; i < kick.bufferSize() - 1; i++)
  {
    float x1 = map(i, 0, kick.bufferSize(), 0, width);
    float x2 = map(i+1, 0, kick.bufferSize(), 0, width);

       fill(colors[int(random(0,15))],100);
    ellipse(x1, 450 - kick.mix.get(i)*random(1,80),4,3);
  
  }


  float zhouqi = cp5.getController("_zhouqi").getValue();
  float xiangwei = cp5.getController("_xiangwei").getValue();
  float banjing = cp5.getController("_banjing").getValue();
  
  if (!(t1_shape.getState()||t2_shape.getState())) {
    if (isshape==0) t1_shape.setState(true);
    else t2_shape.setState(true);
  }

  if (t1_shape.getState()) {
    isshape = 0;
  }
  if (t2_shape.getState()) {
    isshape = 1;
  }

  if (!(t1_effect.getState()||t2_effect.getState())) {
    if (iseffects==0) t1_effect.setState(true);
    else t2_effect.setState(true);
  }

  if (t1_effect.getState()) {
    iseffects = 0;
  }
  if (t2_effect.getState()) {
    iseffects = 1;
  }

  if (!(t1_music.getState()||t2_music.getState())) {
    if (ismusic==0) t1_music.setState(true);
    else t2_music.setState(true);
  }

  if (t1_music.getState()) {
    ismusic = 0;
    kick.play();
  }
  if (t2_music.getState()) {
    ismusic = 1;
    kick.pause();
  }

  if (mousePressed == true && mouseX>width/4 ) { 
    mouse = new PVector(mouseX, mouseY);
  }
  fill(120,10,30,120);
  noStroke();
  arc(mouse.x,mouse.y,24,30,QUARTER_PI,PI);

  for (int i = 0; i<index; i++) {
    mods[i].seek(mouse, iseffects);

    int j = (int)map(i, 0, index-1, 0, kick.bufferSize()-1);
    float kickmix = 20*kick.mix.get(j/3);

    if (ismusic==1) kickmix = 0;

    mods[i].update(zhouqi, xiangwei, banjing);
    mods[i].display(isshape, map(mods[i]._xOffset, a1, a2, (a2-a1)/random(2, 50)+a1, a2-(a2-a1)/random(2, 50)), kickmix, iseffects);
  }
}

void createText() {
  rectMode(CENTER);
  textFont(createFont("FZSTK.TTF",46));
  textAlign(CENTER);
  textSize(100);
  fill(myTextColor);
  text(cp5.get(Textfield.class, "_input").getText(), width/2,height/2);
}

void startModule() {

  int count = 0;      
  index = 0;  
  for (int i = 0; i<width; i += gridX ) {
    for (int j = 0; j<height; j += gridY ) {
      color c = get(StartX+i, StartY+j); 
      if (c == color(255, 255, 250)) { 
        count++;
      }
    }
  }

  mods = new Module[count];
  for (int i = 0; i<width; i += gridX ) {
    for (int j = 0; j<height; j += gridY ) {
      color c = get(StartX+i, StartY+j); 
      if (c == myTextColor) { 
        mods[index] = new Module(StartX+i, StartY+j, random(-3, 3), index, colors[int(random(0, 15))]); 
        mods[index].update(50, 5, 5);
        mods[index].display(0, 0, 0, iseffects);
        index++;
      }
    }
  }


  a1 =  mods[0]._xOffset;
  b1 =  mods[0]._yOffset;
  a2 =  mods[index-1]._xOffset;
  b2 =  mods[index-1]._yOffset;
}




void startUI() {
  cp5 = new ControlP5(this);
  _group = cp5.addGroup("")
    .setPosition(0, 20)  
    .setWidth(width/4)
    .setHeight(20)
    .setBackgroundHeight(height)
    .setBackgroundColor(color(145,120,200,90))
    ;
  cp5.setColorForeground(color(120, 156,250));
  cp5.setColorBackground(color(207,230,255)); 
  cp5.setFont(createFont("SIMYOU.TTF", 15));
  cp5.setColorCaptionLabel(color(0, 1));

  RadioButton r_shapes;
  r_shapes = cp5.addRadioButton("radioButton")
    .setPosition(50, 25)
    .setSize(70, 35)
    .setColorForeground(color(120,0,0))
    .setColorActive(color(255,0,0))
    .setColorLabel(color(255,0,0))
    .setItemsPerRow(5)
    .setSpacingColumn(0)
    .addItem("cir", 0)
    .addItem("rec", 1)
    .setGroup(_group)
    ;
  t1_shape = r_shapes.getItem("cir");
  t1_shape.setImages(loadImage("button_cir_F.png"), loadImage("button_cir_T.png"), loadImage("button_cir_T.png"));
  t2_shape = r_shapes.getItem("rec");
  t2_shape.setImages(loadImage("button_rec_F.png"), loadImage("button_rec_T.png"), loadImage("button_rec_T.png"));
  r_shapes.activate(0);

  RadioButton r_effects;
  r_effects = cp5.addRadioButton("radioButton2")
    .setPosition(40, 65)
    .setSize(70, 35)
    .setColorForeground(color(120,0,0))
    .setColorActive(color(255,0,0))
    .setColorLabel(color(255,0,0))
    .setItemsPerRow(10)
    .setSpacingColumn(0)
    .addItem("effect1", 0)
    .addItem("effect2", 1)
    .setGroup(_group)
    ;
  t1_effect = r_effects.getItem("effect1");
  t1_effect.setImages(loadImage("button_yi_F.png"), loadImage("button_yi_T.png"), loadImage("button_yi_T.png"));
  t2_effect = r_effects.getItem("effect2");
  t2_effect.setImages(loadImage("button_er_F.png"), loadImage("button_er_T.png"), loadImage("button_er_T.png"));
  r_effects.activate(0);

  RadioButton r_music;
  r_music = cp5.addRadioButton("radioButton3")
    .setPosition(52, 105)
    .setSize(70, 35)
    .setColorForeground(color(120,0,0))
    .setColorActive(color(115,0,0))
    .setColorLabel(color(255,0,0))
    .setItemsPerRow(5)
    .setSpacingColumn(0)
    .addItem("music", 0)
    .addItem("nomusic", 1)
    .setGroup(_group)
    ;
  t1_music = r_music.getItem("music");
  t1_music.setImages(loadImage("button_open_F.png"), loadImage("button_open_T.png"), loadImage("button_open_T.png"));
  t2_music = r_music.getItem("nomusic");
  t2_music.setImages(loadImage("button_close_F.png"), loadImage("button_close_T.png"), loadImage("button_close_T.png"));
  r_music.activate(1);

  cp5.addTextfield("_input")
    .setPosition(UIGroupX, UIGroupY+50)   
    .setSize(200, 30)
    .setText("please input")
    .setGroup(_group)
    ;
  cp5.addSlider("_zhouqi")
    .setPosition(UIGroupX, UIGroupY+130)
    .setSize(200, 20)
    .setRange(1, 100)
    .setValue(50)
    .setGroup(_group)
    ;
  cp5.addSlider("_xiangwei")
    .setPosition(UIGroupX, UIGroupY+210)
    .setSize(200, 20)
    .setRange(0, 2*PI)
    .setValue(5)
    .setGroup(_group)
    ;
  cp5.addSlider("_banjing")
    .setPosition(UIGroupX, UIGroupY+290)
    .setSize(200, 20)
    .setRange(0, 20)
    .setValue(5)
    .setGroup(_group)
    ;



  Textlabel myTextlabelA;
  Textlabel myTextlabelB;
  Textlabel myTextlabelC;
  Textlabel myTextlabelD;
  Textlabel myTextlabelE;
  Textlabel myTextlabelF;
  Textlabel myTextlabelG;
  myTextlabelA = cp5.addTextlabel("_labelA")
    .setText("文字")
    .setPosition(UIGroupX, UIGroupY+25)
    .setColorValue(color(0,14,178))
    .setGroup(_group)
    ;
  myTextlabelB = cp5.addTextlabel("_labelB")
    .setText("周期")
    .setPosition(UIGroupX, UIGroupY+105)
    .setColorValue(color(0,17,214))
    .setGroup(_group)
    ;
  myTextlabelC = cp5.addTextlabel("_labelC")
    .setText("相位")
    .setPosition(UIGroupX, UIGroupY+185)
    .setColorValue(color(0, 13,200))
    .setGroup(_group)
    ;
  myTextlabelD = cp5.addTextlabel("_labelD")
    .setText("半径")
    .setPosition(UIGroupX, UIGroupY+265)
    .setColorValue(color(0,16,120))
    .setGroup(_group)
    ;

  myTextlabelE = cp5.addTextlabel("_labelE")
    .setText("音乐")
    .setPosition(UIGroupX, UIGroupY-30)
    .setColorValue(color(100, 0, 0))
    .setGroup(_group)
    ;

  myTextlabelF = cp5.addTextlabel("_labelF")
    .setText("粒子")
    .setPosition(UIGroupX, UIGroupY-70)
    .setColorValue(color(100, 0, 0))
    .setGroup(_group)
    ;

  myTextlabelG = cp5.addTextlabel("_labelG")
    .setText("形状")
    .setPosition(UIGroupX, UIGroupY-110)
    .setColorValue(color(100, 0, 0))
    .setGroup(_group)
    ;
}

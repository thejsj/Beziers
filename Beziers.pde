import controlP5.*;

boolean firstTime = true;
ArrayList<Object> objects;
int multiplication_index = 20;

ControlP5 cp5;
float Attraction_value = 0.32; 
float Damping_value = 0.59; 
Slider attraction_slider;
Slider damping_slider;

// Object - Bezier Rotation Points
float radius = 100;
int numPoints = 100;
float angle = TWO_PI/(float)numPoints;

void setup(){
  colorMode(HSB, 100);
  size(1000,600);
  background(0,0,0);
  frameRate(60);
  // Add Slider
  cp5 = new ControlP5(this);
  cp5.addSlider("Attraction_value")
     .setPosition(10,10)
     .setRange(0,2)
     .setSize(200,50)
     .setValue(Attraction_value)
     ;
   cp5.addSlider("Damping_value")
     .setPosition(10,100)
     .setRange(0,2)
     .setSize(200,50)
     .setValue(Damping_value)
     ;
  
  // Add Objects
  objects = new ArrayList<Object>();  // Create an empty ArrayList
  for(int i = 0; i < 15; i++){
    objects.add(new Object());
  }
}

void draw(){
  background(0,0,0);
  /*
  if(firstTime){
    for(int i = 0; i < height; i++){
      stroke(random(255), random(255),random(255));
      line(0,i,width,i);
    }
  }else{
   int y = int(random(height));
   stroke(random(255), random(255),random(255));
   line(0,y,width,y);
  }*/
  firstTime = false;
  // Draw Objects
  stroke(255);
  fill(255, 5);
  for (int i = objects.size()-1; i >= 0; i--) {
    Object current = objects.get(i);
    current.update();
    current.draw();
    if(current.base_x || current.base_y){
      current.remove();
      objects.add(new Object());
    }
  }
  if(frameCount % 20 == 0){
   println(frameRate);  
  }
}

void slider() {
  println("a slider event. setting background to ");
}

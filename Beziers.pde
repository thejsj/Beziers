import controlP5.*;

boolean firstTime = true;
ArrayList<Object> objects;
int multiplication_index = 20;

ControlP5 cp5;
float Attraction_value = 0.04; 
float Damping_value = 0.09; 
float Radius_value = 14; 
Slider attraction_slider;
Slider damping_slider;

// Object - Bezier Rotation Points
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
     
  cp5.addSlider("Radius_value")
     .setPosition(10,200)
     .setRange(0,200)
     .setSize(200,50)
     .setValue(Radius_value)
     ;
  
  // Add Objects
  objects = new ArrayList<Object>();  // Create an empty ArrayList
  for(int i = 0; i < 2; i++){
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
    if(current.base_x.get() > (width + 20) || current.base_y.get() > (height + 20)){
      objects.remove(i);
      objects.add(new Object());
    }
  }
  if(frameCount % 20 == 0){
   println(frameRate);  
  }
}

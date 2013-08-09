class Object {
  ArrayList<SoftFloat> x;
  ArrayList<SoftFloat> y;
  
  float this_x;
  float this_y;
  float sub_x;
  float sub_y;
  
  float prev_x; 
  float prev_y; 
  float next_x; 
  float next_y;

  Object(){
    x = new ArrayList<SoftFloat>();
    y = new ArrayList<SoftFloat>();
    
    for(int i = 0; i < 5; i++){
     x.add(new SoftFloat()); 
     y.add(new SoftFloat());
     x.get(i).set(random(width));
     x.get(i).setTarget(random(width));
     y.get(i).set(random(height));
     y.get(i).setTarget(random(height));
    }
  }
  
  void update(){
    for (int ii =0; ii < x.size(); ii++) {
      SoftFloat current_x = x.get(ii); 
      SoftFloat current_y = y.get(ii);

      if(Attraction_value != current_x.ATTRACTION){
        current_x.ATTRACTION = Attraction_value;
        current_y.ATTRACTION = Attraction_value;
        println("new Attraction Value");
      }
      if(Damping_value != current_x.DAMPING){
        current_x.DAMPING = Damping_value;
        current_y.DAMPING = Damping_value;
        println("new Damping Value");
      }
      
      if(!current_x.update()){
        current_x.setTarget(random(width));
      }
      if(!current_y.update()){
        current_y.setTarget(random(height));
      }
    }
  }
  
  void draw(){
    for (int i =0; i < x.size(); i++) {
      for (int ii =0; ii < x.size(); ii++) {
        this_x = x.get(i).get();
        this_y = y.get(i).get();
        sub_x = x.get(ii).get();
        sub_y = y.get(ii).get();
        if(i > 0 && i < x.size() - 1){
          prev_x = x.get(i - 1).get(); 
          prev_y = x.get(i - 1).get();
          next_x = x.get(i + 1).get(); 
          next_y = x.get(i + 1).get();
        }
        else {
          if(i == 0){
            prev_x = x.get(x.size() - 1).get(); 
            prev_y = x.get(x.size() - 1).get();
            next_x = x.get(i + 1).get(); 
            next_y = x.get(i + 1).get();
          }
          else {
            prev_x = x.get(i - 1).get(); 
            prev_y = x.get(i - 1).get();
            next_x = x.get(0).get(); 
            next_y = x.get(0).get();
          }
        }
        fill(i * 10, 100,100,10);
        // Drawing triangle get the FrameRate from 45 to 5. That Sucks.
        //triangle(prev_x, prev_y, this_x, this_y, next_x, next_y); 
        stroke(0, 0, 100, 5);
        noFill();
        // Don't draw lines two times
        if(i > ii && i != ii){
          bezier(this_x, this_y, sub_x, sub_y, prev_x, prev_y, next_x, next_y);
        }
      }
    }
  }
}




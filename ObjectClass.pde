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
  
  int base_x;
  int base_y;
  
  int hue;

  IntList current_radius_position;

  Object() {
    x = new ArrayList<SoftFloat>();
    y = new ArrayList<SoftFloat>();
    current_radius_position = new IntList();
    
    base_x = int(random(-width)); 
    base_y = int(random(-height));
    
    hue = int(random(100));
    println("HUE: " + hue);
    for (int i = 0; i < 5; i++) {
      int current_position = i * multiplication_index;
      x.add(new SoftFloat()); 
      y.add(new SoftFloat());
      x.get(i).set(current_position);
      x.get(i).setTarget(current_position);
      y.get(i).set(current_position);
      y.get(i).setTarget(current_position);
      current_radius_position.append(int(random(0, numPoints)));
    }
  }

  void update() {
    for (int ii =0; ii < x.size(); ii++) {
      SoftFloat current_x = x.get(ii); 
      SoftFloat current_y = y.get(ii);

      if (Attraction_value != current_x.ATTRACTION) {
        current_x.ATTRACTION = Attraction_value;
        current_y.ATTRACTION = Attraction_value;
        println("new Attraction Value");
      }
      if (Damping_value != current_x.DAMPING) {
        current_x.DAMPING = Damping_value;
        current_y.DAMPING = Damping_value;
        println("new Damping Value");
      }

      if (!current_x.update()) {
        current_x.setTarget(ii * multiplication_index);
      }
      if (!current_y.update()) {
        current_y.setTarget(ii * multiplication_index);
      }
      
      current_radius_position.set(ii, current_radius_position.get(ii) + 1);
      if (current_radius_position.get(ii) > numPoints) {
        current_radius_position.set(ii, 0);
      }
    }
    base_x++;
    base_y++;
  }

  void draw() {
    stroke(hue, 100, 100, 50);
    fill(hue, 100,100,10);
    line(x.get(0).get(), y.get(0).get(), x.get(x.size()-1).get(), y.get(y.size()-1).get());
    for (int i =0; i < x.size(); i++) {
      for (int ii =0; ii < x.size(); ii++) {
        this_x = x.get(i).get();
        this_y = y.get(i).get();
        sub_x = x.get(ii).get();
        sub_y = y.get(ii).get();
        if (i > 0 && i < x.size() - 1) {
          prev_x = x.get(i - 1).get(); 
          prev_y = x.get(i - 1).get();
          next_x = x.get(i + 1).get(); 
          next_y = x.get(i + 1).get();
        }
        else {
          if (i == 0) {
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
        //fill(i * 10, 100, 100, 10);
        // Drawing triangle get the FrameRate from 45 to 5. That Sucks.
        //triangle(prev_x, prev_y, this_x, this_y, next_x, next_y); 
        
        //noFill();
        line(this_x, this_y, sub_x, sub_y);
        // Don't draw lines two times
        float x_1 = this_x + Radius_value *cos(angle * current_radius_position.get(i));
        float y_1 = this_y + Radius_value *sin(angle * current_radius_position.get(i));
        float x_2 = next_x + Radius_value *cos(angle * current_radius_position.get(i));
        float y_2 = next_y + Radius_value *sin(angle * current_radius_position.get(i));
        pushMatrix();
        translate(base_x, base_y);
        if (i > ii && i != ii) {
          bezier(this_x, this_y, x_1, y_1, x_2, y_2, next_x, next_y);
        }
        popMatrix();
      }
    }
  }
}



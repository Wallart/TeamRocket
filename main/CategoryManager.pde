class CategoryManager {
  
  PGraphics g;
  PFont f;
  
  color blue = color(0, 0, 255);
  color red = color(255, 0, 0);
  color black = color(0, 0, 0);
  
  String[][] names = {{"SCIENCES", "POLITIQUE", "ECONOMIE"}, {"CULTURE", "INTERNATIONAL", "SPORTS"}};  
  
  int currentState;
  
  CategoryManager(){
    currentState = 1;
    f = createFont("Arial", 35, true); 
  }
  
  void draw(PGraphics g) {
    this.g = g; 
    
    g.background(255);

    g.textFont(f);
    g.textAlign(CENTER);    
    g.fill(0);
    
    drawRect(1, black);
    drawRect(2, black);
    drawRect(3, black);
    
    drawRect(4, black);
    drawRect(5, black);
    drawRect(6, black);
    
    setSelected(currentState);
  }
  
  void drawRect(int x, int y, int w, int h, String l1, String l2, color c) {
    g.strokeWeight(10);
    g.stroke(c);
    g.line(x,y,x,y + h);
    g.line(x,y,x + w,y);
    g.line(x + w,y,x+w,y+h);
    g.line(x,y+h,x+w,y+h);
  
    int textX = 150;
   
    try {
      g.text(l1, x + textX, y + 100); 
      g.text(l2, x + textX, y + 140);
    }
    catch(Exception e){
      //Crashes randomly when using Kinect sensor or mouse events
      //So we have to catch the exception
      System.out.println(l2);
    }
  }
  
  void drawRect(int i, color c) {
    
    String prefix = "CATEGORIE";
    String suffix = "";
    int x = 80;
    
    if(i > 3){
      suffix = names[1][(i-1)%3];
      x = 420; 
      i = i%3+1;
    }
    else {
      suffix = names[0][i-1];
    }
    
    int y = 220 * i - 140; 
    
    drawRect(x, y, 300, 200, prefix, suffix, c);
  }
  
  void setSelected(int i) {
    currentState = i;
    drawRect(1, black);
    drawRect(2, black);
    drawRect(3, black);
    
    drawRect(4, black);
    drawRect(5, black);
    drawRect(6, black);
    
    drawRect(i, red);
    System.out.println("selected "+i);
  }
  
  void left() {
    switch(currentState){
     case 1:
       //NOPE
       break;
     case 2:
       //NOPE
       break;
     case 3:
       //NOPE
       break;
     case 4:
       setSelected(2);
       break;
     case 5:
       setSelected(3);
       break;
     case 6:
       setSelected(1);
       break;
    }
  }
  
  void right() {
    switch(currentState){
     case 1:
       setSelected(6);
       break;
     case 2:
       setSelected(4);
       break;
     case 3:
       setSelected(5);
       break;
     case 4:
       //NOPE
       break;
     case 5:
       //NOPE
       break;
     case 6:
       //NOPE
       break;
    }
  }
  
  void up(){
    switch(currentState){
     case 1:
       //NOPE
       break;
     case 2:
       setSelected(1);
       break;
     case 3:
       setSelected(2);
       break;
     case 4:
       setSelected(6);
       break;
     case 5:
       setSelected(4);
       break;
     case 6:
       //NOPE
       break;
    }
  }
  
  void down(){
    switch(currentState){
     case 1:
       setSelected(2);
       break;
     case 2:
       setSelected(3);
       break;
     case 3:
       //NOPE
       break;
     case 4:
       setSelected(5);
       break;
     case 5:
       //NOPE
       break;
     case 6:
       setSelected(4);
       break;
    }
  }
}
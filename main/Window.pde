class Window extends PApplet {
  int width;
  int height;
  
  Window(int w, int h) {
    width = w;
    height = h;
  }
  
  void settings() {
    size(width, height);
  }
 
  void draw() {
    background(255);
    fill(0);
  }
}
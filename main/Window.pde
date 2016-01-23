public class Window extends PApplet {
  int width;
  int height;
  
  public Window(int w, int h) {
    width = w;
    height = h;
  }
  
  public void settings() {
    size(width, height);
  }
 
  public void draw() {
    background(255);
    fill(0);
  }
}
class Window extends PApplet {
  int width;
  int height;
  
  CategoryManager categories = new CategoryManager();
  
  Window(int w, int h) {
    width = w;
    height = h;
  }
  
  void settings() {
    size(width, height);
  }
 
  void draw() {
    background(255);
    drawCategories();
  }
  
  void drawCategories() {
    categories.draw(this.g);
  }
  
  CategoryManager getCategories() {
    return this.categories;
  }
}
class Window extends PApplet {
  int width;
  int height;
  
  CategoryManager categories = new CategoryManager();
  Presentation presentation = new Presentation(800, 800);
  
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
  
  void drawMainScreen() {
    presentation.draw(g);
  }
  
  Presentation getPresentation() {
    return this.presentation;
  }
  
  CategoryManager getCategories() {
    return this.categories;
  }
}
class Window extends PApplet {
  int width;
  int height;
  
  CategoryManager categories = new CategoryManager();
  Presentation presentation = new Presentation(800, 800);
  ArticlePrinter article;
  
  int state = 0;
  
  
  
  
  Window(int w, int h) {
    width = w;
    height = h;
  }
  
  void settings() {
    size(width, height);
  }
 
  void draw() {
    background(255);
    switch(state){
      case 0:
        presentation.draw(g);
        break;
      case 1:
        categories.draw(g);
        break;
      case 2:
            article.draw(g);
    }
  }
  
  void setState(int i) {
    this.state = i;
  }
  
  ArticlePrinter getArticle(){
    return this.article;
  }
  
  Presentation getPresentation() {
    return this.presentation;
  }
  
  CategoryManager getCategories() {
    return this.categories;
  }
}
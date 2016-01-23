class ArticlePrinter {

  PGraphics g;
  int w;
  int h;
  String rubrik;
  PImage article;
  boolean move = true;
  int pos = 0;
  int scrollHeight;
  int scrollMax;
  
  public ArticlePrinter(int wWidth, int wHeight) {
    this.w = wWidth;
    this.h = wHeight;
  }
  
  void draw(PGraphics g) {
    this.g = g;
    g.background(255);
    g.fill(255);
    g.image(article.get(0, pos, w, h), 0, 0);
    if (move) {
      drawScrollPosition(pos);
    }
  }
  
  void setRubrik(String rubrik) {
    this.rubrik = rubrik.toLowerCase();
    article = loadImage(rubrik + ".png");
    if (article.height <= h) {
      move = false;
    } else {
      scrollHeight = h / (article.height / h);
      scrollMax = article.height - h;
    }
  }
  
  void drawScrollPosition(int pos) {
    float scrollPos = 0;
    if (pos > 0) {
      float percent = (pos * 100) / article.height;
      scrollPos = (percent * h) / 100;
    }
    g.fill(color(195, 211, 228));
    g.rect(780, 0, 20, h);
    g.fill(0);
    g.rect(783, scrollPos, 14, scrollHeight);
  }
  
  void up() {
    if (move) {
      pos -= 400;
      if(pos < 0)
        pos = 0;
    }
  }
  
  void down() {
    if (move) {
      pos += 400;
      if (pos >= scrollMax)
        pos = scrollMax;
    }
  }  
}
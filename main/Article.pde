class ArticlePrinter {

  PGraphics g;
  int w;
  int h;
  String rubrik;
  PImage article;
  boolean move;
  int pos = 0;
  
  public ArticlePrinter(int wWidth, int wHeight, String rubrik) {
    this.w = wWidth;
    this.h = wHeight;
    this.rubrik = rubrik.toLowerCase();
    article = loadImage(rubrik + ".png");
  }
  
  void draw(PGraphics g) {
    this.g = g;
    
    g.background(255);
    g.fill(255);
    g.image(article.get(0,pos, w, h), 10, 10);
    println("draw: " + pos);
  }
  
  void up() {
    pos -= 200;
    if(pos < 0)
      pos = 0;
    println(pos);
    g.image(article.get(0,pos, w, h), 10, 10);
  }
  
  void down() {
    pos += 200;
    if (pos > article.width +h)
      pos = article.width +h ;
    //println(pos);
    //g.image(article.get(0,pos, w, h), 10, 10);
  }  
}
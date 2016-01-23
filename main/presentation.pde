public class Presentation {

  PFont f;
  int selected = 1;
  color blue = color(25, 25, 112);
  color black = color(0, 0, 0);
  int width;
  int height;
  PGraphics g;
  
  public Presentation(int t_width, int t_height) {
    this.width = t_width;
    this.height = t_height;
    f = createFont("Arial",35,true); 
  }

  void drawRect(int i, color c) {
    int x = 275 * i - 250; 
    drawRect(x,450, 200, 200, "IMAGE", "TUTO", c);
  }

  void draw(PGraphics g) {
    this.g = g;
    g.background(255);

    g.textFont(f);       
    g.fill(0);

    g.textAlign(CENTER);
    g.text("FAÎTES UN MOUVEMENT DE HAUT EN BAS", width/2,40); 
    g.text("POUR VOIR SUIVRE LE TOTURIAL", width/2,80); 
    g.text("OU LEVEZ LE BRAS AU DESSUS", width/2,120); 
    g.text("DE LA TÊTE", width/2,160); 
    g.text("POUR MASQUER LE TUTORIAL", width/2,200); 
  
    drawRect(selected, blue);
    drawRect(2, black);
    drawRect(3, black);

  }

  void setSelected(int i) {
    drawRect(i, blue);
    drawRect((i+1) % 3, black);
    drawRect((i+2) % 3, black);
  }

  void drawRect(int x, int y, int w, int h, String l1, String l2, color c ) {
    g.stroke(c);
    g.line(x,y,x,y + h);
    g.line(x,y,x + w,y);
    g.line(x + w,y,x+w,y+h);
    g.line(x,y+h,x+w,y+h);
  
    g.text(l1, x + 100, y + 80); 
    g.text(l2, x + 100, y + 120);
  
    drawArrow(230,550,60,0);
    drawArrow(505,550,60,0);
    drawArrow(230,550,60,0);
  }

  void drawArrow(int cx, int cy, int len, float angle){
    g.pushMatrix();
    g.translate(cx, cy);
    g.rotate(radians(angle));
    g.line(0,0,len, 0);
    g.line(len, 0, len - 8, -8);
    g.line(len, 0, len - 8, 8);
    g.popMatrix();
  }
}
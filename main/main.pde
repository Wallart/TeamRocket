import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
import javax.swing.*; 

import java.util.List;

int W_WIDTH = 1000;
int W_HEIGHT = 500;

int T_WIDTH = 500;
int T_HEIGHT = 500;

MovementDetector detector;
Window window;
String[] args = {"Interface"};

void setup() {
  detector = new MovementDetector(this, T_WIDTH, T_HEIGHT);
  window = new Window(W_WIDTH, W_HEIGHT);
  
  PApplet.runSketch(args, window);
}

void settings() {
  size(T_WIDTH, T_HEIGHT);
}

void draw() {
  
  background(255);
  detector.draw();
}
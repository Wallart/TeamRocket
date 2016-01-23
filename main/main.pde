import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;
import javax.swing.*; 

import java.util.List;


MovementDetector detector;

void setup() {
  detector = new MovementDetector(this, 500, 500);
  size(500, 500);
  background(255);
}

void draw() {
   detector.draw();
}
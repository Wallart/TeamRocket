import org.openkinect.freenect.*;
import org.openkinect.freenect2.*;
import org.openkinect.processing.*;
import org.openkinect.tests.*;

import java.util.List;

// Constants

final int HOME = 0, CATEGORY = 1, NEWS = 2;

int WIDTH_SCREEN;
int HEIGHT_SCREEN;
int MOVEMENT_MINIMAL_DISTANCE;

final int WAIT_TIME_FOR_CENTER_MOVEMENT = 2000;

final int NO_MOVEMENT = -1;
final int TOP_MOVEMENT = 0;
final int LEFT_MOVEMENT = 1;
final int RIGHT_MOVEMENT = 2;
final int BOTTOM_MOVEMENT = 3;
final int CENTER_MOVEMENT = 4;

final int VERTICAL_DIRECTION_MOVEMENT = 0;
final int HORIZONTAL_DIRECTION_MOVEMENT = 1;

// state variables

int state = HOME;

int centerMovementTimer = 0;

float xPosHand = 0;
float yPosHand = 0;
float xPreviousPosHand = 0;
float yPreviousPosHand = 0;

float xStartMovement = 0;
float yStartMovement = 0;

int directionMovement = -1;

Kinect kinect;
KinectTracker tracker;

// for test
List<Integer> movementList = new ArrayList<Integer>();

void setup() {
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  
  //size(WIDTH_SCREEN = kinect.width, HEIGHT_SCREEN = kinect.height);
  size(500, 500);
  WIDTH_SCREEN = 500;
  HEIGHT_SCREEN = 500;
  MOVEMENT_MINIMAL_DISTANCE = WIDTH_SCREEN / 2;
  background(255);
}

void draw() {
  
  // Run the tracking analysis
  tracker.track();
  // Show the image
  tracker.display();
  
  // Let's draw the raw location
  PVector v1 = tracker.getPos();
  fill(50, 100, 250, 200);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);
  
  // Let's draw the "lerped" location
  PVector v2 = tracker.getLerpedPos();
  fill(100, 250, 50, 200);
  noStroke();
  ellipse(v2.x, v2.y, 20, 20);
  
  int movement = onMoveIn(v2.x, v2.y);
  showMovement(movement);
  
  
  /*int movement = onMoveIn(mouseX, mouseY);
  showMovement(movement);*/
  
  //TODO TRAITER LE MOUVEMENT
  //TODO PRENDRE EN COMPTE LE 'STATE'
  
  // stop the movement
  if (movement != NO_MOVEMENT) {
    directionMovement = 1 - directionMovement;
  }
}

/**
 * Retourne le mouvement effectue en l'appelant regulierement
 * avec les coordonnees du mouvement a mesurer.
 * @param x abscisse du mouvement
 * @param y ordonnee du mouvement
 * @return mouvement associe
**/
int onMoveIn(float x, float y) {
  xPreviousPosHand = xPosHand;
  yPreviousPosHand = yPosHand;
  xPosHand = x;
  yPosHand = y;
  
  int directionMovementPotential = getDirectionMovement();
  
  // Mouvement centre
  if (isScreenCenter(x, y) && centerMovementTimer > 0) {
    if (millis() - centerMovementTimer >= WAIT_TIME_FOR_CENTER_MOVEMENT) {
      centerMovementTimer = 0;
      return CENTER_MOVEMENT; 
    }
  } else {
    centerMovementTimer = millis();
  }
  
  if (directionMovement == -1) {
    // Premier mouvement
    xStartMovement = xPosHand;
    yStartMovement = yPosHand;
    directionMovement = directionMovementPotential;
    return NO_MOVEMENT;
  } else if (directionMovement == directionMovementPotential) {
    // Mouvement 'coherent'
    return getMovementRealized(xPreviousPosHand, yPreviousPosHand);
  } else {
    // Fin du deplacement = Debut d'un autre
    xStartMovement = xPreviousPosHand;
    yStartMovement = yPreviousPosHand;
    directionMovement = directionMovementPotential;
    return getMovementRealized(xPreviousPosHand, yPreviousPosHand);
  }
}

/**
 * Retourne le mouvement realise a l'aide des dernieres coordonnees du mouvement.
 * @param xEnd abscisse de fin du mouvement
 * @param yEnd ordonnee de fin du mouvement
 * @return mouvement realise
**/
int getMovementRealized(float xEnd, float yEnd) {
  if (directionMovement == HORIZONTAL_DIRECTION_MOVEMENT) {
    if (abs(xEnd - xStartMovement) > MOVEMENT_MINIMAL_DISTANCE) {
      return xEnd - xStartMovement < 0 ? LEFT_MOVEMENT : RIGHT_MOVEMENT;
    } else {
      return NO_MOVEMENT;
    }
  } else {
    if (abs(yEnd - yStartMovement) > MOVEMENT_MINIMAL_DISTANCE) {
      return yEnd - yStartMovement < 0 ? TOP_MOVEMENT : BOTTOM_MOVEMENT;
    } else {
      return NO_MOVEMENT;
    }
  }
}

/**
 * Retourne la direction du mouvement.
 * @return direction du mouvement
**/
int getDirectionMovement() {
  return abs(xPosHand - xPreviousPosHand) > abs(yPosHand - yPreviousPosHand)
      ? HORIZONTAL_DIRECTION_MOVEMENT : VERTICAL_DIRECTION_MOVEMENT;
}

/**
 * Retourne vrai si les coordonnees sont centrees.
 * @param x abscisse du point
 * @param y ordonnee du points
 * @return vrai si centrees, faux sinon.
**/
boolean isScreenCenter(float x, float y) {
  int widthSquare = WIDTH_SCREEN / 5;
  int heightSquare = HEIGHT_SCREEN / 5;
  int xSquare = (WIDTH_SCREEN / 2) - (widthSquare / 2);
  int ySquare = (HEIGHT_SCREEN / 2) - (heightSquare / 2);
  
  return (x >= xSquare && x <= xSquare + widthSquare) &&
         (y >= ySquare && y <= ySquare + heightSquare);
}

/**
 * Affiche le mouvement effectuee (permet de tester).
 * @param movement mouvement a afficher
**/
void showMovement(int movement) {
  fill(0, 0, 0xFF);
  textSize(20);
  
  if (movement != NO_MOVEMENT) {
    movementList.add(movement);
  }
  
  final int Y_DIFF = 20;
  text("Realized movements:", 10, 50);
  for (int i = 0; i < movementList.size(); i++) {
    text("" + toStringMovement(movementList.get(i)), 10, 50 + (Y_DIFF * (i + 1)));
  }
}

/**
 * Retourne la chaine de caractere caracterisant le mouvement (permet de tester).
 * @param movement mouvement que l'on veut convertir
 * @return chaine de caractere du mouvement
**/
String toStringMovement(int movement) {
  switch (movement) {
    case NO_MOVEMENT: return "No movement";
    case TOP_MOVEMENT: return "Top movement";
    case BOTTOM_MOVEMENT: return "Bottom movement";
    case LEFT_MOVEMENT: return "Left movement";
    case RIGHT_MOVEMENT: return "Right movement";
    case CENTER_MOVEMENT: return "Center movement";
    default: return "Error: unknowned movement";
  }
}





/**************** KinectTracker *******************/
// Daniel Shiffman
// Tracking the average location beyond a given depth threshold
// Thanks to Dan O'Sullivan
// https://github.com/shiffman/OpenKinect-for-Processing
// http://shiffman.net/p5/kinect/
class KinectTracker {
// Depth threshold
int threshold = 745;
// Raw location
PVector loc;
// Interpolated location
PVector lerpedLoc;
// Depth data
int[] depth;
// What we'll show the user
PImage display;
KinectTracker() {
// This is an awkard use of a global variable here
// But doing it this way for simplicity
kinect.initDepth();
kinect.enableMirror(true);
// Make a blank image
display = createImage(kinect.width, kinect.height, RGB);
// Set up the vectors
loc = new PVector(0, 0);
lerpedLoc = new PVector(0, 0);
}
void track() {
// Get the raw depth as array of integers
depth = kinect.getRawDepth();
// Being overly cautious here
if (depth == null) return;
float sumX = 0;
float sumY = 0;
float count = 0;
for (int x = 0; x < kinect.width; x++) {
for (int y = 0; y < kinect.height; y++) {
int offset = x + y*kinect.width;
// Grabbing the raw depth
int rawDepth = depth[offset];
// Testing against threshold
if (rawDepth < threshold) {
sumX += x;
sumY += y;
count++;
}
}
}
// As long as we found something
if (count != 0) {
loc = new PVector(sumX/count, sumY/count);
}
// Interpolating the location, doing it arbitrarily for now
lerpedLoc.x = PApplet.lerp(lerpedLoc.x, loc.x, 0.3f);
lerpedLoc.y = PApplet.lerp(lerpedLoc.y, loc.y, 0.3f);
}
PVector getLerpedPos() {
return lerpedLoc;
}
PVector getPos() {
return loc;
}
void display() {
PImage img = kinect.getDepthImage();
// Being overly cautious here
if (depth == null || img == null) return;
// Going to rewrite the depth image to show which pixels are in threshold
// A lot of this is redundant, but this is just for demonstration purposes
display.loadPixels();
for (int x = 0; x < kinect.width; x++) {
for (int y = 0; y < kinect.height; y++) {
int offset = x + y * kinect.width;
// Raw depth
int rawDepth = depth[offset];
int pix = x + y * display.width;
if (rawDepth < threshold) {
// A red color instead
display.pixels[pix] = color(150, 50, 50);
} else {
display.pixels[pix] = img.pixels[offset];
}
}
}
display.updatePixels();
// Draw the image
image(display, 0, 0);
}
int getThreshold() {
return threshold;
}
void setThreshold(int t) {
threshold = t;
}
}
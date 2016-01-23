class MovementDetector {
  
  final int WAIT_TIME_FOR_CENTER_MOVEMENT = 2000;
  
  final int NO_MOVEMENT = -1;
  final int TOP_MOVEMENT = 0;
  final int LEFT_MOVEMENT = 1;
  final int RIGHT_MOVEMENT = 2;
  final int BOTTOM_MOVEMENT = 3;
  final int CENTER_MOVEMENT = 4;
  
  final int VERTICAL_DIRECTION_MOVEMENT = 0;
  final int HORIZONTAL_DIRECTION_MOVEMENT = 1;

  final int HOME = 0, CATEGORY = 1, NEWS = 2;
  
  int width_tracker;
  int height_tracker;
  int minimal_distance;
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
  
  List<Integer> movementList = new ArrayList<Integer>();

  KinectTracker tracker;
  
  MovementDetector(PApplet context, int w, int h) {
      width_tracker = w;
      height_tracker = h;
      minimal_distance = w/2;
      
      Kinect kinect = new Kinect(context);
      tracker = new KinectTracker(kinect);
  }
  
  void draw() {
  
    // Run the tracking analysis
    tracker.track();
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
  
   /* int movement = onMoveIn(v2.x, v2.y);
    showMovement(movement);*/
    
  
  
    int movement = onMoveIn(mouseX, mouseY);
    showMovement(movement);
    foo(movement);
  
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
    }
    else {
      centerMovementTimer = millis();
    }
  
    if (directionMovement == -1) {
      // Premier mouvement
      xStartMovement = xPosHand;
      yStartMovement = yPosHand;
      directionMovement = directionMovementPotential;
      return NO_MOVEMENT;
    }
    else if (directionMovement == directionMovementPotential) {
      // Mouvement 'coherent'
      return getMovementRealized(xPreviousPosHand, yPreviousPosHand);
    }
    else {
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
      if (abs(xEnd - xStartMovement) > minimal_distance) {
        return xEnd - xStartMovement < 0 ? LEFT_MOVEMENT : RIGHT_MOVEMENT;
      } else {
        return NO_MOVEMENT;
      }
    } else {
      if (abs(yEnd - yStartMovement) > minimal_distance) {
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
    int widthSquare = width_tracker / 5;
    int heightSquare = height_tracker / 5;
    int xSquare = (width_tracker / 2) - (widthSquare / 2);
    int ySquare = (height_tracker / 2) - (heightSquare / 2);
    
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
}
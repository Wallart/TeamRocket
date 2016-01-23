class ScreensManager {
    final int NO_MOVEMENT = -1;
    final int UP_MOVEMENT = 0;
    final int LEFT_MOVEMENT = 1;
    final int RIGHT_MOVEMENT = 2;
    final int DOWN_MOVEMENT = 3;
    final int FORWARD_MOVEMENT = 4;
    //public  enum States {MAIN_SCREEN, LIST_CATEGORY, ARTICLES}
    //public enum Categories { POLITIQUE, MUSIQUE, SPORT, INTERNATIONAL, HIGH_TECH, SCIENCES }
    static final String MAIN_SCREEN = "MAIN_SCREEN";
    static final String LIST_CATEGORY = "LIST_CATEGORY";
    static final String ARTICLES = "ARTICLES";
    static final String POLITIQUE = "POLITIQUE";
    static final String MUSIQUE = "MUSIQUE";
    static final String SPORT = "SPORT";
    static final String INTERNATIONAL = "INTERNATIONAL";
    static final String HIGH_TECH = "HIGH_TECH";
    static final String SCIENCES = "SCIENCES";
    
    String currentScreen;
    String currentCategory;
    int currentArticle;
    
   public ScreensManager(){
      currentScreen = "MAIN_SCREEN";
      currentCategory = "POLITIQUE";
      currentArticle = 1;
    }
    
    
    void manageScreens(int movementDetected) {
      switch(currentScreen) {
        case "MAIN_SCREEN":  
                  switch(movementDetected) {
                     case UP_MOVEMENT:
                           currentScreen = "LIST_CATEGORY";
                           currentCategory = "POLITIQUE";
                           //Display the category screen with POLITIQUE selected here
                           
                           break;
                      case DOWN_MOVEMENT:
                           //currentScreen = "TUTOS";
                           //Display the tutos screen
                           
                           break;
                       default:
                           //do nothing
               }   
        break;
        
        case "LIST_CATEGORY":
              categoriesManager(movementDetected);
        break;
        
        case "ARTICLES":      
              switch(movementDetected) {
                case UP_MOVEMENT:
                        //Scroll Up
                      
                break;
                
                case DOWN_MOVEMENT:
                      //Scroll down
                      
                break;
                
                case FORWARD_MOVEMENT:
                    currentScreen = "LIST_CATEGORY";
                    break;
                
                default:
              }
        break;  
        
        default:
      }
      }
      
      void categoriesManager(int movementDetected) {
        switch(currentCategory) {
                case "POLITIQUE":
                    switch(movementDetected) {
                      case DOWN_MOVEMENT:
                            currentCategory = "INTERNATIONAL";
                            //Highlight international on categories screen
                      break;
                      
                      case RIGHT_MOVEMENT:
                            currentCategory = "SPORT";
                            //Highlight sport on categories screen
                      break;
                      
                      case FORWARD_MOVEMENT:
                            currentArticle = 1; //set first article as the displayed one (of the category POLITIQUE)
                            currentScreen = "ARTICLES";
                      break;
                      
                      default:
                    }
                break;
                
                case "MUSIQUE":
                    switch(movementDetected) {
                      case DOWN_MOVEMENT:
                            currentCategory = "HIGH_TECH";
                            //Highlight Hi tech on categories screen
                      break;
                      
                      case UP_MOVEMENT:
                            currentCategory = "SPORT";
                            //Highlight sport on categories screen
                      break;
                      
                      case LEFT_MOVEMENT:
                            currentCategory = "INTERNATIONAL";
                            //Highlight international on categories screen
                      break;
                      
                      case FORWARD_MOVEMENT:
                            currentArticle = 1; //first article selected
                            currentScreen = "ARTICLES";
                      break;
                      
                      default:
                    }
                break;
                
                case "SPORT":   
                      switch(movementDetected) {
                      case DOWN_MOVEMENT:
                            currentCategory = "MUSIQUE";
                            //Highlight musique on categories screen
                      break;
                      
                      case LEFT_MOVEMENT:
                            currentCategory = "POLITIQUE";
                            //Highlight politique on categories screen
                      break;
                      
                       case FORWARD_MOVEMENT:
                             currentScreen = "ARTICLES";
                            currentArticle = 1; //first article selected
                      break;
                      
                      default:
                    }
                break;  
                
                case "INTERNATIONAL":     
                      switch(movementDetected) {
                      case DOWN_MOVEMENT:
                            currentCategory = "SCIENCES";
                            //Highlight sciences on categories screen
                      break;
                      
                      case UP_MOVEMENT:
                            currentCategory = "POLITIQUE";
                            //Highlight politique on categories screen
                      break;
                      
                      case RIGHT_MOVEMENT:
                            currentCategory = "MUSIQUE";
                            //Highlight musique on categories screen
                      break;
                      
                       case FORWARD_MOVEMENT:
                            currentArticle = 1; //first article selected
                            currentScreen = "ARTICLES";
                      break;
                      
                      default:
                    }
                break; 
                
                case "HIGH_TECH":   
                      switch(movementDetected) {
                      case UP_MOVEMENT:
                            currentCategory = "MUSIQUE";
                            //Highlight musique on categories screen
                      break;
                      
                      case LEFT_MOVEMENT:
                            currentCategory = "SCIENCES";
                            //Highlight sciences on categories screen
                      break;
                      
                       case FORWARD_MOVEMENT:
                            currentArticle = 1; //first article selected
                            currentScreen = "ARTICLES";
                      break;
                      
                      default:
                    }
                break; 
                
                case "SCIENCES":   
                      switch(movementDetected) {
                      case UP_MOVEMENT:
                            currentCategory = "INTERNATIONAL";
                            //Highlight international on categories screen
                      break;
                      
                      case RIGHT_MOVEMENT:
                            currentCategory = "HIGH_TECH";
                            //Highlight high tech on categories screen
                      break;
                      
                       case FORWARD_MOVEMENT:
                            currentArticle = 1; //first article selected
                            currentScreen = "ARTICLES";
                      break;
                      
                      default:
                    }
                break; 
                
                default:
              }
      }  
}
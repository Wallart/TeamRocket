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
    static final String TUTOS = "TUTOS";
    
    String currentScreen;
    String currentCategory;
    int currentArticle;
    
    int selected = 1;
    
   public ScreensManager(){
      currentScreen = "MAIN_SCREEN";
      currentCategory = "None";
      currentArticle = -1;
    }
    
    
    void manageScreens(int movementDetected) {
      switch(currentScreen) {
        case "MAIN_SCREEN":  
              window.drawMainScreen();
                  switch(movementDetected) {
                     case UP_MOVEMENT:
                           currentScreen = "LIST_CATEGORY";
                           currentCategory = "POLITIQUE";
                           //Display the category screen with POLITIQUE selected here
                           
                           break;
                      case DOWN_MOVEMENT:
                           currentScreen = "TUTOS";
                           selected = 1;
                           //Display the tutos screen
                           break;
                       case LEFT_MOVEMENT:
                           currentScreen = "TUTOS";
                           selected = selected + 1;
                           window.getPresentation().setSelected(selected);
                       case RIGHT_MOVEMENT:
                           currentScreen = "TUTOS";
                           selected = selected - 1 ;
                           if (selected > 1)
                           selected = 1;
                           window.getPresentation().setSelected(selected);
                       default:
                           //do nothing
               }   
        break;
        
        case "LIST_CATEGORY":
              window.drawCategories();
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
                    currentArticle = -1;
                    break;
                
                default:
              }
        break;  
        
        default:
      }
      }
      
      void categoriesManager(int movementDetected) {
        switch(movementDetected) {
          case UP_MOVEMENT:
            window.getCategories().up();
            break;
          case DOWN_MOVEMENT:
            window.getCategories().down();
            break;
          case RIGHT_MOVEMENT:
            window.getCategories().right();
            break;
          case LEFT_MOVEMENT:
            window.getCategories().left();
            break;
          case FORWARD_MOVEMENT:
            currentArticle = 1; //set first article as the displayed one (of the category POLITIQUE)
            currentScreen = "ARTICLES";
            break;
        }
      }  
}
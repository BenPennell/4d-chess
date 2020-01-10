// Create The Squares

Square[] Squares = new Square[64];
int SquareSize;
int pieceMax = 32;
piece[] pieces = new piece[pieceMax];
//Button but = new Button(10, 10, 2, 3);
Button top;
Button start;
Button Quit;
Button side;
Button quit;
Button menu;
Button save;
Button load;
Button chooseLoad;
Button loadArrows;
Button playNorm;
Button playCust;

int turnCountForRealThisTimeISwear = 0;
int trueTurnCount = 0;
int viewingTurn = -1;
boolean blackTurn = false;
int turnCap = 153;
turn turn = new turn();
int selectedID = -1;
int holdID = -1;
int bufferID = -1;
int deadID = -1;
int oldX = -1;
int oldY = -1;
int castling = -1;
int castleX = -1;
int castleY = -1;

boolean pressed = false;
boolean released = false;
boolean selecting = true;
boolean interactable = true;
boolean onePress = false;
boolean viewing = false;

int turnCount = 0;
boolean whiteCheck = false;
boolean blackCheck = false;
boolean paused = false;
boolean running = false;

PImage mainBack;
PImage board;

PImage whiteKnight;
PImage whiteBishop;
PImage whiteKing;
PImage whiteQueen;
PImage whitePawn;
PImage whiteRook;
PImage blackKnight;
PImage blackBishop;
PImage blackKing;
PImage blackQueen;
PImage blackPawn;
PImage blackRook;

int sqrSize = width;
int windowWidth = 640;
int windowHeight = 640;

int boardStartX = 0;
int boardStartY = 0;
int boardEndX = 0;
int boardEndY = 0;
int increment;

//For the menu states
boolean playing = false;
boolean mainMenu = true;
boolean finished = false;
boolean loadingMenu = false;
boolean choosingMode = false;

//Button but;
void setup() {
  //size(640, 640);
  //fullScreen();
  size(999, 792, P2D);
  smooth(0);

  MainMenuSetup();
}  

int wait = 5;
void draw() {
  background(50);
  if (playing) {
    GameDraw();
    if (wait <= 0) {
      wait = 5;
      turn.runGameManager(turn.wantedTurn);
    }
    wait--;
  }
  if (mainMenu) {
    MainMenuDraw();
  }
  if (finished) {
    EndScreenDraw();
  }
  if(loadingMenu) {
    loadingMenuDraw();
  }
  if(choosingMode) {
    choosingModeDraw();
  }
}

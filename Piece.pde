class piece {
  //Variables
  int gridX;
  int gridY;
  int x;
  int y;
  //Tile it goes to
  boolean firstMove = true;
  //what the player inputs
  int commandForward;
  int commandSides;
  int commandDiagonals;
  int commandBackwards;
  //Piece Information
  boolean isWhite;
  int pieceID = -1;
  int pieceType = -1;

  boolean alive = false;
  boolean timeMachine = false;
  boolean interact = true;

  PImage sprite;
  //TIME
  int returnTurn = -1;
  int newReturnTurn = 10;
  int returnX = -1;
  int returnY = -1;

  int turnsStill = 0;

  int selX = -1;
  int selY = -1;

  float dX = 0;
  float dY = 0;

  //Future
  int futureMod = 0;
  //objects share their pointer
  piece(int X, int Y, boolean isWhite_, int ID, int type) {
    //Sets the X & Y to the inputed values
    gridX = X;
    gridY = Y;

    x = (gridX + 1) * SquareSize * 4 - (SquareSize * 2); 
    y = (gridY + 1) * SquareSize * 4 - (SquareSize * 2);

    dX = x + increment;
    dY = y + increment;
    //What the player inputs
    firstMove = true;
    commandForward = 1;
    commandSides = 0;
    commandDiagonals = 0;
    commandBackwards = 0;
    //Sets its team
    isWhite = isWhite_;
    alive = true;
    pieceID = ID;
    pieceType = type;
    if (type == 0 && isWhite) sprite = whitePawn;
    if (type == 0 && !isWhite) sprite = blackPawn;
    if (type == 1 && isWhite) sprite = whiteKnight;
    if (type == 1 && !isWhite) sprite = blackKnight;
    if (type == 2 && isWhite) sprite = whiteRook;
    if (type == 2 && !isWhite) sprite = blackRook;
    if (type == 3 && isWhite) sprite = whiteBishop;
    if (type == 3 && !isWhite) sprite = blackBishop;
    if (type == 4 && isWhite) sprite = whiteKing;
    if (type == 4 && !isWhite) sprite = blackKing;
    if (type == 5 && isWhite) sprite = whiteQueen;
    if (type == 5 && !isWhite) sprite = blackQueen;
  }

  void drawPiece(boolean held) {


    //Temporary
    imageMode(CENTER);
    if (!held) {
      fill(0);
      stroke(255);
      if (isWhite) {
        fill(255);
        stroke(0);
      } 
      if (bufferID != this.pieceID || selX == -1) {
        dX += ((increment + x) - dX) / 5;
        dY += ((increment + y) - dY) / 5;

        image(sprite, dX, dY);
      } else {
        image(sprite, increment + selX, increment + selY);
      }
    } else {
      image(sprite, mouseX, mouseY);
    }
  }
}

boolean doesMove(int ID) {
  for (int k = viewingTurn; k < turn.getTurnEnd(); k++) {
    if (turn.movedID[k] == ID) return true;
  }
  return false;
}

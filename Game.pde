

void GameSetup() {
  if (!viewing) {
    turn = new turn();
    turnCountForRealThisTimeISwear = 0;
    trueTurnCount = 0;
    viewingTurn = -1;
    blackTurn = false;
  }
  if (height <= width) sqrSize = height;
  ////(sqrSize + "\n" + height);
  SquareSize = int((sqrSize * 0.9) / 8 / 4);
  increment = sqrSize / 9;
  //Temporary
  int[] whatDoes = new int[8];
  int[] whatDoesIng = new int[8];
  for (int i = 0; i < whatDoesIng.length; i++) {
    whatDoesIng[i] = i + 1;
    whatDoes[i] = 3;
  }
  whatDoes[0] = 3;

  top = new Button(increment, 0, sqrSize, increment, 8, 3, false, whatDoes, whatDoesIng);
  int[] whatDoesM = new int[1];
  int[] whatDoesingM = new int[1];
  whatDoesM[0] = 2;
  whatDoesingM[0] = 2;

  quit = new Button(0, 0, increment, increment, 1, 2, false, whatDoesM, whatDoesingM);
  quit.setTitle("Menu", 0);

  for (int i = 1; i < 9; i++) {
    String tit = Integer.toString(i);
    top.setTitle(tit, i - 1);
  }

  int[] whatDoes2 = new int[8];
  int[] whatDoesIng2 = new int[8];
  whatDoes2[0] = 4;
  whatDoesIng2[0] = -8;
  whatDoes2[1] = 4;
  whatDoesIng2[1] = 8;
  whatDoes2[2] = 5;
  whatDoesIng2[2] = 0;
  whatDoes2[3] = 9;
  whatDoesIng2[3] = 0;
  whatDoes2[4] = 10;
  whatDoesIng2[4] = 1;
  whatDoes2[5] = 10;
  whatDoesIng2[5] = 2;
  whatDoes2[6] = 10;
  whatDoesIng2[6] = 3;
  whatDoes2[7] = 7;
  whatDoesIng2[7] = 0;

  side = new Button(0, increment, increment, sqrSize, 8, 4, true, whatDoes2, whatDoesIng2);
  boardStartX = increment;
  boardStartY = increment;
  //Chanegs this
  boardEndX = sqrSize - increment;
  boardEndY = sqrSize - increment;
  /*
  boardEndX = sqrSize;
   boardEndY = sqrSize;
   */
  side.setTitle("Previous", 0);
  side.setTitle("Next", 1);
  side.setTitle("Confirm", 2);
  side.setTitle("Past", 3);
  side.setTitle("Future 1", 4);
  side.setTitle("Future 2", 5);
  side.setTitle("Future 3", 6);
  side.setTitle("Current", 7);

  // board = loadImage("board.png");
  //  board.width = sqrSize;
  //  board.height = sqrSize;
  whiteKnight = loadImage("whiteKnight.png");
  whiteBishop = loadImage("whiteBishop.png");
  whiteKing = loadImage("whiteKing.png");
  whiteQueen = loadImage("whiteQueen.png");
  whitePawn = loadImage("whitePawn.png");
  whiteRook = loadImage("whiteRook.png");
  blackKnight = loadImage("blackKnight.png");
  blackBishop = loadImage("blackBishop.png");
  blackKing = loadImage("blackKing.png");
  blackQueen = loadImage("blackQueen.png");
  blackPawn = loadImage("blackPawn.png");
  blackRook = loadImage("blackRook.png");

  // Giving each square their center points
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      int x = SquareSize/2 + (i * SquareSize);
      int y = SquareSize/2 + (j * SquareSize);

      Squares[j + (i * 8)] = new Square(x, y, abs(j - i));
    }
  }

  for (int i = 0; i < 32; i++) {    
    if (i < 16) {
      int type = 0;
      int index = i;
      int xCount = 0;
      int yCount = 0;
      while (index > 7) {
        yCount++;
        index -= 8;
      }

      if (i == 0 || i == 7) {
        type = 2;
      } else if (i == 1 || i == 6) {
        type = 1;
      } else if (i == 2 || i == 5) {
        type = 3;
      } else if (i == 3) {
        type = 5;
      } else if (i == 4) {
        type = 4;
      }

      xCount = index;
      pieces[i] = new piece(xCount, yCount, false, i, type);
      Squares[i].hasPiece = true;
      Squares[i].pieceID = i;
    } else {
      int type = 0;
      int index = 79 - i;
      int xCount = 0;
      int yCount = 0;
      while (index > 7) {
        yCount++;
        index -= 8;
      }

      if (i == 16 || i == 23) {
        type = 2;
      } else if (i == 17 || i == 22) {
        type = 1;
      } else if (i == 18 || i == 21) {
        type = 3;
      } else if (i == 19) {
        type = 4;
      } else if (i == 20) {
        type = 5;
      }
      xCount = index;
      pieces[i] = new piece(xCount, yCount, true, i, type);
      Squares[79 - i].hasPiece = true;
      Squares[79 - i].pieceID = i;
    }
  }
}

void GameDraw() {
  //Displaying the squares
  for (Square S : Squares) {
    S.Render(sqrSize / (SquareSize * 8));
  }

  if (blackTurn) {
    fill(255, 215, 0);
    square(increment +(pieces[4].gridX) * SquareSize * 4, increment + (pieces[4].gridY) * SquareSize * 4, SquareSize * 4);
  } else {
    fill(255, 215, 0);
    square(increment +(pieces[19].gridX) * SquareSize * 4, increment + (pieces[19].gridY) * SquareSize * 4, SquareSize * 4);
  }
  int hoverID = -1;
  if (mouseX < width || mouseY < height) {
    hoverID = getIndex(mouseX - increment, mouseY - increment);
  }
  if (hoverID >= 0 && hoverID < 64) {
    if (Squares[hoverID].hasPiece) {
      fill(0, 255, 0);
      square(increment + (pieces[Squares[hoverID].pieceID].gridX) * SquareSize * 4, increment + (pieces[Squares[hoverID].pieceID].gridY) * SquareSize * 4, SquareSize * 4);
      for (int x = 0; x < 8; x++) {
        for (int y = 0; y < 8; y++) {
          if (check(pieces[Squares[hoverID].pieceID], x, y)) {
            noStroke();
            fill(135, 206, 235);
            square(increment + (x) * SquareSize * 4, increment +  (y) * SquareSize * 4, SquareSize * 4);
          }
        }
      }
    }
  }

  if (holdID != -1 || selectedID != -1) {
    //int xStart = pieces[holdID].gridX;
    //int yStart = pieces[holdID].gridY;
    fill(0, 255, 0);
    int ID = -1;
    if (holdID == -1) {
      ID = selectedID;
    } else {
      ID = holdID;
    }
    square(increment + (pieces[ID].gridX) * SquareSize * 4, increment +  (pieces[ID].gridY) * SquareSize * 4, SquareSize * 4);
    for (int x = 0; x < 8; x++) {
      for (int y = 0; y < 8; y++) {
        if (check(pieces[ID], x, y)) {
          noStroke();
          fill(135, 206, 235);
          square(increment + (x) * SquareSize * 4, increment + (y) * SquareSize * 4, SquareSize * 4);
        }
      }
    }
  }

  if (!interactable) {
    int start = 0;

    if (turnCountForRealThisTimeISwear % 2 == 0) {
      start = 16;
    }

    for (int i = start; i < (start+16); i++) {

      int ID = i;
      boolean doesMove = doesMove(ID);
      if (!doesMove) {
        noStroke();
        fill(255, 0, 0, 127);
        square(increment + (pieces[i].gridX) * SquareSize * 4, increment + (pieces[i].gridY) * SquareSize * 4, SquareSize * 4);
      }
      /*
      if (pieces[i].turnsStill >= (turn.getTurnEnd() - viewingTurn)) {
       noStroke();
       fill(255, 0, 0);
       square(increment + (pieces[i].gridX) * SquareSize * 4, increment + (pieces[i].gridY) * SquareSize * 4, SquareSize * 4);
       }
       */
    }
  }
  //Loops through all the pieces
  for (int x = 0; x < 32; x++) {
    if (pieces[x].alive == true && pieces[x].timeMachine == false) {
      if (x != holdID && x != selectedID) {
        pieces[x].drawPiece(false);
        int index = getIndex(pieces[x].x, pieces[x].y);
        if (index != -1) {
          Squares[index].addPiece(pieces[x]);
        }
      }
    }
  }
  if (holdID != -1 || selectedID != -1) {
    //int xStart = pieces[holdID].gridX;
    //int yStart = pieces[holdID].gridY;
    int ID = -1;
    if (holdID != -1) {
      ID = holdID;
    } else {
      ID = selectedID;
    } 
    pieces[ID].drawPiece(true);
  }



  //but.render();
  side.render();
  side.chooseOption();
  top.render();
  top.chooseOption();
  quit.render();
  quit.chooseOption();
  released = false;
  
  for(int i = 0; i < 32; i++) {
    pieces[i].turnsStill = 100;
    pieces[i].interact = true;
  }
}

void GameCleanUp(boolean menu) {
  playing = false;
  if (menu) {
    mainMenu = true;
    finished = false;
  } else {
    finished = true;
    mainMenu = false;
  }
  turnCount = 0;
}

int getIndex(int x, int y) {
  if (x < boardEndX && y < boardEndY && x > 0 && y > 0) {
    int xSquare = (int)(x / (SquareSize * 4));
    int ySquare = (int)(y / (SquareSize * 4));
    int index = (8 * ySquare) + xSquare;
    return index;
  } else {
    return -1;
  }
}

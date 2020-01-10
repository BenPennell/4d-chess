void move(int ID, int index, int x, int y, boolean running) {
  onePress = false;

  boolean works = check(pieces[ID], x, y);
  if (running) {
    ////(works);
  }
  //Check for check
  if (works && ID != -1) {
    //boolean isChecked = false;
    if (!running) {
      int turnEnd = turn.getTurnEnd();
      //Added this
      turnEnd = turn.findNearestFreeTurn(turnEnd);
      ///ISSUE WHEN ADDING THE TURN
      turn.addturn(pieces[ID], x, y, turnEnd, turnCount);

      //turnCount++;
      //turn.resetGame();
      //turn.runGame(turn.getTurnEnd());
    }
    killPiece(index);
    positionUpdate(pieces[ID], x, y);
    pieces[ID].firstMove = false;


    for (int i = 0; i < 32; i++) {
      /*
      if (pieces[i].alive) {
       pieces[i].turnsStill++;
       } else {
       pieces[i].turnsStill = 0;
       }
       */
      if (i == ID) pieces[i].turnsStill = 0;
    }
    //turnCount++;
    // turn.resetGame();
    // turn.runGame(turn.getTurnEnd());
    //findReturnPieces();
    //turnChange();
  }
}


void keyPressed() {
  if (key == 'g') {
    buttonControlPanel(7, 69);
  }
  // turnCount++;
  /*
  if (key == 'a') {
   // timeSetup(pieces[26], 4, 5, 5);
   //turnCount++;
   }
   if (key == 's') {
   
   //pieces[3].returnTurn = 5;
   //pieces[3].returnX = 5;
   //pieces[3].returnY = 6;
   pieces[8].returnTurn = 2;
   pieces[8].returnX = 0;
   pieces[8].returnY = 2;
   sendToPast(pieces[8]);
   //turnCount++;
   turn.resetGame();
   turn.runGame(turn.getTurnEnd());
   }
   
   if (key == 'w') {
   //turnCount++;
   }
   //  pieces[9].returnTurn = 5;
   //  pieces[9].returnX = 0;
   //  pieces[9].returnY = 2;
   //  sendToPast(pieces[9]);
   */
}

void keyReleased() {
  paused = false;
}

void positionUpdate(piece object, int x, int y) {
  if (object.pieceType == 4) {
    if (castling != -1 && y != 6 && y != 1 && x != 5 && x != 3) {
      //Resets the castling
      int castleCopy = castling;
      castling = -1;
      positionUpdate(pieces[castleCopy], castleX, castleY);
      castleX = 0;
      castleY = 0;
    }
  }
  if (object.alive) {
    //print("MOVED \n");
    Squares[(8 * object.gridY) + object.gridX].hasPiece = false;
    Squares[(8 * object.gridY) + object.gridX].pieceID = -1;

    oldX = object.gridX;
    oldY = object.gridY;

    object.gridX = x;
    object.gridY = y;

    Squares[(8 * object.gridY) + object.gridX].hasPiece = true;
    Squares[(8 * object.gridY) + object.gridX].pieceID = object.pieceID;

    object.x = (object.gridX + 1) * SquareSize * 4 - (SquareSize * 2); 
    object.y = (object.gridY + 1) * SquareSize * 4 - (SquareSize * 2);
  }
}

void killPiece(int index) {
  if (Squares[index].hasPiece) {
    int pIndex = Squares[index].pieceID;
    pieces[pIndex].alive = false;
    deadID = pIndex;
    Squares[index].pieceID = -1;
    Squares[index].hasPiece = false;
    //         KILLING KINGS

    //  ALSO ENDS THE GAME
    if (pIndex == 4 && !viewing) {
      print("Thy Black king is dead \n");

      GameCleanUp(false);
      EndScreenSetUp(true);
    } else if (pIndex == 19 && !viewing) {
      print("Thy White king is dead \n");

      GameCleanUp(false);
      EndScreenSetUp(false);
    }
  }
}


void removePiece(int index) {
  Squares[index].pieceID = -1;
  Squares[index].hasPiece = false;
}

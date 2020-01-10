class turn {
  int[] xLoc = new int[turnCap];
  int[] yLoc = new int[turnCap];
  int[] xNew = new int[turnCap];
  int[] yNew = new int[turnCap];
  int[] movedID = new int[turnCap];
  boolean[][] inTimeMachine = new boolean[pieceMax][turnCap];
  boolean[][] timeSwitchF = new boolean[pieceMax][turnCap];
  boolean[][] timeSwitchB = new boolean[pieceMax][turnCap];
  boolean[][] isDead = new boolean[pieceMax][turnCap];
  //Helps fix future bugs plz
  boolean[] teamChange = new boolean[turnCap];
  //Will be set to the return turn
  int[] turnExecute = new int[turnCap];
  int simulatedTurn= -1;
  int wantedTurn = -1;
  turn() {
    for (int i = 0; i < movedID.length; i++) {
      movedID[i] = -1;
      xLoc[i] = -1;
      yLoc[i] = -1;
      xNew[i] = -1;
      yNew[i] = -1;
      teamChange[i] = false;
      turnExecute[i] = -1;
      turnExecute[i] = turnCap + 1;
      for (int k = 0; k < 32; k++) {
        inTimeMachine[k][i] = false;
        timeSwitchF[k][i] = false;
        timeSwitchB[k][i] = false;
        isDead[k][i] = false;
      }
    }
  }
  void fillTurn(int theTurn) {
    //Fools the getTurnEnd system
    movedID[theTurn] = -2;
    turnExecute[theTurn] = 0;
  }
  void addturn(piece p, int x, int y, int turnIndex, int actionTurn) {
    //    boolean IfDo = false;
    //    while (!IfDo) {
    if (movedID[turnIndex] == -1) {
      //        IfDo = true;
      xLoc[turnIndex] = p.gridX;
      yLoc[turnIndex] = p.gridY;
      xNew[turnIndex] = x;
      yNew[turnIndex] = y;
      movedID[turnIndex] = p.pieceID;
      //Future stuff
      // teamChange[turnIndex] = false;
      turnExecute[turnIndex] = actionTurn;
      print("I am using up this turn" + turnIndex + "\n");
    }
    //      turnIndex++;
    //    }
  }
  //Finds the neext available turn
  int findNearestFreeTurn(int wantedTurnCount) {
    int i = 0;
    //Should work I BELIEVE
    boolean IfDo = false;
    while (!IfDo) {
      //IF THE NEXT TURN EXECUTED TURN IS SMALLER THEN THE WANTED ONE IT WILL SHUFFLE THE SHIT OUT OF THE WAY    PLEASE WORK
      if (wantedTurnCount < turnExecute[i]) {
        IfDo = true;
        //Shuffles everything down
        moveDown(i);
        eraseTurn(i);
        //       print("\n" + turnExecute[i] + " THE TURN STUFF \n");
        //       print(turnExecute[1] + " THE TURN STUFF  1 \n");
        //       print(turnExecute[2] + " THE TURN STUFF  2 \n");
      } else {
        i++;
      }
      /*
      if (wantedTurnCount == turnExecute[i]) {
       if (movedID[i] == -1) {
       IfDo = true;
       } else {
       i++;
       }
       }
       */
    }
    return i;
  }
  int fakefindNearestFreeTurn(int wantedTurnCount) {
    int i = 0;
    //Should work I BELIEVE
    boolean IfDo = false;
    while (!IfDo) {
      //IF THE NEXT TURN EXECUTED TURN IS SMALLER THEN THE WANTED ONE IT WILL SHUFFLE THE SHIT OUT OF THE WAY    PLEASE WORK
      if (wantedTurnCount < turnExecute[i]) {
        IfDo = true;
        //Shuffles everything down
        //moveDown(i);
        //eraseTurn(i);
        //       print("\n" + turnExecute[i] + " THE TURN STUFF \n");
        //       print(turnExecute[1] + " THE TURN STUFF  1 \n");
        //       print(turnExecute[2] + " THE TURN STUFF  2 \n");
      } else {
        i++;
      }
      /*
      if (wantedTurnCount == turnExecute[i]) {
       if (movedID[i] == -1) {
       IfDo = true;
       } else {
       i++;
       }
       }
       */
    }
    return i;
  }
  void checkAllDead() {
    for (int i = 0; i < pieceMax; i++) {
      if (!pieces[i].alive) {
      }
    }
  }

  void addTimeMachine(int ID, int index1, int index2, boolean answer) {
    //index2 = turnCap - 5;
    for (int i = index1; i < index2; i++) {
      inTimeMachine[ID][i] = answer;
    }
  }
  void eraseTurn(int i) {
    xLoc[i] = -1;
    yLoc[i] = -1;
    xNew[i] = -1;
    yNew[i] = -1;
    movedID[i] = -1;
    //Future stuff
    teamChange[i] = false;
    turnExecute[i] = -1;
    for (int k = 0; k < 32; k++) {
      inTimeMachine[k][i] = false;
      isDead[k][i] = false;
    }
    /*
    for (int k = 0; k < 32; k++) {
     if (pieces[k].newReturnTurn != -1) {
     pieces[k].newReturnTurn++;
     }
     }
     */
  }
  void moveDown(int index) {
    for (int i = turnCap - 2; i >= index; i--) {
      //int buffer = xLoc[i + 1];
      xLoc[i + 1] = xLoc[i];
      yLoc[i + 1] = yLoc[i];
      xNew[i + 1] = xNew[i];
      yNew[i + 1] = yNew[i];
      movedID[i + 1] = movedID[i];  
      //This should fix a few bugs   GETTING EXECUTED ON CONFIRM?    LEave this here
      /*
      if (movedID[i] != -1) {
       if (pieces[movedID[i]].returnTurn != -1) {
       pieces[movedID[i]].returnTurn++;
       print("THIS PROBS SHOULDNT BE PRINTING");
       }
       }
       */
      //Future stuff
      teamChange[i + 1] = teamChange[i];
      turnExecute[i + 1] = turnExecute[i];
      for (int k = 0; k < 32; k++) {
        timeSwitchB[k][i + 1] = timeSwitchB[k][i];

        inTimeMachine[k][i + 1] = inTimeMachine[k][i];
        isDead[k][i + 1] = isDead[k][i];
      }
    }
    for (int k = 0; k < 32; k++) {
      timeSwitchB[k][index] = false;
    }
  }

  int getTurnEnd() {
    int turnEnd = 0;
    for (int i = 0; i < movedID.length; i++) {
      if (movedID[i] == -1) {
        turnEnd = i;
        i = movedID.length + 1;
      }
    }

    //Accounts for things in the future
    if (turnEnd > 2) {
      int id = movedID[turnEnd - 1];
      //inTimeMachine[k][i + 1]
      while (inTimeMachine[id][turnEnd - 1]) {
        turnEnd--;
      }
    }
    return turnEnd;
  }

  void runGame(int turn) {
    turnCount = 0;
    running = true;

    for (int i = 0; i < turn; i++) {
      //findReturnPieces();
      if (i != 0) {
        //for(int j = 0; j < inTimeMachine.length; j++) {
        for (int k = 0; k < 32; k++) {
        }
      }

      if (pieces[movedID[i]].alive == true) {

        ////Turn(turnCount);
        onePress = false;
        selectedID = -1;
        holdID = -1;
        //Sets the new X & Y loc
        //  pieces[movedID[i]].gridX = xLoc[i];
        //  pieces[movedID[i]].gridY = yLoc[i];

        pieces[movedID[i]].x = (pieces[movedID[i]].gridX + 1) * SquareSize * 4 - (SquareSize * 2); 
        pieces[movedID[i]].y = (pieces[movedID[i]].gridY + 1) * SquareSize * 4 - (SquareSize * 2);
        //Check for legal move

        //move(movedID[i], (yNew[i] * 8) + xNew[i], xNew[i], yNew[i], true);
        boolean moveCheck;
        moveCheck = check(pieces[movedID[i]], pieces[movedID[i]].gridX, pieces[movedID[i]].gridY);

        //if (pieces[movedID[i]].gridX != xLoc[i] || pieces[movedID[i]].gridY != yLoc[i]) {
        if (moveCheck) {
          // if (xLoc[i] != pieces[movedID[i]].x && yLoc[i] != pieces[movedID[i]].y) {
          //Moves the piece
          move(movedID[i], (yNew[i] * 8) + xNew[i], xNew[i], yNew[i], true);

          //pieces[movedID[i]].gridX = xNew[i];
          //pieces[movedID[i]].gridY = yNew[i];
          pieces[movedID[i]].x = (pieces[movedID[i]].gridX + 1) * SquareSize * 4 - (SquareSize * 2); 
          pieces[movedID[i]].y = (pieces[movedID[i]].gridY + 1) * SquareSize * 4 - (SquareSize * 2);
          // }
        }
        ////(i + "\n");
      }
      //print(turnCount);
      //turnCount++;
      //turnChange();
    }
    running = false;
  }
  void printTimeMachine(int endTurn) {
    for (int i = 0; i < endTurn + 1; i++) {
      print("Start of TM ] \n");
      for (int k = 0; k < 32; k++) {
        print(inTimeMachine[k][i] + " " + k + " Is the piece \n");
      }      
      print("End of turnCount turn " + i);
    }
  }

  void runMove(int endTurn) {
    int i = endTurn;
    for (int k = 0; k < 32; k++) {
      if (timeSwitchF[k][i]) {
        //Takes the piece off the board
        pieces[k].alive = false;
        pieces[k].timeMachine = true;
        int index = (pieces[k].gridY * 8) + pieces[k].gridX;
        Squares[index].removePiece();
      }
      //RIGHT HERE
      if (timeSwitchB[k][i]) {
        //Replaces the piece
        pieces[k].timeMachine = false;
        pieces[k].alive = true;
        int index = (pieces[k].gridY * 8) + pieces[k].gridX;
        Squares[index].addPiece(pieces[k]);
        print("COMiNG BACK GAMER \n");
        print(i + " The thing \n");
        print(movedID[i] + " THE moved Id \n");
        //debugRunningTurn(i, movedID[i]);
      }
    }
    if (i != -1) {
      if (movedID[i] != -1) {
        if (pieces[movedID[i]].alive == true) {
          ////Turn(turnCount);
          onePress = false;
          selectedID = -1;
          holdID = -1;
          //Sets the new X & Y loc
          //  pieces[movedID[i]].gridX = xLoc[i];
          //  pieces[movedID[i]].gridY = yLoc[i];

          pieces[movedID[i]].x = (pieces[movedID[i]].gridX + 1) * SquareSize * 4 - (SquareSize * 2); 
          pieces[movedID[i]].y = (pieces[movedID[i]].gridY + 1) * SquareSize * 4 - (SquareSize * 2);
          //Check for legal move
          //Moves the piece
          move(movedID[i], (yNew[i] * 8) + xNew[i], xNew[i], yNew[i], true);

          //pieces[movedID[i]].gridX = xNew[i];
          //pieces[movedID[i]].gridY = yNew[i];
          pieces[movedID[i]].x = (pieces[movedID[i]].gridX + 1) * SquareSize * 4 - (SquareSize * 2); 
          pieces[movedID[i]].y = (pieces[movedID[i]].gridY + 1) * SquareSize * 4 - (SquareSize * 2);
          // }
          //}
          ////(i + "\n");
        }
      }
    }
  }

  void runGame2(int desiredTurn, int unCalculatedTurn) {
    //FOR REAL THIS TIME
    running = true;
    int c = 0;
    print("RUNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNING \n");
    while (c < desiredTurn) {
      int i = c;
      //SO CLOSE
      for (int k = 0; k < 32; k++) {
        if (timeSwitchF[k][i]) {
          //Takes the piece off the board
          pieces[k].alive = false;
          pieces[k].timeMachine = true;
          int index = (pieces[k].gridY * 8) + pieces[k].gridX;
          Squares[index].removePiece();
        }
        //RIGHT HERE
        if (timeSwitchB[k][i]) {
          //Replaces the piece
          pieces[k].timeMachine = false;
          pieces[k].alive = true;
          int index = (pieces[k].gridY * 8) + pieces[k].gridX;
          Squares[index].addPiece(pieces[k]);
          print("COMiNG BACK GAMER \n");
          print(i + " The thing \n");
          print(movedID[i] + " THE moved Id \n");
          //debugRunningTurn(i, movedID[i]);
        }
      }
      if (i != -1) {
        if (pieces[movedID[i]].alive == true) {

          ////Turn(turnCount);
          onePress = false;
          selectedID = -1;
          holdID = -1;
          //Sets the new X & Y loc
          //  pieces[movedID[i]].gridX = xLoc[i];
          //  pieces[movedID[i]].gridY = yLoc[i];


          pieces[movedID[i]].x = (pieces[movedID[i]].gridX + 1) * SquareSize * 4 - (SquareSize * 2); 
          pieces[movedID[i]].y = (pieces[movedID[i]].gridY + 1) * SquareSize * 4 - (SquareSize * 2);
          //Check for legal move
          //Moves the piece
          move(movedID[i], (yNew[i] * 8) + xNew[i], xNew[i], yNew[i], true);

          //pieces[movedID[i]].gridX = xNew[i];
          //pieces[movedID[i]].gridY = yNew[i];
          pieces[movedID[i]].x = (pieces[movedID[i]].gridX + 1) * SquareSize * 4 - (SquareSize * 2); 
          pieces[movedID[i]].y = (pieces[movedID[i]].gridY + 1) * SquareSize * 4 - (SquareSize * 2);

          //pieces[movedID[i]].dX = pieces[movedID[i]].x + increment;
          //pieces[movedID[i]].dY = pieces[movedID[i]].y + increment;
          // }
          //}
          ////(i + "\n");
        }      
        c++;
      }
    }
    /*
    boolean pieceColour = pieces[movedID[unCalculatedTurn - 1]].isWhite;
     int numP = 0;
     for (int i = 0; i < pieceMax; i++) {
     if (inTimeMachine[i][unCalculatedTurn-1]) {
     numP++;
     }
     }
     //if (numP % 2 == 1) {
     blackTurn = true;
     if (pieceColour) {
     blackTurn = false;
     }
     //}
     if (numP % 2 == 0) {
     if (blackTurn == true) {
     blackTurn = false;
     } else {
     blackTurn = true;
     }
     }
     */

    blackTurn = true;
    if (turnCountForRealThisTimeISwear % 2 == 0) {
      blackTurn = false;
    }
    running = false;
  }

  void resetGame() {

    //RESET SQUARES
    for (int i = 0; i < Squares.length; i++) {
      Squares[i].hasPiece = false;
      Squares[i].pieceID = -1;
    }
    //RESET PIECES
    for (int i = 0; i < 32; i++) {
      int oldReturnTurn = pieces[i].newReturnTurn;
      pieces[i] = null;  

      if (i < 16) {
        int type = 0;
        int index = i;
        int xCount = 0;
        int yCount = 0;
        int desiredTurn;
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
        pieces[i].newReturnTurn = oldReturnTurn;
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
        pieces[i].newReturnTurn = oldReturnTurn;
        Squares[79 - i].hasPiece = true;
        Squares[79 - i].pieceID = i;
      }
    }
  }

  void loadBoardState(int whatTurn) {
    resetGame();
    int ranTurn = turn.fakefindNearestFreeTurn(whatTurn);
    print(ranTurn + " RAN TURN \n");
    runGame2(ranTurn, whatTurn);
    viewingTurn = whatTurn;
    interactable = false;
    if (whatTurn == getTurnEnd()) {
      interactable = true;
    }
  }

  //Manages
  void runGameManager(int whatTurn) {
    if (whatTurn != -1) {
      if (wantedTurn != whatTurn) {
        wantedTurn = whatTurn;
      }
      int ranTurn = turn.fakefindNearestFreeTurn(wantedTurn);

      if (wantedTurn == turn.getTurnEnd()) {
        ranTurn--;
      }

      if (simulatedTurn < ranTurn) simulatedTurn++;

      print(simulatedTurn + " RAN TURN \n");
      //runGame2(ranTurn, whatTurn);
      runMove(simulatedTurn);

      viewingTurn = wantedTurn;
      interactable = false;
      if (whatTurn == getTurnEnd()) {
        interactable = true;
      }

      if (simulatedTurn == ranTurn) {
        wantedTurn = -1;
        simulatedTurn = -1;
      }
    } else {
      simulatedTurn = -1;  
      wantedTurn = -1;
    }
  }

  void printTurn(int i) {
    print(movedID[i] + " This is the piece moved \n");
    print(xNew[i] + " This is the new X \n");
    print(yNew[i] + " This is the new Y \n");
  }

  void debugRunningTurn(int i, int index) {
    print(movedID[i] + " This is the piece moved -------------------------------------\n");
    print(pieces[index].gridX + " This is the gridX \n");
    print(pieces[index].gridY + " This is the gridY \n");
    print(xNew[i] + " This is the new X \n");
    print(yNew[i] + " This is the new Y \n");
  }

  void printsArray() {
    print("Start \n");
    for (int i = 0; i < getTurnEnd() + 5; i++) {
      //print(movedID[i] + " This is the piece moved \n");
      //print(turnExecute[i] + " This is the desired return turn of this thing \n");
      print(movedID[i] + " This is the piece moved \n");
      print(xNew[i] + " This is the new X \n");
      print(yNew[i] + " This is the new Y \n");
    }
    print("End \n");
  }

  void calculateTimeMachine() {
    for (int k = 0; k < 32; k++) {
      inTimeMachine[k][turnCount] = pieces[k].timeMachine;
    }
  }
}

void turnChange() {
  if (!running) {
    //turn.calculateTimeMachine();
  }
  ///findReturnPieces2();
  //Debugging
  //turn.printTurn(turnCount);
  //turn.printTurn(turnCount - 1);
  // turn.printTurn(turnCount + 1);
  //print((turnCount) + " The previous Turn   ");
  findReturnPieces2();
  turnCount++;
  print("Incrementing" + turnCount  +"\n");
  trueTurnCount++;

  turn.resetGame();
  int turnEnd = turn.getTurnEnd();
  int actualTurn = turn.fakefindNearestFreeTurn(turnEnd);

  ////          EDIT--------------------------------------------------
  //turn.runGame2(actualTurn, turnEnd);

  turn.runGameManager(turnEnd);
  //print(turnCount + " The current Turn \n");
}
void teamChange() {
  //findReturnPieces2(); //MAybe?
  if (blackTurn == true) {
    blackTurn = false;
  } else {
    blackTurn = true;
  }

  for (int i = 0; i < 32; i++) {
    if (pieces[i].alive) {
      pieces[i].turnsStill++;
    } else {
      pieces[i].turnsStill = 0;
    }
  }

  turnCountForRealThisTimeISwear++;
  //turn.printsArray();
}

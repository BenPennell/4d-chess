class Button { //<>// //<>//
  int x;
  int y;
  int Rx;
  int Dy;
  int tag;
  int tag2;
  int widthIncrement = 0;
  int heightIncrement = 0;
  int optionClicked = -1;
  //Drawing Vars
  int justClicked = 0;
  int coloredOption = -1;

  //For what the buttons do
  int[] buttonOption;
  int[] buttonNumber;
  boolean visisble = false;
  boolean hasSprite = false;
  boolean isVertical = false;

  int optionAmount = 0;
  String[] title;

  boolean debug = false;
  Button(int startX, int startY, int endX, int endY, int options, int tags, boolean vertical, int[] whatDo, int[] whatDoing) {
    x = startX;
    y = startY;
    optionAmount = options;
    Rx = endX;
    Dy = endY;
    tag = tags;
    tag2 = tags;
    isVertical = vertical;
    if (!isVertical) {
      widthIncrement = (Rx - x) / optionAmount;
    } else {
      heightIncrement = (Dy - y) / optionAmount;
    }

    title = new String[options];
    buttonOption = new int[options];
    buttonNumber = new int[options];

    for (int i = 0; i < options; i++) {
      buttonOption[i] = whatDo[i];
      buttonNumber[i] = whatDoing[i];
      title[i] = "-1";
    }
  }
  void setTitle(String titl, int loc) {
    ////(titl);
    title[loc] = titl;
    ////(title[0]);
  }
  void render() {

    textAlign(CENTER);
    ////(isVertical + "\n");
    justClicked--;
    fill(0);
    ////(title[0]);
    // text(title[0], width/2, height/2);
    rect(x, y, Rx - x, Dy - y);
    if (optionAmount != 1) {
      for (int i =0; i < optionAmount + 1; i++) {
        stroke(255);
        line(x+ i * widthIncrement, y, x + i * widthIncrement, Dy);
        if (!isVertical) {
          if (i < optionAmount) {
            //if (mouseX > x +  (i * widthIncrement) && mouseX <  Rx - (i) * widthIncrement && mouseY < Dy && mouseY > y) {
            if (mouseX > x + ((i) * widthIncrement) && mouseX <  x + (i + 1) * widthIncrement && mouseY < Dy && mouseY > y) {
              fill(100);
              if (coloredOption == i && justClicked >= 0) {
                fill(255);
              }
              stroke(255);
              int start = x + (i * widthIncrement);
              rect(start, y, widthIncrement, Dy);
            }
            fill(255);
            stroke(255);
            ////(title[0]);
            if (i < optionAmount) {
              textSize(18);
              text(title[i], x + ((i+ 1) * widthIncrement) - widthIncrement/2, (y + Dy)/2);
            }
          }
        } else {
          //Is vertical 
          stroke(255);
          line(x, y + i * heightIncrement, Rx, y+ i * heightIncrement);
          if (i < optionAmount) {
            //if (mouseX > x +  (i * widthIncrement) && mouseX <  Rx - (i) * widthIncrement && mouseY < Dy && mouseY > y) {
            if (mouseX > x && mouseX < Rx && mouseY < y + ((i + 1) * heightIncrement) && mouseY > y + (i) * heightIncrement) {
              fill(100);
              if (coloredOption == i && justClicked >= 0) {
                fill(255);
              }
              stroke(255);
              int start = y + (i * heightIncrement);
              rect(x, start, Rx - x, heightIncrement);
            }
          }
          fill(255);
          stroke(255);
          ////(title[0]);
          if (i < optionAmount) {
            textSize(18);
            text(title[i], (x + Rx)/2, y + ((i+ 1) * heightIncrement) - heightIncrement/2);
          }
        }
      }
      if (debug) {
        circle(100, 100, 1000);
      }
    } else {
      stroke(255);
      if (mouseX > x && mouseX < Rx && mouseY < Dy && mouseY > y) {
        fill(100);
        if (coloredOption == 0 && justClicked >= 0) {
          fill(255);
        }
        stroke(255);
        rect(x, y, Rx - x, Dy - y);
      }
      fill(255);
      stroke(255);
      ////(title[0]);
      textSize(18);
      text(title[0], (x + Rx) / 2, (y + Dy)/2);
    }
  }
  void chooseOption() {
    if (released) {
      //released = false;
      ////(isVertical + "\n");
      //isVertical = true;
      for (int i = 0; i < optionAmount; i++) {
        //Checks if in button
        //if (mouseX > x +  (i * widthIncrement) && mouseX <  Rx - (i) * widthIncrement && mouseY < Dy && mouseY > y) {
        if (!isVertical) {
          // //("YO");
          if (mouseX > x + ((i) * widthIncrement) && mouseX <  x + (i + 1) * widthIncrement && mouseY < Dy && mouseY > y) {
            optionClicked = i;
            //For drawing
            coloredOption = i;
            justClicked = 10;
            ////(buttonOption[0] + "\n");
            fill(255);
            int start = x + (i * widthIncrement);
            rect(start, y, widthIncrement, Dy);
          }
        } 

        if (isVertical) {
          ////("HEY" + "\n");
          //Vertical
          if (mouseX > x && mouseX < Rx && mouseY < y + ((i + 1) * heightIncrement) && mouseY > y + (i) * heightIncrement) {
            optionClicked = i;
            //For drawing
            coloredOption = i;
            justClicked = 10;
            fill(255);
            int start = y + (i * heightIncrement);
            rect(x, start, Rx - x, heightIncrement);
          }
        }
      }

      if (optionClicked != -1) {

        ////(this.buttonOption[optionClicked]);
        ////(buttonOption[optionClicked]);
        buttonControlPanel(buttonOption[optionClicked], buttonNumber[optionClicked]);
        released = false;
        fill(50 * optionClicked);
        optionClicked = -1;
      }
    }
  }
}

void buttonControlPanel(int option, int number) {
  switch (option) {
  case 0:
    //Exit Game
    exit();
    break;
  case 1:
    //Start Chess match
    //TEMPORARY: START GAME
    playing = true;
    mainMenu = false;
    finished = false;
    loadingMenu = false;
    choosingMode = false;
    GameSetup();
    break;
  case 2:
    mainMenu = true;
    playing = false;
    finished = false;
    viewing = false;
    loadingMenu = false;
    MainMenuSetup();
    break;
  case 3:
    /*
    if (turn.movedID[number] >= 0) {
     turn.loadBoardState(number);
     }
     interactable = false;
     if (number == turn.getTurnEnd()) {
     buttonControlPanel(7, 0);
     }
     */
    //loadBoardState
    println("OOOGA BOOOGA");
    //number = turn.getTurnEnd();
    if (viewingTurn > number) {
      turn.resetGame();
      interactable = false;
      if (turn.movedID[number] >= 0) {
        turn.loadBoardState(number);
        //turn.runGameManager(number);
      }
      unselectPiece();
    } else {
      turn.simulatedTurn = viewingTurn;
      turn.runGameManager(number);
    }
    print("CURRENT");
    break;
  case 4:
    for (int i = 0; i < top.optionAmount; i++) {
      if (number < 0) {
        // //("GOING BACK");
        if (top.buttonNumber[i] <= 8) {
          break;
        }
      }
      if (top.buttonNumber[i] <= 144) {
        top.buttonNumber[i] += number;
        String tit = Integer.toString(top.buttonNumber[i]);
        top.setTitle(tit, i);
      } else if (number < 0) {
        top.buttonNumber[i] += number;
        String tit = Integer.toString(top.buttonNumber[i]);
        top.setTitle(tit, i);
      }
    }
    break;

  case 5:
    //Confirm move
    //---------------We have to move the piece from the board state first-----------------------------
    //pieceMove(pieces[holdID].x + increment, pieces[holdID].y  + increment);
    if (bufferID != -1 && !viewing) {
      if (interactable) {
        confirmMove();
      }
    }
    break;
  case 6:
    //loadBoardState
    number = turn.getTurnEnd();
    turn.resetGame();

    if (turn.movedID[number] >= 0) {
      //turn.loadBoardState(number - 1);
      turn.runGameManager(number);
    }
    unselectPiece();
    break;
  case 7:
    //loadCurrentBoard

    number = turn.getTurnEnd();
    //turn.resetGame();
    turn.simulatedTurn = viewingTurn;
    //  turn.runGameManager(number);
    //turn.loadBoardState(number - 1);
    turn.runGameManager(number);
    interactable = false;
    break;
  case 8:
    EndScreenCleanUp();
    GameSetup();
    break;
  case 9:
    ///PAST LOGIC
    if (!interactable) {
      if (viewingTurn < turn.getTurnEnd() && !viewing) {
        sendToPast(viewingTurn);
        teamChange();
        //   selectedID = -1;
        //   bufferID = -1;
        //   holdID = -1;
      }
    }
    break;
  case 10:
    //FUTURE
    //NUMBER IS HOW MANY TURNS INTO FUTURE (1-3)
    if (bufferID != -1) {
      // print("FUTURE TIME \n");
      int x;
      int y;
      ////ISSUESSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS
      x = (pieces[bufferID].selX); //- increment); // / 8;
      y = (pieces[bufferID].selY); //- increment); // / 8;
      int index = getIndex(x, y);
      //print(index);
      y = 0;
      x = index;
      while (x >= 8 ) {
        y++;
        x-= 8;
      }
      int intoFuture = number * 2;
      // print("\n" + x);
      // print("\n" + y);
      if (turnCount > 0) {
        //timeSetup(pieces[bufferID], number, x, y);
        timeSetup2(bufferID, x, y, intoFuture, turnCount);
        selectedID = -1;
        bufferID = -1;
        holdID = -1;

        turnChange();
        teamChange();
        //turnCount++;
      }
    }
    break;
    //        SAVING        -----------
  case 11: 
    saveGame();
    break;

    //        LOADING       ------------
  case 12:
    // Open the file from the createWriter() example
    //loadData();
    loadingMenu = true;
    mainMenu = false;
    playing = false;
    choosingMode = false;
    //MainMenuCleanUp();
    loadingMenuSetup();
    break;
  case 13:
    //choosing games
    if (chooseLoad.title[number] != "NO GAME") {
      loadData(chooseLoad.title[number]);
    }
    break;
  case 14:
    //scroll up
    //Checks if it can
    boolean can = true;
    for (int i = 0; i < 5; i++) {
      if (chooseLoad.title[number] == "NO GAME") {
        can = false;
      }
    }
    //It can..
    //if (can) {
    baseLoadCounter -= 5;
    updateLoadButtons();
    //}
    break;
  case 15:
    //scroll down
    //Checks if it can
    boolean canned = true;
    for (int i = 0; i < 5; i++) {
      if (chooseLoad.title[number] == "NO GAME") {
        canned = false;
      }
    }
    //It can..
    // if (canned) {
    baseLoadCounter += 5;
    updateLoadButtons();
    // }
    break;

  case 16:
    choosingMode = true;
    mainMenu = false;
    playing = false;
    choosingModeSetup();
    break;
  }
}

void unselectPiece() {
  if (bufferID != -1) {

    // pieces[bufferID].x = 100;
    // pieces[bufferID].y = 100;
  }

  selectedID = -1;
  bufferID = -1;
  holdID = -1;
}

// 1: SELECT PIECE
// 2: PLACE PIECE
// 3: CONFIRM PIECE
// 4: MOVE PIECE

void mousePressed() {
  pressed = true;
  released = false;
  if (playing) {
    if (mouseX > increment && mouseY > increment && !viewing) {
      if (onePress == false) {
        if (selecting) {
          if (selectedID == -1) {
            if (interactable) {
              pieceSelect(mouseX, mouseY);
            } else {
              int index = getIndex(mouseX - increment, mouseY - increment);
              print("INDEXXXXXXXXXXXXXXXXX " + index + "\n");
              index = Squares[index].pieceID;

              boolean moves = doesMove(index);
              if (!moves) {
                pieceSelect(mouseX, mouseY);
              }
            }
          }
        } else {
          //pieceInteract(mouseX, mouseY);
        }
      }
    }
  }
}

void mouseReleased() {
  pressed = false;
  released = true;
  if (playing) {
    if (mouseX > increment && mouseY > increment && !viewing) {
      if (selecting) {
        if (interactable) {
          piecePlace(mouseX, mouseY);
        } else {
          piecePlace(mouseX, mouseY);
        }
      } else {
        //pieceMove(mouseX, mouseY);
      }
    }
  }
}


//------------------------------------------------------------------------------------------------1
void pieceSelect(int x, int y) {
  x -= increment;
  y -= increment;

  int index = getIndex(x, y);
  if (index != -1) {
    if (Squares[index].pieceID != -1) {
      if (pieces[Squares[index].pieceID].isWhite && !blackTurn) {
        selectedID = Squares[index].pieceID;
        //selecting = false;
      }
      if (!pieces[Squares[index].pieceID].isWhite && blackTurn) {
        selectedID = Squares[index].pieceID;
        //selecting = false;
      }
    }
  }
}

//------------------------------------------------------------------------------------------------2
void piecePlace(int x, int y) {
  x -= increment;
  y -= increment;

  if (selectedID != -1) {
    int index = getIndex(x, y);
    if (index != -1) {
      pieces[selectedID].selX = x;
      pieces[selectedID].selY = y;
      //holdID = selectedID;
      bufferID = selectedID;
      selectedID = -1;
      //selecting = false;
    }
  }
}

//------------------------------------------------------------------------------------------------3
void confirmMove() {
  if (bufferID != -1) {
    pieceMove(pieces[bufferID].selX + increment, pieces[bufferID].selY + increment);
  }
  teamChange();
  turnChange();
}

//------------------------------------------------------------------------------------------------4
void pieceMove(int x, int y) {
  x -= increment;
  y -= increment;
  if (bufferID != -1) {
    int index = getIndex(x, y);
    if (index != -1) {
      int indexCopy = index;
      int xCount = 0;
      int yCount = 0;
      while (indexCopy > 7) {
        yCount++;
        indexCopy -= 8;
      }
      xCount = indexCopy;
      //(xCount + " " + yCount);
      move(bufferID, index, xCount, yCount, false);

      selectedID = -1;
      bufferID = -1;
      holdID = -1;
    }
  }
}

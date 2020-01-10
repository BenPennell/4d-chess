//-------------------------------------------------MASTER-------------------------------------------------------------------

boolean check(piece p, int x, int y) {
  boolean works = false;

  if (p.pieceType == 0) works = checkPawn(p, x, y);
  if (p.pieceType == 1) works = checkKnight(p, x, y);
  if (p.pieceType == 2) works =  checkRook(p, x, y);
  if (p.pieceType == 3) works =  checkBishop(p, x, y);
  if (p.pieceType == 4) works =  checkKing(p, x, y);
  if (p.pieceType == 5) works =  checkQueen(p, x, y);
  ////(works);
  return works;
}

//boolean checkWithPos(
//-------------------------------------------------PAWNS-------------------------------------------------------------------
boolean checkPawn(piece p, int x, int y) {
  //When it's white, the result needs to be negative
  int moveForward = 1;
  int index = (y * 8) + x;
  boolean enemy = false;
  //boolean friend = false;
  if (Squares[index].hasPiece && pieces[Squares[index].pieceID].isWhite != p.isWhite) {
    enemy = true;
  }
  if (Squares[index].hasPiece && pieces[Squares[index].pieceID].isWhite == p.isWhite) {
    //friend = true;
    return false;
  }

  if (p.firstMove) { 
    if (p.isWhite) {
      int spotAhead = 40 + p.gridX;
      if (Squares[spotAhead].hasPiece) {
        if (x - p.gridX == 0) {
          return false;
        }
      }
    } else {
      int spotAhead = 16 + p.gridX;
      if (Squares[spotAhead].hasPiece) {
        if (x - p.gridX == 0) {
          return false;
        }
      }
    }
  }


  if (p.firstMove == true) {
    moveForward = 2;
  }
  if (p.isWhite) {
    //Purely moving forward
    if (y - p.gridY >= -moveForward && y - p.gridY < 0) {
      if (x == p.gridX && !enemy) {

        //p.firstMove = false;
        return true;
      }
    }
    //Attacking L / R
    if (y - p.gridY >= -1 && y - p.gridY < 0) {
      if (abs(x - p.gridX) == 1) {
        if (enemy) {
          // p.firstMove = false;
          return true;
        }
      }
    }
  } else {
    //Purely moving forward
    if (y - p.gridY <= moveForward && y - p.gridY > 0) {
      if (x == p.gridX && !enemy) {
        // p.firstMove = false;
        return true;
      }
    }
    if (y - p.gridY <= 1 && y - p.gridY > 0) {
      if (abs(x - p.gridX) == 1) {
        if (enemy) {
          //  p.firstMove = false;
          return true;
        }
      }
    }
  }
  return false;
}

//-------------------------------------------------Knights-------------------------------------------------------------------
boolean checkKnight(piece p, int x, int y) {
  int index = (y * 8) + x;
  int kingIndex = 4;

  if (p.isWhite) {
    kingIndex = 19;
  }
  if (pieces[kingIndex].alive) {
    if (Squares[index].hasPiece && pieces[Squares[index].pieceID].isWhite == p.isWhite) {
      return false;
    }
  }

  if (abs(y - p.gridY) == 1 && abs(x - p.gridX) == 2) {
    return true;
  } else if (abs(y - p.gridY) == 2 && abs(x - p.gridX) == 1) {
    return true;
  }

  return false;
}

//-------------------------------------------------Rook-------------------------------------------------------------------

boolean checkRook(piece p, int x, int y) {
  int index = (y * 8) + x;
  int kingIndex = 4;

  if (p.isWhite) {
    kingIndex = 19;
  }
  if (pieces[kingIndex].alive) {
    if (Squares[index].hasPiece && pieces[Squares[index].pieceID].isWhite == p.isWhite) {
      return false;
    }
  }
  //VERTICAL
  if (y - p.gridY != 0 && x - p.gridX == 0) {
    int startY = 0;
    int endY = 0;
    if (p.gridY < y) {
      startY = p.gridY;
      endY = y;
    } else {
      startY = -p.gridY;
      endY = -y;
    }
    //int yIncrement = (int)Math.signum((y - p.gridY));

    for (int j = startY; j < endY; j++) {
      index = abs(j * 8) + x;

      if (Squares[index].hasPiece && p.pieceID != Squares[index].pieceID) {
        return false;
      }
      if (j == endY - 1) {
        return true;
      }
    }
  }

  //HORIZONTAL
  if (y - p.gridY == 0 && x - p.gridX != 0) {
    int startX = 0;
    int endX = 0;
    if (p.gridX < x) {
      startX = p.gridX;
      endX = x;
    } else {
      startX = -p.gridX;
      endX = -x;
    }
    //int yIncrement = (int)Math.signum((y - p.gridY));

    for (int j = startX; j < endX; j++) {
      index = abs(y * 8) + abs(j);

      if (Squares[index].hasPiece && p.pieceID != Squares[index].pieceID) {
        return false;
      }
      if (j == endX - 1) {
        return true;
      }
    }
  }

  return false;
}



//-------------------------------------------------Bishop-------------------------------------------------------------------

boolean checkBishop(piece p, int x, int y) {
  int index = (y * 8) + x;

  if (Squares[index].hasPiece && pieces[Squares[index].pieceID].isWhite == p.isWhite) {
    return false;
  }
  if (abs(p.gridY - y) != abs(p.gridX - x)) {
    return false;
  }

  int xCre = (int)Math.signum(x - p.gridX);
  int yCre = (int)Math.signum(y - p.gridY);

  //Checks if diagonal
  for (int j = 0; j < abs(p.gridY - y); j++) {

    //index = (int)((p.gridY - (Math.signum(y) * j)) * 8 + (p.gridX - (Math.signum(x) * j)));
    index = (p.gridY + yCre * j) * 8 + p.gridX + xCre * j;
    if (Squares[index].hasPiece && p.pieceID != Squares[index].pieceID) return false;

    if (j == abs(p.gridY - y) - 1) {
      return true;
    }
  }

  return false;
}

//-------------------------------------------------King-------------------------------------------------------------------

boolean checkKing(piece p, int x, int y) {
  int index = (y * 8) + x;
  ////(y);
  if (p.firstMove ==true) {
    if (abs(p.gridX - x) == 2 && y != 6 && y != 1) {
      int neededY = -1;
      int rookID1 = -1;
      int rookID2 = -1;
      if (p.isWhite && p.firstMove) {
        rookID1 = 23;
        rookID2 = 16;
        neededY = 7;
      }
      if (!p.isWhite && p.firstMove) {
        rookID1 = 0;
        rookID2 = 7;
        neededY = 0;
      }
      ////(p.gridX - x);
      if (neededY != -1) {
        if (p.gridX - x < 0) {
          if (pieces[rookID2].alive == true) {
            if (pieces[rookID2].gridY - y == 0) {
              if (pieces[rookID2].firstMove == true) {
                boolean inWay = true;
                for (int i = 0; i < abs(p.gridX - pieces[rookID2].gridX) + 1; i++) {
                  int newIndex = (p.gridY * 8) + (p.gridX + i);
                  if (Squares[newIndex].hasPiece) {
                    if (Squares[newIndex].pieceID != p.pieceID && Squares[newIndex].pieceID != pieces[rookID2].pieceID) {
                      inWay = false;
                    }
                  }
                }
                if (inWay) {
                  castling = rookID2;
                  castleX = pieces[rookID2].gridX - 2;
                  castleY = pieces[rookID2].gridY;
                }
                return inWay;
              }
            }
          }
        } else {
          if (pieces[rookID1].alive == true) {
            if (pieces[rookID1].gridY - y == 0) {
              if (pieces[rookID1].firstMove == true) {
                boolean inWay = true;
                for (int i = 0; i < abs(p.gridX - pieces[rookID1].gridX) + 1; i++) {
                  int newIndex = (p.gridY * 8) + (p.gridX - i);
                  if (Squares[newIndex].hasPiece) {
                    if (Squares[newIndex].pieceID != p.pieceID && Squares[newIndex].pieceID != pieces[rookID1].pieceID) {
                      inWay = false;
                    }
                  }
                }
                if (inWay) {
                  castling = rookID1;
                  castleX = pieces[rookID1].gridX + 3;
                  castleY = pieces[rookID1].gridY;
                }
                return inWay;
              }
            }
          }
        }
      }
    }
  }

  if (Squares[index].hasPiece && pieces[Squares[index].pieceID].isWhite == p.isWhite) {
    return false;
  }

  if (abs(p.gridY - y) <= 1 && abs(p.gridX - x) <= 1) {
    return true;
  }
  return false;
}

//-------------------------------------------------Queen-------------------------------------------------------------------
boolean checkQueen(piece p, int x, int y) {
  int index = (y * 8) + x;

  if (Squares[index].hasPiece && pieces[Squares[index].pieceID].isWhite == p.isWhite) {
    return false;
  }

  if (checkBishop(p, x, y) || checkRook(p, x, y)) {
    return true;
  }
  return false;
}

//-------------------------------------------------CHECK-------------------------------------------------------------------
//-------------------------------------------------CHECK-------------------------------------------------------------------

//White king is [19]
//Black king is [4]

boolean inCheck(boolean isWhite) {
  int counter = 0;
  int countEnd = 16;
  int x = pieces[19].gridX;
  int y = pieces[19].gridY;

  if (!isWhite) {
    counter += 16;
    countEnd += 16;
    x = pieces[4].gridX;
    y = pieces[4].gridY;
  } 


  for (int i = counter; i < countEnd; i++) {
    if (check(pieces[i], x, y)) {
      if (isWhite) {
        whiteCheck = true;
        return true;
      } else {
        blackCheck = true;
        return true;
      }
    }
  }

  return false;
}

/*
boolean inCheckAt(boolean isWhite, int x, int y) {
 int counter = 0;
 int countEnd = 16;
 // int x = pieces[19].gridX;
 // int y = pieces[19].gridY;
 
 if(!isWhite) {
 counter += 16;
 countEnd += 16;
 //  x = pieces[4].gridX;
 //  y = pieces[4].gridY;
 } 
 
 
 for(int i = counter; i < countEnd; i++) {
 if(check(pieces[i], x, y)) {
 if(isWhite) {
 whiteCheck = true;
 return true;
 } else {
 blackCheck = true;
 return true;
 }
 }
 }
 
 return false;
 }
 */

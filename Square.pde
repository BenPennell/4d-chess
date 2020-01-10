class Square {

  //Position
  int x = 0;
  int y = 0;
  int index = 0;

  boolean hasPiece = false;
  int pieceID = -1;

  //Constructor - Get position
  Square(int x_, int y_, int index_) {
    this.x = x_;
    this.y = y_;
    this.index = index_;
  }

  void addPiece(piece obj) {
    hasPiece = true;
    pieceID = obj.pieceID;
  }

  void removePiece() {
    hasPiece = false;
    pieceID = -1;
  }

  //Render the squares
  void Render(float scale) {
    stroke(255);
    //Set the corners
    float LX = scale * (x - SquareSize);
    float RX = scale * (x + SquareSize);
    float UY = scale * (y - SquareSize);
    float DY = scale * (y + SquareSize);

    //Square time
    fill(50);
    if (index % 2 == 0) {
      fill(255);
    }
    noStroke();
    //rectMode(CENTER);
    square(increment + LX  + (RX - LX) / 4,increment + UY + (RX - LX) / 4, SquareSize * 4);
    //square(increment + LX + ((SquareSize + 1) * 2),increment + UY + ((SquareSize + 1) * 2), SquareSize * 4);
    //Draw the lines
    /*
    line(LX, UY, RX, UY);
     line(LX, DY, RX, DY);
     line(LX, DY, LX, UY);
     line(RX, UY, RX, DY);
     */
  }
}

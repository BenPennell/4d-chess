
//void sendToPast(piece p) {
void sendToPast(int desiredTurn) {
  int newTurn = desiredTurn;
  //Clears out a turn
  newTurn = turn.findNearestFreeTurn(newTurn);

  int ID = bufferID;

  // print("FUTURE TIME \n");
  int x;
  int y;
  x = (pieces[ID].selX); //- increment); // / 8;
  y = (pieces[ID].selY); //- increment); // / 8;
  int index = getIndex(x, y);
  //print(index);
  y = 0;
  x = index;
  while (x >= 8 ) {
    y++;
    x-= 8;
  }
  
  turn.addturn(pieces[ID], x, y, newTurn, desiredTurn);
  turn.resetGame();
  turn.runGame2(trueTurnCount, desiredTurn);
  buttonControlPanel(4,0);
  
  bufferID = -1;
  selectedID = -1;
  holdID = -1;
  
  interactable = true;
}


void timeSetup2(int ID, int desX, int desY, int relTurn, int currentTurn) {
  //SHit   MIGHT WORK
  //Puts the piece into a time machine
  pieces[ID].timeMachine = true;
  pieces[ID].futureMod = 0;

  pieces[ID].futureMod--; 

  //FIX? No, however this will be it though  KEEP THISS CODE
  int endTurn = currentTurn + relTurn;// * 3;
  int startTurn = currentTurn;
  //turn.addTimeMachine(ID, turnCount, endTurn, true);
  int turnOrder = endTurn;
  pieces[ID].returnTurn = endTurn;
  //Puts the final turn first
  endTurn = turn.findNearestFreeTurn(endTurn);
  turn.addturn(pieces[ID], desX, desY, endTurn, turnOrder + 1);
  ///ISSUE THIS WILL BE SAME AS ENDTURN-------------------    -1 should solve
  startTurn = turn.fakefindNearestFreeTurn(startTurn) - 1;
  print(startTurn + "ST \n");
  print(endTurn + "ET \n");

  //save the move in the turn arrays
  //Swaps their things
  turn.timeSwitchF[ID][startTurn] = true;
  turn.timeSwitchB[ID][endTurn] = true;
  for (int c = startTurn - 1; c < endTurn + 2; c++) {
    print(turn.timeSwitchB[ID][c] + "  is the set thing \n");
    print(turn.timeSwitchF[ID][c] + "  is the set thing \n");
  }
  //Remove piece from square
  int index = (pieces[ID].gridY * 8) + pieces[ID].gridX;
  Squares[index].removePiece();

  //Should be put into time Machine
  //int filledTurn = turn.findNearestFreeTurn(turnCount - 1, turnCount - 1);
  //turn.fillTurn(filledTurn);
  ///////        ISSUE---------------------------------------
  //turn.addturn(pieces[ID], desX, desY, endTurn, turnOrder + 1);
  //Fills the turn
  //turn.fillTurn(turnCount);
  //turn.printTurn(endTurn);

  //set the variables in the piece perhaps
}

void findReturnPieces2() {
  
  print("START_------------------------ \n");
  for (int c = 1; c < 10; c++) {
    print(turn.timeSwitchF[30][c] + "  is the set thing \n");
    
  }
  print("NEXT ]n");
  for (int c = 1; c < 10; c++) {
    print(turn.timeSwitchB[30][c] + "  is the set thing \n");
  }
  print("END \n");
  //check if piece needs to come back
  //Variables4\
  for (int i = 0; i < 32; i++) {
    //turn.printTimeMachine(5);
    if (turnCount == pieces[i].returnTurn && pieces[i].timeMachine) {
      print("I am in time Machine num " + i + "   Return turn is " + pieces[i].returnTurn + "   the current num " + turnCount + " MAKING MY MOVE \n");
      returnPiece2(i, turnCount);
      if (turn.turnExecute[turnCount] == turn.turnExecute[turnCount + 1]) {
        turnChange();
      }
    }
    if  (pieces[i].timeMachine) {
      print("I am in time Machine num " + i + "   Return turn is " + pieces[i].returnTurn + "   the current num " + turnCount + "\n");
    }
  }
}
void returnPiece2(int index, int currentTurn) {
  if (index != -1 && turn.movedID[currentTurn] != -1) {
    currentTurn = turnCap - 5;
    while (turn.movedID[currentTurn] != index) {
      currentTurn--;
    }
    int index2 = (pieces[index].gridY * 8) + pieces[index].gridX;
    //kill piece on square

    if (Squares[index2].hasPiece) {
      print(index2 + "Index \n");
      killPiece(index2);
    }
    //brings piece back
    pieces[index].timeMachine = false;
    /*
    for (int c = currentTurn; c < turnCap - 3; c++) {
     //print("WORKING----------------------------------- \n");
     turn.inTimeMachine[index][c] = false;
     }
     */
    //Needs to do the move
    //int currentTurn = turnCount;
    // turn.addTimeMachine(index, currentTurn, 0, false);
    //turn.getTurnEnd();
    /*
    print("current turn thing " + currentTurn + "\n");
     print("current turn EXECUTE " + turn.turnExecute[currentTurn] + "\n");
     print("moved ID" + turn.movedID[currentTurn] + "\n");
     print("Current X Loc " + pieces[index].gridX + "  New X Loc " + turn.xNew[currentTurn] + "\n");
     print("Current Y Loc " + pieces[index].gridY + "  New Y Loc " + turn.yNew[currentTurn] + "\n");  
     */
    int gridIndex = (turn.yNew[currentTurn] * 8) + turn.xNew[currentTurn];
    move(index, gridIndex, turn.xNew[currentTurn], turn.yNew[currentTurn], false);
  }
}



//Time Travel Logic
/*

 Send piece to future
 Feed the 
 pieces ID, 
 Current X & Y,
 Desired X & Y,
 ******Until what turn,
 
 When moving to a New turn
 Check for which pieces need to come back
 Do the moves for those pieces
 
 
 
 */

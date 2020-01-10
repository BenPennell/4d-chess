void saveGame() {
  PrintWriter output;

  String str = "game " + int(random(100000)); 
  saveName(str);
  output = createWriter(str);
  //Just for now

  int index = turn.getTurnEnd() + 2;
  output.println(index); 
  output.flush();
  //Move ID
  for (int i = 0; i < index; i++) {
    output.println(turn.movedID[i]);
  }
  for (int i = 0; i < index; i++) {
    output.println(turn.xLoc[i]);
  }
  for (int i = 0; i < index; i++) {
    output.println(turn.yLoc[i]);
  }
  for (int i = 0; i < index; i++) {
    output.println(turn.xNew[i]);
  }
  for (int i = 0; i < index; i++) {
    output.println(turn.yNew[i]);
  }   
  for (int k = 0; k < pieceMax; k++) { 
    for (int i = 0; i < index; i++) {
      output.println(turn.inTimeMachine[k][i]);
    }
  }
  for (int k = 0; k < pieceMax; k++) {
    for (int i = 0; i < index; i++) {
      output.println(turn.timeSwitchF[k][i]);
    }
  }
  for (int k = 0; k < pieceMax; k++) {
    for (int i = 0; i < index; i++) {
      output.println(turn.timeSwitchB[k][i]);
    }
  }
  for (int k = 0; k < pieceMax; k++) {
    for (int i = 0; i < index; i++) {
      output.println(turn.isDead[k][i]);
    }
  }
  for (int i = 0; i < index; i++) {
    output.println(turn.teamChange[i]);
  }
  for (int i = 0; i < index; i++) {
    output.println(turn.turnExecute[i]);
  }
  output.flush();
  output.close();
}

void loadData(String name) {
  BufferedReader reader = createReader(name);
  String line = null;
  int spacing = 2;

  try {
    ArrayList<String> data = new ArrayList<String>();
    String[] datas;
    int dataChange = 1;
    while ((line = reader.readLine()) != null) {
      datas = split(line, ENTER);
      for (int i = 0; i < datas.length; i++) {
        data.add(datas[i]);
      }
    }

    int counter = 0;
    int m;
    int l;
    for (String d : data) {
      if (counter == 0) {
        dataChange = int(d);
      }
      counter++;
      //    MOVEDID
      if (counter >= spacing && counter < spacing + dataChange) {
        turn.movedID[counter - spacing] = int(d);
        //println(int(d));
      }
      m = 1;
      if (counter >= spacing + dataChange * m && counter < spacing + dataChange * (m + 1)) {
        turn.xLoc[counter - spacing - dataChange * m] = int(d);
        println(int(d));
      }
      m = 2;
      if (counter >= spacing + dataChange * m && counter < spacing + dataChange * (m + 1)) {
        turn.yLoc[counter - spacing - dataChange * m] = int(d);
      }
      m = 3;
      if (counter >= spacing + dataChange * m && counter < spacing + dataChange * (m + 1)) {
        turn.xNew[counter - spacing - dataChange * m] = int(d);
      }
      m = 4;
      if (counter >= spacing + dataChange * m && counter < spacing + dataChange * (m + 1)) {
        turn.yNew[counter - spacing - dataChange * m] = int(d);
      }
      m = 5;
      if (counter >= spacing + dataChange * m && counter < spacing + dataChange * (m + 1) + (31 * dataChange)) {
        int num1 = counter;
        int startNum = counter - spacing - dataChange * m;
        num1 = startNum / dataChange;
        int newNum = startNum - num1 * dataChange;
        turn.inTimeMachine[num1][newNum] = boolean(d);
      }
      m = 6;
      l = 1;
      if (counter >= spacing + dataChange * (m) + (31 * dataChange) && counter < spacing + dataChange * (m + 1) + (31 * dataChange * (l + 1))) {
        int num1 = counter;
        int startNum = counter - spacing - dataChange * m - dataChange * 31;
        num1 = startNum / dataChange;
        int newNum = startNum - num1 * dataChange;
        turn.timeSwitchF[num1][newNum] = boolean(d);
      } 
      m = 7;
      l = 2;
      if (counter >= spacing + dataChange * (m) + (31 * dataChange * l) && counter < spacing + dataChange * (m + 1) + (31 * dataChange * (l + 1) - 1)) {
        int num1 = counter;
        int startNum = counter - spacing - dataChange * m - dataChange * 31 * l;
        num1 = startNum / dataChange;
        int newNum = startNum - num1 * dataChange;
        turn.timeSwitchB[num1][newNum] = boolean(d);
      } 
      m = 8;
      l = 3;
      if (counter >= spacing + dataChange * (m) + (31 * dataChange * l) && counter < spacing + dataChange * (m + 1) + (31 * dataChange * (l + 1))) {
        int num1 = counter;
        int startNum = counter - spacing - dataChange * m - dataChange * 31 * l;
        num1 = startNum / dataChange;
        int newNum = startNum - num1 * dataChange;
        turn.isDead[num1][newNum] = boolean(d);
        //println(num1 + " " + newNum);
      } 
      m = 9;
      l = 4;
      if (counter >= spacing + dataChange * (m) + (31 * dataChange * l) && counter < spacing + dataChange * (m + 1) + (31 * dataChange * l)) {
        int startNum = counter - spacing - dataChange * m - dataChange * 31 * l;
        println(startNum);
        turn.teamChange[startNum] = boolean(d);
      } 
      m = 10;
      l = 4;
      if (counter >= spacing + dataChange * (m) + (31 * dataChange * l) && counter < spacing + dataChange * (m + 1) + (31 * dataChange * l)) {
        int startNum = counter - spacing - dataChange * m - dataChange * 31 * l;
        turn.turnExecute[startNum] = int(d);
      } 
      /*
        for (int j = spacing; j < spacing + dataChange; j++) {
       turn.movedID[j - spacing] = int(d);
       }
       multiplier = 1;
       for (int j = spacing + dataChange * multiplier; j < spacing + dataChange * (multiplier + 1); j++) {
       turn.xLoc[j - spacing] = int(d);
       }
       multiplier = 2;
       for (int j = spacing + dataChange * multiplier; j < spacing + dataChange * (multiplier + 1); j++) {
       turn.yLoc[j - spacing] = int(d);
       }
       multiplier = 3;
       for (int j = spacing + dataChange * multiplier; j < spacing + dataChange * (multiplier + 1); j++) {
       turn.xNew[j - spacing] = int(d);
       }
       multiplier = 4;
       for (int j = spacing + dataChange * multiplier; j < spacing + dataChange * (multiplier + 1); j++) {
       turn.yNew[j - spacing] = int(d);
       }
       multiplier = 5;
       for (int j = spacing + dataChange * multiplier; j < spacing + dataChange * (multiplier + 1); j++) {
       for (int k = 0; k < pieceMax; k++) {
       turn.inTimeMachine[k][j - spacing] = boolean(d);
       }
       }
       multiplier = 6;
       for (int j = spacing + dataChange * multiplier; j < spacing + dataChange * (multiplier + 1); j++) {
       for (int k = 0; k < pieceMax; k++) {
       turn.timeSwitchF[k][j - spacing] = boolean(d);
       }
       }
       multiplier = 7;
       for (int j = spacing + dataChange * multiplier; j < spacing + dataChange * (multiplier + 1); j++) {
       for (int k = 0; k < pieceMax; k++) {
       turn.timeSwitchB[k][j - spacing] = boolean(d);
       }
       }
       multiplier = 8;
       for (int j = spacing + dataChange * multiplier; j < spacing + dataChange * (multiplier + 1); j++) {
       for (int k = 0; k < pieceMax; k++) {
       turn.isDead[k][j - spacing] = boolean(d);
       }
       }        
       multiplier = 9;
       for (int j = spacing + dataChange * multiplier; j < spacing + dataChange * (multiplier + 1); j++) {
       turn.teamChange[j - spacing] = boolean(d);
       }
       multiplier = 10;
       for (int j = spacing + dataChange * multiplier; j < spacing + dataChange * (multiplier + 1); j++) {
       turn.turnExecute[j - spacing] = int(d);
       }
       */
    }
    reader.close();
    viewing = true;
    loadingMenu = false;
    choosingMode = false;
    playing = true;
    //MainMenuCleanUp();
    //EndScreenCleanUp();
    GameSetup();
  } 
  catch (IOException e) {
    e.printStackTrace();
  }
}

void saveName(String Name) {
  BufferedReader reader = createReader("SavedGames.txt");
  String[] datas = null;
  String line = null;
  //Makes it into a new file
  PrintWriter output;
  output = createWriter("SavedGames.txt");
  try {
    while ((line = reader.readLine()) != null) {
      datas = split(line, ENTER);



      for (String d : datas) {
        output.println(d);
      }
    }
  }
  catch(IOException e) {
    e.printStackTrace();
  }

  output.flush();
  output.println(Name);
  output.flush();
  output.close();
}

//Base counter
int baseLoadCounter = 0;

void loadingMenuSetup() {
  int[] whatDoesM = new int[5];
  int[] whatDoesingM = new int[5];
  whatDoesM[0] = 2;
  whatDoesingM[0] = 2;

  quit = new Button(0, 0, 75, 75, 1, 2, false, whatDoesM, whatDoesingM);
  quit.setTitle("Menu", 0);

  for (int i = 0; i < 5; i++) {
    whatDoesM[i] = 13;
  }
  chooseLoad = new Button(100, 100, 500, 500, 5, 69, true, whatDoesM, whatDoesingM);
  for (int i = 0; i < 5; i++) {
    chooseLoad.setTitle("NO GAME", i);
  }
  BufferedReader reader = createReader("SavedGames.txt");
  String line = null;
  String[] datas = null;
  String[] Info = null;
  int counter = 0;
  baseLoadCounter = 0;
  try {
    while ((line = reader.readLine()) != null) {
      datas = split(line, TAB);
      //print(datas.length);
      //Info = datas;
      //for (int i = 0; i < datas.length; i++) {
      for (String d : datas) {
        if (counter < baseLoadCounter + 5 && counter >= baseLoadCounter) {
          chooseLoad.setTitle(d, counter);
          chooseLoad.buttonNumber[counter] = counter;
        }
      }
      counter++;
    }
  } 
  catch(IOException e) {
    e.printStackTrace();
  }

  whatDoesM[0] = 14;
  whatDoesM[1] = 15;
  loadArrows = new Button(0, 100, 100, 800, 2, 70, true, whatDoesM, whatDoesingM);
  loadArrows.setTitle("^", 0);
  loadArrows.setTitle("v", 1);
}

void updateLoadButtons() {
  for (int i = 0; i < 5; i++) {
    chooseLoad.setTitle("NO GAME", i);
  }
  BufferedReader reader = createReader("SavedGames.txt");
  String line = null;
  String[] datas = null;
  String[] Info = null;
  int counter = 0;
  try {
    while ((line = reader.readLine()) != null) {
      datas = split(line, TAB);
      //print(datas.length);
      //Info = datas;
      //for (int i = 0; i < datas.length; i++) {
      for (String d : datas) {
        if (counter < baseLoadCounter + 5 && counter >= baseLoadCounter) {
          chooseLoad.setTitle(d, counter - baseLoadCounter);
          chooseLoad.buttonNumber[counter - baseLoadCounter] = counter - baseLoadCounter;
        }
      }
      counter++;
    }
  } catch(IOException e) {
    e.printStackTrace();
  }
}
void loadingMenuDraw() {
  quit.render();
  quit.chooseOption();
  chooseLoad.render();
  chooseLoad.chooseOption();
  loadArrows.render();
  loadArrows.chooseOption();
  released = false;
}

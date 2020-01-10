String end;

void EndScreenSetUp(boolean isWhite) {
  if(isWhite) {
    end = "WHITE WINS";
  } else {
    end = "BLACK WINS";
  }
  int[] whatDo = new int[100];
  whatDo[0] = 1;
  int[] whatDo2ElectricBoogaloo = new int[100];
  whatDo2ElectricBoogaloo[0] = 0;
  start = new Button(width/10, 100, width/3, 200, 1, 1, false, whatDo, whatDo);  
  whatDo[0] = 2;
  menu = new Button(width/10, 210, width/3, 310, 1, 1, true, whatDo, whatDo);
  Quit = new Button(width/10, 320, width/3, 420, 1, 1, true, whatDo2ElectricBoogaloo, whatDo); 
  whatDo2ElectricBoogaloo[0] = 11;
  whatDo[0] = 11;
  save = new Button(width/10, 430, width/3, 530, 1, 1, true,  whatDo2ElectricBoogaloo, whatDo); 
  
  start.setTitle("NEW GAME", 0);
  Quit.setTitle("QUIT", 0);
  menu.setTitle("MENU", 0);
  save.setTitle("SAVE", 0);
}

void EndScreenDraw() {
  background(51);
  fill(255);
  textSize(24);
  text(end, width/6, 49);
  Quit.render();
  Quit.chooseOption();
  menu.render();
  menu.chooseOption();
  start.render();
  start.chooseOption();
  save.render();
  save.chooseOption();
  line(50, 0, 50, height);
  line(0, 50, width, 50);
  released = false;
}

void EndScreenCleanUp() {
  playing = true;
  finished = false;
  mainMenu = false;
}

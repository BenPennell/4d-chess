

//Initializes the game
void MainMenuSetup() {
  int[] whatDo = new int[100];
  whatDo[0] = 16;
  int[] whatDo2ElectricBoogaloo = new int[100];
  whatDo2ElectricBoogaloo[0] = 0;
  start = new Button(width/10, 100, width/3, 200, 1, 1, false, whatDo, whatDo);  
  Quit = new Button(width/10, 210, width/3, 310, 1, 1, true, whatDo2ElectricBoogaloo, whatDo);
  whatDo2ElectricBoogaloo[0] = 12;
  save = new Button(width/10, 320, width/3, 420, 1, 1, true,  whatDo2ElectricBoogaloo, whatDo); 
  start.setTitle("PLAY", 0);
  Quit.setTitle("QUIT", 0);
  save.setTitle("LOAD", 0);
  //mainBack = loadImage("backGround.jpg");
  //mainBack.resize(width, height);
  ////(VerticalStart.title[0]);
}

void MainMenuDraw() {
  //background(mainBack);
  background(51);
  fill(255);
  textSize(24);
  text("4D CHESS", width/6, 49);
  Quit.render();
  Quit.chooseOption();
  start.render();
  start.chooseOption();
  save.render();
  save.chooseOption();
  line(50, 0, 50, height);
  line(0, 50, width, 50);
  released = false;
}
//Kills variables and such
void MainMenuCleanUp() {
  choosingMode = true;
  mainMenu = false;
  finished = false;
}

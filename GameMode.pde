void choosingModeSetup() {
  int[] whatDo = new int[2];
  whatDo[0] = 1;
  playNorm = new Button(width/10, 100, width/3, 200, 1, 1, false, whatDo, whatDo);  
  playNorm.setTitle("LOCAL PLAY", 0 );
}

void choosingModeDraw() {
  playNorm.render();
  playNorm.chooseOption();
  released = false;
}

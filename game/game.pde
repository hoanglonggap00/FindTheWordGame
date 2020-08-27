String[] ListOfWords = {"baboons", "beavers", "cats", "chickens", "choughs", "dolphins", "eagles", 
  "elephants", "flamingos", "giraffes", "fish", "hedgehog", "hornet", "kangaroos"};
int[] positionY = new int[4];
int[] positionX = new int[7];
int[] positionSecret = new int[20];
char[] charactor = new char[28];
boolean[] click = new boolean[28];
int[][] convert = new int[4][7];
float[] dotX = new float[28];
float[] dotY = new float[28];
color[] c = new color[28];
String secretWord = ListOfWords[round(random(13))].toUpperCase();
boolean[] checkChar= new boolean[28];
String[] answer = new String[randomWord()];
String done;
int X = 10;
int m = 65;
int num = 0;
int maxNum = randomWord();
boolean bonus = false;

void setup() {
  size(1000, 1000);
  int Y = height/2;
  for (int i = 0; i < 4; i++ ) {
    positionY[i] = Y;
    Y += height/8;
  }
  for (int j = 0; j < 7; j++ ) {
    positionX[j] = X;
    X += width/12 - 5;
  }
  for (int i = 0; i < 28; i++) {
    checkChar[i] = false;
  }
  for (int i = 0; i< randomWord()+2; i++) {
    dotX[i] = random(((width*3/4) - 135), ((width*3/4)+135));
    dotY[i] = random(((height*3/4) - 135), ((height*3/4)+135));
    c[i] = color(0, 255, 0);
  }
  println(secretWord);
}

void draw() {
  background(#6d9bc3);
  rectMode(CORNER);
  keypad();
  game_instruction();
  rectMode(CENTER);
  screen();
  chance_box();
  if (click[27] == true) {
    randomCircle();
    //check();
    bonus();
    if(!gameEnd()){
     check(); 
    };
  }
  frameRate(5);
  //printArray(int(charactor));
}

char array_of_char(int x) {
  for (int k = 0; k < 26; k++ ) {
    charactor[k] = char(m);
    if (m < 65+25) {
      m ++;
    } else {
      m = 65;
    }
  }
  charactor[26] = char(43);
  charactor[27] = char(33);
  return charactor[x];
}

void game_instruction() {
  fill(0, 0, 255);
  textSize(20);
  text("WELCOME TO THE GAME", 20, 50);
  text("Click on ! to start the game", 20, 80);
  textSize(15);
  if (click[27] == true) {
    text("You have " + randomWord() + " words to Guess", 20, 120);
  }
  if (bonus == true) {
    textSize(20);
    text("Please click on + to get bonus chance!!",width/6,height/6);
  }
}

void screen() {
  int wordX = width/6;
  for (int i = 0; i< randomWord(); i++) {
    positionSecret[i] = wordX;
    fill(#7C03FF);
    rect(wordX, height/4, 70, 70);
    if (checkChar[i] == true) {
      fill(#05FFF0);
      textSize(30);
      text((secretWord.toLowerCase()).charAt(i), wordX - 10, height/4+15);
    }
    wordX += 90;
  }
  randomWord();
}

void keypad() {
  int k = 0;
  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 7; j++ ) {
      convert[i][j] = k;
      fill(0, 255, 0);
      rect(positionX[j], positionY[i], 70, 70);
      fill(0);
      textSize(30);
      text(array_of_char(k), positionX[j]+25, positionY[i]+45);
      if (click[k] == true) {
        line(positionX[j], positionY[i], positionX[j] + 70, positionY[i] +70);
      }
      k++;
    }
  }
}

void check() {
  for (int i = 0; i < 28; i++) {
    for (int k = 0; k < randomWord(); k++) {
      if (click[i] == true) {
        if (array_of_char(i) == (secretWord.charAt(k))) {
          checkChar[k] = true;
          answer[k] = str(secretWord.charAt(k));
        }
      }
    }
  }
}

void bonus() {
  if (click[26] == true) {
    for (int i = randomWord(); i < randomWord() + 2; i++) {
      ellipseMode(CENTER);
      fill(c[i]);
      ellipse(dotX[i], dotY[i], 30, 30);
    }
  }
}

void randomCircle() {
  if (click[27] == true) {
    for (int i = 0; i < randomWord(); i++ ) {
      ellipseMode(CENTER);
      fill(c[i]);
      ellipse(dotX[i], dotY[i], 30, 30);
    }
  }
}

void chance_box() {
  fill(0, 0, 255);
  rect((width*3)/4, (height*3)/4, 300, 300);
}

int randomWord() {
   
  return secretWord.length();
}

boolean gameEnd() {
  
  boolean result = false;
  done = join(answer,"");
  if (num<maxNum) {
    if (done.equals(secretWord)) {
      fill(0,0,255);
      textSize(15);
      text("You Win!!!",width/6,height/6+30);
    }
    result = true;
  } 
  else if (num >= maxNum) {
      fill(0,0,255);
      textSize(15);
      text("Better Luck Next Time, Word = " + secretWord,width/6,height/6+30);
      result = true;
  }
  return result;
}
   

void mouseClicked() {
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 7; j++ ) {
        if (mouseX > positionX[j] && mouseX < positionX[j] + 70) {
          if (mouseY > positionY[i] && mouseY < positionY[i] + 70) {
            click[convert[i][j]] = true;
            if (click[26] == true && bonus == false) {
              click[26] = false;
            }
            if (click[27] == false) {
              click[convert[i][j]] = false;
            } 
          if (click[27] == true && convert[i][j] < 26) {
            c[num] = color(255, 0, 0);
            if (num < maxNum) {
              num +=1;
              if (maxNum - num == 1) {
                bonus = true;
                if (click[26] == true) {
                  maxNum += 2;
                }
              }
            }
          }
        }
      }
    }
  }
}

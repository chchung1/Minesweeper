import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 20;
private final static int NUM_COLS = 20;
private final static int NUM_MINES = 70;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined
public int type = 0;
public int slimed = NUM_MINES;
boolean lose = false;

void setup ()
{
  size(800, 900);
  background( 0 );
  textAlign(CENTER, CENTER);

  // make the manager
  Interactive.make( this );

  //your code to initialize buttons goes here
  buttons = new MSButton[NUM_ROWS][NUM_COLS];

  for (int r = 0; r < NUM_ROWS; r++) {
    for (int c = 0; c < NUM_COLS; c++) {
      buttons[r][c] = new MSButton(r, c);
    }
  }
  setMines();
}

public void setMines()
{
  //your code
  while (mines.size() < NUM_MINES) {
    int r = (int)(Math.random()*NUM_ROWS);
    int c = (int)(Math.random()*NUM_COLS);
    if (mines.contains(buttons[r][c])==false) {
      mines.add(buttons[r][c]);
    }
  }
}

public void draw ()
{
  background(0);
  fill(255, 209, 201);
  drawSlime(50, 880);
  textSize(30);
  fill(255);
  text(slimed, 95, 865);
  if (isWon() == true)
    displayWinningMessage();
  if(lose == true)
    displayLosingMessage();
}
public boolean isWon()
{
  //your code here
  int count = 0;  
  for (int i = 0; i < mines.size(); i++) {
    if (mines.get(i).isFlagged()==true)
      count++;
  }
  if (count == NUM_MINES && slimed==0)
    return true;
  else
    return false;
}

public void displayLosingMessage()
{
  //your code here
  textSize(30);
  fill(255);
  text("attacked by slimes :(", 400, 820);
  text("click around to see ur assailants",400,850);
  
  for(int i = 0; i < mines.size(); i++){
    mines.get(i).flagged=false;
    mines.get(i).clicked=true;
  }
 
}
public void displayWinningMessage()
{
  //your code here
  textSize(30);
  fill(255);
  text("CONGRATULATIONS! YOU WIN!", 400, 820);
  
}
public boolean isValid(int r, int c)
{
  //your code here
  if (r >= 0 && r < NUM_ROWS && c >= 0 && c < NUM_COLS)
    return true;
  else
    return false;
}
public int countMines(int row, int col)
{
  int numMines = 0;
  //your code here
  for (int r = row-1; r <= row+1; r++) {
    for (int c = col-1; c <= col+1; c++) {
      if (isValid(r, c) && mines.contains(buttons[r][c]) == true) {
        numMines++;
      }
    }
  }
  return numMines;
}
public class MSButton
{
  private int myRow, myCol;
  private float x, y, width, height;
  private boolean clicked, flagged;
  private String myLabel;

  public MSButton ( int row, int col )
  {

    width = 800/NUM_COLS;
    height = 800/NUM_ROWS;
    myRow = row;
    myCol = col; 
    x = myCol*width;
    y = myRow*height;
    myLabel = "";
    flagged = clicked = false;
    Interactive.add( this ); // register it with the manager
  }

  // called by manager
  public void mousePressed () 
  {
    type = (int)(Math.random()*7);
    clicked = true;
    //your code here
    if (mouseButton == RIGHT) {
      if (flagged == true) {
        flagged = false;
        clicked = false;
        slimed++;
      } else {
        flagged = true;
        slimed--;
      }
    } else if (mines.contains(this)) {
      lose=true;
    } else if (countMines(myRow, myCol)> 0) {
      setLabel(countMines(myRow, myCol));
    } else {
      for (int r = myRow-1; r <= myRow+1; r++) {
        for (int c = myCol-1; c <= myCol+1; c++) {
          if (isValid(r, c) && buttons[r][c].clicked == false) {
            buttons[r][c].mousePressed();
          }
        }
      }
    }
  }
  public void draw () 
  {    

    if (flagged) {

      fill(55, 55, 55 );
      rect(x, y, width, height);
      
      noStroke();
      
      fill(205, 205, 205 );
      rect(x+15, y+10, 10, 20);
      triangle(x+15, y+10, x+20, y+5, x+25, y+10);

      stroke(91, 91, 91 );
      line(x+20, y+5, x+20, y+30);

      stroke(1);
      
      fill(255, 205, 46 );
      rect(x+10, y+25, 20, 5);
 
      fill(182, 136, 88  );
      rect(x+18, y+30, 4, 7);
     
    } else if ( clicked && mines.contains(this) ) {

      fill(144, 190, 107 );
      rect(x, y, width, height);

      if (type == 0) { //pyro
      
        fill(255, 173, 62);
        drawSlime(x+width/2, y+35);
        
        noStroke();

        fill(255, 131, 20);
        triangle(x+7, y+18, x+18, y+12, x+9, y+25);
        triangle(x+33, y+18, x+22, y+12, x+31, y+25);
        triangle(x+14, y+13, x+26, y+13, x+20, y+27);

        fill(255, 222, 55);
        triangle(x+8, y+33, x+16, y+35, x+10, y+28);
        triangle(x+32, y+33, x+24, y+35, x+30, y+28);
        triangle(x+20, y+30, x+16, y+35, x+24, y+35);

        fill(254, 43, 16);
        ellipse(x+10, y+14, 5, 10);
        ellipse(x+30, y+14, 5, 10);
        
      } else if (type==1) { //hydro
      
        fill(79, 215, 237);
        drawSlime(x+width/2, y+35);
        
        noStroke();
        fill(56, 191, 213);
        ellipse(x+11, y+20, 10, 7);
        ellipse(x+29, y+20, 10, 7);
        ellipse(x+20, y+16, 12, 8);
        
        fill(42, 173, 194);
        ellipse(x+11, y+19, 8, 4);
        ellipse(x+29, y+19, 8, 4);
        ellipse(x+20, y+15, 7, 5);
        
        fill(134, 222, 236);
        ellipse(x+10, y+31, 8, 6);
        ellipse(x+30, y+31, 8, 6);
        ellipse(x+20, y+32, 12, 7);
        
        fill(182, 233, 241);
        ellipse(x+15, y+33, 8, 4);
        ellipse(x+25, y+33, 8, 4);
        
        fill(179, 244, 255);
        ellipse(x+10, y+14, 5, 10);
        ellipse(x+30, y+14, 5, 10);
        
      } else if (type==2) { //electro
      
        fill(126, 74, 207);
        triangle(x+18, y+12, x+22, y+12, x+20, y+7);
        fill(229, 197, 254 );
        ellipse(x+20, y+6, 3, 3);
        
        fill(126, 74, 207);
        drawSlime(x+width/2, y+37);
        
        noStroke();
        
        fill(229, 197, 254 );
        rect(x+12, y+16.5, 3.5, 7);
        rect(x+24.5, y+16.5, 3.5, 7);
        ellipse(x+6, y+27, 5, 10);
        ellipse(x+34, y+27, 5, 10);
        
        fill(126, 74, 207);
        ellipse(x+5, y+28, 3, 8);
        ellipse(x+35, y+28, 3, 8);
        
      } else if (type==3) { //cryo
      
        fill(183, 227, 252);
        drawSlime(x+width/2, y+35);
        
        noStroke();

        fill(226, 238, 248);
        ellipse(x+14, y+17, 8, 6);
        ellipse(x+26, y+17, 8, 6);

        fill(141, 189, 228);
        ellipse(x+10, y+25, 5, 5);
        ellipse(x+30, y+25, 5, 5);

        fill(255);
        ellipse(x+10, y+18, 6, 8);
        ellipse(x+20, y+18, 8, 10);
        ellipse(x+30, y+18, 6, 8);
        ellipse(x+6, y+28, 4, 4);
        ellipse(x+34, y+28, 4, 4);


        fill(117, 202, 255 );
        triangle(x+20, y+15, x+20, y+21, x+17, y+18);
        triangle(x+20, y+15, x+20, y+21, x+23, y+18);
        
      } else if (type==4) { //anemo
      
        fill(183, 252, 227);
        drawSlime(x+width/2, y+35);
        
        noStroke();
        
        fill(65, 148, 120);
        ellipse(x+20, y+18, 7, 7);
        
        fill(237, 255, 249);
        ellipse(x+10, y+9, 4, 8);
        ellipse(x+7, y+12, 8, 4);
        ellipse(x+30, y+9, 4, 8);
        ellipse(x+33, y+12, 8, 4);
        ellipse(x+20, y+18, 5, 5);
        
        fill(92, 181, 151);
        triangle(x+7, y+17, x+15, y+13, x+13, y+25);
        triangle(x+33, y+17, x+25, y+13, x+27, y+25);
        
        fill(142, 230, 201);
        triangle(x+8, y+18, x+14, y+14, x+13, y+24);
        triangle(x+32, y+18, x+26, y+14, x+27, y+24);
        
      } else if (type==5) { //geo
      
        fill(123, 110, 94);
        drawSlime(x+width/2, y+35);
        
        noStroke();

        fill(63, 48, 30);
        triangle(x+8, y+18, x+14, y+8, x+18, y+13);
        triangle(x+32, y+18, x+26, y+8, x+22, y+13);

        fill(74, 65, 53);
        rect(x+16, y+14, 8, 6);
        triangle(x+16, y+14, x+16, y+20, x+13, y+17);
        triangle(x+24, y+14, x+24, y+20, x+27, y+17);

        fill(70, 57, 42);
        rect(x+7, y+20, 5, 5);
        rect(x+29, y+20, 5, 5);

        fill(89, 75, 59);

        rect(x+5, y+26, 3, 3);
        rect(x+33, y+26, 3, 3);
        triangle(x+8, y+5, x+8, y+18, x+14, y+14);
        triangle(x+32, y+5, x+32, y+18, x+26, y+14);

        fill(195, 218, 194);
        ellipse(x+8, y+17, 6, 6);
        ellipse(x+32, y+17, 6, 6);
        fill(139, 174, 138);
        ellipse(x+8, y+17, 4, 4);
        ellipse(x+32, y+17, 4, 4);
        
      } else { //dendro
      
        fill(172, 255, 75);
        drawSlime(x+width/2, y+37);

        noStroke();

        fill(202, 255, 160); 
        rect(x+19, y+7, 3, 6);
        
        fill(255, 179, 160);
        ellipse(x+17, y+8, 5, 5);
        ellipse(x+24, y+8, 5, 5);
        ellipse(x+21, y+7, 7, 7);
        
        fill(255, 210, 199);
        ellipse(x+17, y+8, 2, 2);
        ellipse(x+24, y+8, 2, 2);
        ellipse(x+21, y+7, 4, 4);

        fill(151, 228, 63);
        ellipse(x+9, y+23, 6, 9);
        ellipse(x+20, y+19, 6, 11);
        ellipse(x+31, y+23, 6, 9);

        fill(126, 195, 47);
        ellipse(x+14, y+19, 6, 8);
        ellipse(x+26, y+19, 6, 8);
        
      }
    } else if (clicked) {
      fill( 201, 235, 157  );
      rect(x, y, width, height);
    } else {
      fill( 165, 140, 120  );
      rect(x, y, width, height);
    }
    fill(0);
    text(myLabel, x+width/2, y+height/2);
    stroke(1);
  }
  public void setLabel(String newLabel)
  {
    myLabel = newLabel;
  }
  public void setLabel(int newLabel)
  {
    myLabel = ""+ newLabel;
  }
  public boolean isFlagged()
  {
    return flagged;
  }
  
}
public void drawSlime(float slimeX, float slimeY) {
  beginShape();
  curveVertex(slimeX, slimeY-24);
  curveVertex(slimeX, slimeY-24);
  curveVertex(slimeX+1, slimeY-23.5);

  curveVertex(slimeX+5, slimeY-23);
  curveVertex(slimeX+10, slimeY-21);

  curveVertex(slimeX+15, slimeY-16);
  curveVertex(slimeX+17, slimeY-8.5);

  curveVertex(slimeX+15, slimeY-3.5);
  curveVertex(slimeX+10, slimeY-1);

  curveVertex(slimeX, slimeY);

  curveVertex(slimeX-10, slimeY-1);
  curveVertex(slimeX-15, slimeY-3.5);

  curveVertex(slimeX-17, slimeY-8.5);
  curveVertex(slimeX-15, slimeY-16);

  curveVertex(slimeX-10, slimeY-21);
  curveVertex(slimeX-5, slimeY-23);

  curveVertex(slimeX-1, slimeY-23.5);
  curveVertex(slimeX, slimeY-24);
  curveVertex(slimeX, slimeY-24);
  endShape();

  fill(255, 246, 225);
  ellipse(slimeX+5, slimeY-10, 3.5, 6);
  ellipse(slimeX-5, slimeY-10, 3.5, 6);
}

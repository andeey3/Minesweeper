import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
private final static int NUM_ROWS = 10;
private final static int NUM_COLS = 10;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
  size(400, 400);
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
  setMines();
  setMines();
  setMines();
  setMines();
  setMines();
  setMines();
  setMines();
  setMines();
  setMines();
  setMines();
  setMines();
}
public void setMines()
{
  //your code
  int rowz = (int)(Math.random()*NUM_ROWS);
  int colz = (int)(Math.random()*NUM_COLS);
  if (mines.contains(buttons[rowz][colz]) == false)
    mines.add(buttons[rowz][colz]);
}
public void draw ()
{
  background( 0 );
  if (isWon() == true)
    displayWinningMessage();
}
public boolean isWon()
{
  //your code here
  int counterFlag = 0;
  for (int i = 0; i < mines.size(); i++) {
    if (mines.get(i).isFlagged() == true) {
      counterFlag++;
    }
  }
  for (int r = 0; r < buttons.length; r ++) {
    for (int c = 0; c < buttons[r].length; c++) {
      if (buttons[r][c].isFlagged() == true) {
      }
    }
  }
  if (counterFlag == mines.size()) {
    return true;
  }
  return false;
}
public void displayLosingMessage()
{
  //your code here
  buttons[NUM_ROWS/2][NUM_COLS/2 - 4].setLabel("Y");
  buttons[NUM_ROWS/2][NUM_COLS/2 - 3].setLabel("O");
  buttons[NUM_ROWS/2][NUM_COLS/2 - 2].setLabel("U");
  buttons[NUM_ROWS/2][NUM_COLS/2 - 1].setLabel("L");
  buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("O");
  buttons[NUM_ROWS/2][NUM_COLS/2 + 1].setLabel("S");
  buttons[NUM_ROWS/2][NUM_COLS/2 + 2].setLabel("E");
  fill(225);
}
public void displayWinningMessage()
{
  //your code here
  buttons[NUM_ROWS/2][NUM_COLS/2 - 3].setLabel("Y");
  buttons[NUM_ROWS/2][NUM_COLS/2 - 2].setLabel("O");
  buttons[NUM_ROWS/2][NUM_COLS/2 - 1].setLabel("U");
  buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("W");
  buttons[NUM_ROWS/2][NUM_COLS/2 + 1].setLabel("I");
  buttons[NUM_ROWS/2][NUM_COLS/2 + 2].setLabel("N");
  fill(230);
}
public boolean isValid(int r, int c)
{
  //your code here
  if (r < NUM_ROWS &&  r >=0 && c >=0 && c <  NUM_COLS) {
    return true;
  } else {
    return false;
  }
}
public int countMines(int row, int col)
{
  int numMines = 0;
  if (mines.contains(buttons[row][col]))
    numMines--;
  for (int r = row-1; r < row+2; r++) {
    for (int c = col-1; c < col+2; c++) {
      if (isValid(r, c)&& mines.contains(buttons[r][c]) == true) {
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
    width = 400/NUM_COLS;
    height = 400/NUM_ROWS;
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
    clicked = true;
    if (mouseButton == RIGHT) {
      if (flagged == true) {
        flagged = false;
        clicked = false;
      }
      if (flagged == false) {
        flagged = true;
      }
    } else if (mines.contains(this))
      displayLosingMessage();

    else if (countMines(myRow, myCol) > 0)
      setLabel(countMines(myRow, myCol));

    else {
      for (int i = -1; i < 2; i++) {
        if (isValid(myRow + i, myCol - 1) == true && buttons[myRow + i][myCol - 1].clicked == false)
          buttons[myRow + i][myCol - 1].mousePressed();
      }
      if (isValid(myRow - 1, myCol) == true && buttons[myRow - 1][myCol].clicked == false)
        buttons[myRow - 1][myCol].mousePressed();
      if (isValid(myRow + 1, myCol) == true && buttons[myRow + 1][myCol].clicked == false)
        buttons[myRow + 1][myCol].mousePressed();
      for (int i = -1; i < 2; i++) {
        if (isValid(myRow + i, myCol + 1) == true && buttons[myRow + i][myCol + 1].clicked == false)
          buttons[myRow + i][myCol + 1].mousePressed();
      }
    }
  }

  public void draw () 
  {    
    if (flagged)
      fill(0);
    else if ( clicked && mines.contains(this) ) 
      fill(255, 0, 0);
    else if (clicked)
      fill( 200 );
    else 
    fill( 100 );

    rect(x, y, width, height);
    fill(0);
    text(myLabel, x+width/2, y+height/2);
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

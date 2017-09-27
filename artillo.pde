//FIRMATA
import processing.serial.*;
import cc.arduino.*;
 
Arduino arduino;
int pressureSensor = 0;
int pressureSensor2 = 1;

//END FIRMATA

int widthInt = 0;

float oldX;
float oldY;
color redC= color(255, 0, 0);
color greenC= color(0, 255, 0);
color blueC= color(0, 0, 255);
color yellow= color(247, 240, 0);
color orange= color(247, 112, 0);
color violet= color(110, 0, 220);
color blueGreen= color(0, 247, 146);
color yellowGreen= color(157, 250, 0);
color pink= color(255, 28, 97);
color yellowOrange= color(255, 159, 3);
color white= color(255);
color black= color(0);
float masterStroke= 1;
 
 // Image Variables
PImage shapei;
PImage camerai;
PImage texti;
PImage redoi;
PImage undoi;
PImage savei;
int counter;
int cols=2;      //Set Columns
int rows=10;     //Set Rows
color f1 = color(0);    //Initialise Mouse Click Colours
 
Undo undo;

void setup(){
  size(500,500);
  smooth();
  background(255);
   undo = new Undo(10);
  //Assign Images
  redoi = loadImage ("redoicon.png");
  undoi = loadImage ("undoicon.png");
  savei = loadImage ("saveicon.png"); 
  
//FIRMATA
 arduino = new Arduino(this, Arduino.list()[2], 57600);
 arduino.pinMode(pressureSensor, Arduino.INPUT);
 arduino.pinMode(pressureSensor2, Arduino.INPUT);
 //END FIRMATA

}


void mouseReleased() {
  // Save each line we draw to our stack of UNDOs
  undo.takeSnapshot();
}
void mousePressed() {
 if (mousePressed && mouseX>200 && mouseX<250 && mouseY>0 && mouseY<75) {        // Save Function
    counter++;
    String fileName = "savedImage-" + nf(counter, 3) + ".png";
    save(fileName);
  } 
  if (mousePressed && mouseX>150 && mouseX<200 && mouseY>0 && mouseY<75) {             // Undo
            undo.undo();
 
    }
  if (mousePressed && mouseX>100 && mouseX<150 && mouseY>0 && mouseY<75) {        // Undo
              undo.redo();                          
      }
}
 
 class Undo {
    // Number of currently available undo and redo snapshots
    int undoSteps=0, redoSteps=0; 
    CircImgCollection images;
 
    Undo(int levels) {
      images = new CircImgCollection(levels);
    }
 
    public void takeSnapshot() {
      undoSteps = min(undoSteps+1, images.amount-1);
      // each time we draw we disable redo
      redoSteps = 1;
      images.next();
      images.capture();
    }
    public void undo() {
      if (undoSteps > 0) {
        undoSteps--;
        redoSteps++;
        images.prev();
        images.show();
      }
    }
    public void redo() {
      if (redoSteps > 0) {
        undoSteps++;
        redoSteps--;
        images.next();
        images.show();
      }
    }
  }
 
 class CircImgCollection {
    int amount, current;
    PImage[] img;
    CircImgCollection(int amountOfImages) {
      amount = amountOfImages;
 
      // Initialize all images as copies of the current display
      img = new PImage[amount];
      for (int i=0; i<amount; i++) {
        img[i] = createImage(width, height, RGB);
        img[i] = get();
      }
    }
    void next() {
      current = (current + 1) % amount;
    }
    void prev() {
      current = (current - 1 + amount) % amount;
    }
    void capture() {
      img[current] = get();
    }
    void show() {
      image(img[current], 0, 0);
    }
  }
 
 
 
 
 
 
void draw(){
  //FIRMATA
   int test = arduino.analogRead(pressureSensor);
   int test2 = arduino.analogRead(pressureSensor2);
   print("Pin 0: ");
   print(test);
   print(" - Width: ");
   println(widthInt);
   print("Pin 1: ");
   println(test2);
   //background
   if(test2 > 150){
     background(255);
   }
   //width
   
   if(test > 100){
     widthInt = widthInt + 1;
     if(widthInt > 2){
       widthInt = 0;
     }
   }
   if(widthInt == 0){
     masterStroke= 1;
   }
   if(widthInt == 1){
     masterStroke= 4;
   }
   if(widthInt == 2){
     masterStroke= 7;
   }
  //END FIRMATA
  
  strokeWeight(1);
  fill(redC );
  rect(10, 10, 25, 25 );
  fill(blueC );
  rect(35, 10, 25, 25 );
  fill(greenC);
  rect(10, 35, 25, 25);
  fill(yellow);
  rect(35, 35, 25, 25);
  fill(orange);
  rect(10, 60, 25, 25);
  fill(violet);
  rect(35, 60, 25, 25);
  fill(blueGreen);
  rect(10, 85, 25, 25);
  fill(yellowGreen);
  rect(35, 85, 25, 25);
  fill(pink);
  rect(10, 110, 25, 25);
  fill(yellowOrange);
  rect(35, 110, 25, 25);
  fill(white);
  rect(10, 135, 25, 25);
  fill(black);
  rect(35, 135, 25, 25);
  line(450, 30, 500, 30);
  strokeWeight(4);
  line(450, 50, 500, 50);
  strokeWeight(8);
  line(450, 80, 500, 80);
  strokeWeight(1);
  fill(255);
  rect(250, 10, 50, 50);
  image(redoi, 100, 0);
  image(undoi, 150, 0);
  image(savei, 200, 0);
 
   
  if(mousePressed) {
    if(mouseX > 10 && mouseX < 35){
      if(mouseY >10 && mouseY < 35){
        stroke(redC);
      }
      if(mouseY>35 && mouseY < 60){
        stroke(greenC);
      }
      if(mouseY>60 && mouseY<85){
        stroke(orange);
      }
      if(mouseY>85 && mouseY<110){
        stroke(blueGreen);
      }
      if(mouseY>110 && mouseY<135){
        stroke(pink);
      }
      if(mouseY>135 && mouseY<160){
        stroke(white);
      }
    }
    if(mouseX > 35 && mouseX < 60){
      if( mouseY > 10 && mouseY <35){
        stroke(blueC);
      }
      if(mouseY > 35 && mouseY < 50){
        stroke(yellow);
      }
      if(mouseY > 60 && mouseY < 85){
        stroke(violet);
      }
      if(mouseY >85 && mouseY < 110) {
        stroke(yellowGreen);
      }
      if(mouseY > 110 && mouseY <135){
        stroke(yellowOrange);
      }
      if(mouseY >135 && mouseY <160){
        stroke(black);
      }
    }
    if(mousePressed){
      if(mouseX > 450 && mouseX <500){
        if(mouseY >10 && mouseY <40){
          masterStroke= 1; }
        }
      if(mouseX > 450 && mouseX <500){
        if(mouseY >40 && mouseY <70){
          masterStroke= 4; }
      }
      if(mouseX > 450 && mouseX <500){
        if(mouseY > 70 && mouseY <100){
          masterStroke= 7;
      } 
    }
    strokeWeight(masterStroke);
    }
  if(mousePressed){
    if(mouseX > 250 && mouseX <300){
      if (mouseY > 10 && mouseY <60){
        background(255);
      }
    }
  }
  if(mousePressed){
  line(mouseX, mouseY, oldX, oldY);
  }
  }
  oldX=mouseX;
  oldY=mouseY;
  }
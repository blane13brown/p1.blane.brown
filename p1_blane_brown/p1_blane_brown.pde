//icons
PImage emergency;
PImage doorClose;
PImage doorOpen;

//button styling
int rectLength, rectHeight; //length and height of buttons
int rectX, rectY; //coords of top left of buttons
int gap; //vertical space between buttons
color b1c, b2c, b3c, b4c, b5c, sb1c, sb2c, sb3c, bg; //color of buttons when active, deactive and hover
int originalY;

//elevator logic
int currentFloor;
String LocText;
IntList floorQ;
boolean activeEmergency;

void setup() {
  size(650,490);
  
  //button setup
  rectLength = 400;
  rectHeight = 100;
  rectX = 40;
  rectY = 115;
  gap = 20;
  b1c = b2c = b3c = b4c = b5c = sb1c = sb2c = sb3c = color(255);
  
  //icon loading
  emergency = loadImage("emergency.png");
  doorClose = loadImage("doorOpen.png");
  doorOpen = loadImage("doorClose.png");
  
  //elevator logic setup
  //0 will always be the lowest floor
  currentFloor = 0;
  floorQ = new IntList();
  LocText = "Basement 3";
  bg = color(36);
}

void draw() {
  //reset frame
  if (!activeEmergency){
    background(bg);
  }
  strokeWeight(0);

  //check if buttons are beyond bottom boarder
  fill(255, 255, 255);
  if(rectY >=  115) {
    rectY = 115;
  }
  if(rectY <= 85){
    triangle(460, 120, 490, 120, 475, 100);
  }
  
  //check if buttons are beyond top boarder
  if(rectY <=  -125) {
    rectY = -125;
  }
  if(rectY >= -95) {
    triangle(460, 450, 490, 450, 475, 470);
  }
  
  //styling setup
  strokeWeight(8);
  stroke(255);
  fill(20);
  textSize(52);
  
  // Floor Buttons
  //Button 1
  stroke(b1c);
  checkHover(rectX, rectY, rectLength, rectHeight);
  rect(rectX, rectY, rectLength, rectHeight, 24);
  fill(255);
  text("AC Lobby", rectX + 25, rectY + 68);
  fill(20);
  
  //Button 2
  stroke(b2c);
  checkHover(rectX, rectY + rectHeight + gap, rectLength, rectHeight);
  rect(rectX, rectY + rectHeight + gap, rectLength, rectHeight, 24);
  fill(255);
  text("Otis Lobby", rectX + 25, rectY + rectHeight + gap + 68);
  fill(20);
  
  //Button 3
  stroke(b3c);
  checkHover(rectX, rectY + rectHeight*2 + gap*2, rectLength, rectHeight);
  rect(rectX, rectY + rectHeight*2 + gap*2, rectLength, rectHeight, 24);
  fill(255);
  text("Basement 1", rectX + 25, rectY + rectHeight*2 + gap*2 + 68);
  fill(20);
  
  //Button 4
  stroke(b4c);
  checkHover(rectX, rectY + rectHeight*3 + gap*3, rectLength, rectHeight);
  rect(rectX, rectY + rectHeight*3 + gap*3, rectLength, rectHeight, 24);
  fill(255);
  text("Basement 2", rectX + 25, rectY + rectHeight*3 + gap*3 + 68);
  fill(20);
  
  //Button 5
  stroke(b5c);
  checkHover(rectX, rectY + rectHeight*4 + gap*4, rectLength, rectHeight);
  rect(rectX, rectY + rectHeight*4 + gap*4, rectLength, rectHeight, 24);
  fill(255);
  text("Basement 3", rectX + 25, rectY + rectHeight*4 + gap*4 + 68);
  fill(20);
 
 // Side buttons
  stroke(sb1c);
  fill(202,62,71);
  checkHover(510, -125 + rectHeight*2 + gap*2, 100, rectHeight);
  rect(510, 115, 100, rectHeight, 24);
  fill(20);
  
  stroke(sb2c);
  checkHover(510, -125 + rectHeight*3 + gap*3, 100, rectHeight);
  rect(510, 235, 100, rectHeight, 24);
  
  stroke(sb3c);
  checkHover(510, -125 + rectHeight*4 + gap*4, 100, rectHeight);
  rect(510, 355, 100, rectHeight, 24);
  
  //UI topper
  stroke(55);
  strokeWeight(0);
  fill(65);
  rect(0,0,650,80);
  fill(255);
  text("Location:", 32, 58);
  
  //Button icons
  image(emergency, 530, 135, 60, 60);
  image(doorOpen, 525, 250, 70, 70);
  image(doorClose, 525, 370, 70, 70);
  
  //update location text to match current floor
  if(floorQ.size() != 0){
    if(currentFloor == floorQ.get(0)){
      switch(floorQ.get(0)){
        case 4: 
          b1c = color(255);
          break;
        case 3: 
          b2c = color(255);
          break;
        case 2: 
          b3c = color(255);
          break;
        case 1: 
          b4c = color(255);
          break;
        case 0: 
          b5c = color(255);
          break;
      }
      floorQ.remove(0);
    }
    if(floorQ.size() != 0){
      delay(1000);
      if(currentFloor < floorQ.get(0)){
        currentFloor += 1;
        locationUpdate();
      } else {
        currentFloor -= 1;
        locationUpdate();
        }
    }
  }
  fill(141, 235, 252);
  text(LocText, 250, 58);
  if(activeEmergency){
     background(bg);
     fill(255);
     text("Emergency Mode Activated", 28, 170);
     textSize(32);
     text("Remain calm, help is on the way.", 102, 215);
     stroke(255);
     fill(0);
     checkHover(175, 250, 300, 80);
     rect(175, 250, 300, 80, 24);
     fill(255);
     textSize(52);
     text("Cancel", 248, 308);
  }
}

void checkHover(int x, int y, int length, int height) {
  if(mouseX >= x && mouseX <= x + length && mouseY >= y && mouseY <= y + height && mousePressed && !activeEmergency) {
    stroke(141, 235, 252);
  }
  else if (mouseX >= x && mouseX <= x + length && mouseY >= y && mouseY <= y + height && mousePressed){
    strokeWeight(10);
    stroke(255);
  }
}

void mousePressed(){
  originalY = mouseY;
}

void mouseDragged() {
  if (mouseY < originalY) {
    rectY -= 1;
    originalY = mouseY;
  }else if (mouseY > originalY) {
    rectY += 1;
    originalY = mouseY;
  }
}

void mouseClicked() {
 if(mouseX >= rectX && mouseX <= rectX + rectLength && mouseY >= rectY && mouseY <= rectY + rectHeight && !activeEmergency) {
    if (b1c == color(255)){
      b1c = color(141, 235, 252);
      floorQ.append(4);
    } else {
      b1c = color(255);
    }
  }
  
  if(mouseX >= rectX && mouseX <= rectX + rectLength && mouseY >= (rectY + rectHeight + gap) && mouseY <= (rectY + rectHeight + rectHeight + gap) && !activeEmergency) {
    if (b2c == color(255)){
      b2c = color(141, 235, 252);
      floorQ.append(3);
    } else {
      b2c = color(255);
    }
  }
  
  if(mouseX >= rectX && mouseX <= rectX + rectLength && mouseY >= (rectY + rectHeight*2 + gap*2) && mouseY <= (rectY + rectHeight*3 + gap*2) && !activeEmergency) {
    if (b3c == color(255)){
      b3c = color(141, 235, 252);
      floorQ.append(2);
    } else {
      b3c = color(255);
    }
  }
  
  if(mouseX >= rectX && mouseX <= rectX + rectLength && mouseY >= (rectY + rectHeight*3 + gap*3) && mouseY <= (rectY + rectHeight*4 + gap*3) && !activeEmergency) {
    if (b4c == color(255)){
      b4c = color(141, 235, 252);
      floorQ.append(1);
    } else {
      b4c = color(255);
    }
  }
  
  if(mouseX >= rectX && mouseX <= rectX + rectLength && mouseY >= (rectY + rectHeight*4 + gap*4) && mouseY <= (rectY + rectHeight*5 + gap*4) && !activeEmergency) {
    if (b5c == color(255)){
      b5c = color(141, 235, 252);
      floorQ.append(0);
    } else {
      b5c = color(255);
    }
  }
  
  //side buttons
  
  if(mouseX >= 510 && mouseX <= 610 && mouseY >= (-125 + rectHeight*2 + gap*2) && mouseY <= (-125 + rectHeight*2 + gap*2 + 100) && !activeEmergency) {
    if (sb1c == color(255)){
      sb1c = color(141, 235, 252);
      bg = color(232,32,41);
      activeEmergency = true;
    }
  }
  
  if(mouseX >= 510 && mouseX <= 610 && mouseY >= (-125 + rectHeight*3 + gap*3) && mouseY <= (-125 + rectHeight*3 + gap*3 + 100) && !activeEmergency) {
    if (sb2c == color(255)){
      sb2c = color(141, 235, 252);
      delay(1000);
      sb2c = color(255);
    }
  }
  
  if(mouseX >= 510 && mouseX <= 610 && mouseY >= (-125 + rectHeight*4 + gap*4) && mouseY <= (-125 + rectHeight*4 + gap*4 + 100) && !activeEmergency) {
    if (sb3c == color(255)){
      sb3c = color(141, 235, 252);
      delay(1000);
      sb3c = color(255);
  }
}

//cancel emergency button

if(mouseX >= 175 && mouseX <= 475 && mouseY >= 250 && mouseY <= 330 && activeEmergency) {
    activeEmergency = false;
    sb1c = color(255);
    bg = (36);
}
}

void locationUpdate(){
   if(currentFloor == 0){
    LocText = "Basement 3";
  } else if(currentFloor == 1){
    LocText = "Basement 2";
  } else if(currentFloor == 2){
    LocText = "Basement 1";
  } else if(currentFloor == 3){
    LocText = "Otis Lobby";
  } else{
    LocText = "AC Lobby";
  }
}

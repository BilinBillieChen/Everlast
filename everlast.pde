
int numRings = 30;
int numParticles = 100; 
float[][] particleAngles; 
float particleSpeed = 0.02;
float timer = 0; 


float rectX1, rectY1, rectX2, rectY2;
float rectWidth = 150;
float rectHeight = 300;

boolean draggingRect1 = false;
boolean draggingRect2 = false;
boolean rectanglesOut = false; 


float ballX;
float ballY;
float ballSpeed = 2; 
boolean movingRight = true; 

void setup() {
  size(1000, 1000); 
  noFill();
  strokeWeight(5);
  colorMode(HSB, 255);
  

  rectX1 = width / 2 - rectWidth;
  rectY1 = height / 2 - rectHeight / 2;
  rectX2 = width / 2;
  rectY2 = height / 2 - rectHeight / 2;
  

  particleAngles = new float[numRings][numParticles];
  for (int i = 0; i < numRings; i++) {
    for (int j = 0; j < numParticles; j++) {
      particleAngles[i][j] = TWO_PI / numParticles * j; 
    }
  }
  

  ballY = height / 2;
  ballX = width / 2 - 50; 
}

void draw() {
  background(0); 
  

  checkRectanglesOut();
  

  drawParticles();
  

  drawRectangle();

  if (rectanglesOut) {
    drawBall();
  }
  

  timer += 0.01;
  

  updateBall();
}


void drawParticles() {
  for (int i = 0; i < numRings; i++) {
    float radius = map(i, 0, numRings, 50, width / 2); 
    float hue = (frameCount * 2 + i * 20) % 255; 
    stroke(color(hue, 200, 255)); 
    
    for (int j = 0; j < numParticles; j++) {
      float angle = particleAngles[i][j];
      

      if (i % 2 == 0) {
        particleAngles[i][j] += particleSpeed; 
      } else {
        particleAngles[i][j] -= particleSpeed; 
      }
      

      float x = width / 2 + cos(angle) * radius;
      float y = height / 2 + sin(angle) * radius;
      point(x, y); 
    }
  }
}


void drawRectangle() {
  float topColor = map(sin(timer), -1, 1, 0, 255);   
  float bottomColor = map(cos(timer), -1, 1, 0, 255); 

  noStroke();
  fill(topColor);
  rect(rectX1, rectY1, rectWidth, rectHeight / 2);
  
  fill(bottomColor);
  rect(rectX2, rectY2, rectWidth, rectHeight / 2);
}


void drawBall() {
  fill(255);
  ellipse(ballX, ballY, 20, 20);
}


void updateBall() {
  float centerX = width / 2;
  float halfSize = 200 / 2; 
  

  if (movingRight) {
    ballX += ballSpeed;
    if (ballX > centerX + halfSize / 2 - 10) { 
      movingRight = false;
    }
  } else {
    ballX -= ballSpeed;
    if (ballX < centerX - halfSize / 2 + 10) { 
      movingRight = true;
    }
  }
}


void checkRectanglesOut() {
  boolean rect1Out = rectX1 + rectWidth < 0 || rectX1 > width || rectY1 + rectHeight / 2 < 0 || rectY1 > height;
  boolean rect2Out = rectX2 + rectWidth < 0 || rectX2 > width || rectY2 + rectHeight / 2 < 0 || rectY2 > height;
  
  rectanglesOut = rect1Out && rect2Out;
}


void mousePressed() {
  if (mouseX > rectX1 && mouseX < rectX1 + rectWidth && mouseY > rectY1 && mouseY < rectY1 + rectHeight / 2) {
    draggingRect1 = true;
  }
  
  if (mouseX > rectX2 && mouseX < rectX2 + rectWidth && mouseY > rectY2 && mouseY < rectY2 + rectHeight / 2) {
    draggingRect2 = true;
  }
}


void mouseReleased() {
  draggingRect1 = false;
  draggingRect2 = false;
}


void mouseDragged() {
  if (draggingRect1) {
    rectX1 = mouseX - rectWidth / 2;
    rectY1 = mouseY - rectHeight / 4;
  }
  
  if (draggingRect2) {
    rectX2 = mouseX - rectWidth / 2;
    rectY2 = mouseY - rectHeight / 4;
  }
}

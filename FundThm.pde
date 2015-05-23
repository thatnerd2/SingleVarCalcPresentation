float t = 0;
float a = 0;
float b = 0;
float ground = 400;

void setup () {
  size(800, 600);
  
  
}





void draw () {
  background(255);
  for (float t = 0; t < 300; t += 0.1) {
    float x = t + 300;
    float y = height - (float)(0.001*Math.pow(t, 0.33) + 0.002*Math.pow(t, 2) + 400);
    point(x, y);
  }
  
  
  if (mouseX > 300) b = mouseX - 300;
  else b = 0;
  
  for (float i = a; i < b; i += 0.1) {
    float y = height - (float)(0.001*Math.pow(i, 0.33) + 0.002*Math.pow(i, 2) + 400);
    float yCoord = -1*y + height;
    rect(i+ 300, y, 0.1, yCoord - 300);
  }
}

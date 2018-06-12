import processing.serial.*;

Serial esp;
float inByte[] = {0, 0};
boolean draw = true;
void setup() {
  size(900, 600, P3D);
  esp = new Serial(this, "COM5", 115200); // Change the "COM5" Serial port to whichever port you are using!
  // Adjust the Baud rate if your controller doesn't support this rate here and in the arduino sketch
  esp.bufferUntil('\n');
  background(0);
}

void draw() {
  if (draw) {
    background(0);
    lights();
    directionalLight(51, 102, 126, 0, 0, -1);
    translate(width/2, height/2);
    noStroke();
    fill(#2B9396);
    rotateX(radians(inByte[0]));
    rotateZ(radians(inByte[1]));
    box(150, 20, 150);
  }
}

void serialEvent(Serial esp) {
  draw = false;
  String inString = esp.readStringUntil('\n');
  if (inString != null) {
    inString = trim(inString);
    inByte = float(split(inString, ","));
    println(inByte);
    for (int i = 0; i < inByte.length; i++) {
      //inByte[i] = map(inByte[i], -16384, 16384, 90, 270);
      inByte[i] = map(inByte[i], -8192, 8192, 90, 270);
      //inByte[i] = map(inByte[i], -4096, 4096, 90, 270);
    }
    
  }
  draw = true;
}

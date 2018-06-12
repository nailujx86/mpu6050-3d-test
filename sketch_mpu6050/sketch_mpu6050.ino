#include <Wire.h>
#include <MPU6050.h>
#include <I2Cdev.h>
int16_t AcX, AcY;
MPU6050 mpu;
int i2c_addr = 0x68;
void setup() {
  Wire.begin();
  mpu.initialize();
  mpu.setXAccelOffset(3460); // Adjust these values to your offset values
  mpu.setYAccelOffset(1358); // 
  mpu.setFullScaleAccelRange(1);
  Serial.begin(115200); // Adjust the Baud rate if your controller doesn't support this rate here and in the processing sketch
}
void loop() {
  Wire.beginTransmission(i2c_addr);
  Wire.write(0x3B);
  Wire.endTransmission(false);
  Wire.requestFrom(i2c_addr, 4, true);
  AcX = Wire.read() << 8 | Wire.read();
  AcY = Wire.read() << 8 | Wire.read(); 
  
  Serial.print(AcX); Serial.print(","); Serial.println(AcY);
  delay(10);
}



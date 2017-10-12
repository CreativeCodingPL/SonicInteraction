#include "CurieIMU.h"

void setup() {
  Serial.begin(9600); // initialize Serial communication
  while (!Serial);    // wait for the serial port to open

  CurieIMU.begin();

  // Set the accelerometer range to 2G
  CurieIMU.setAccelerometerRange(2);
}

void loop() {
  float ax, ay, az;   //scaled accelerometer values

  // read accelerometer measurements from device, scaled to the configured range
  CurieIMU.readAccelerometerScaled(ax, ay, az);
  // wysylam dane do processingu przeskalowane i zaokraglone do int
  int axi = map(int(ax*100), -200, 200, 0, 254); //bez 255 bo zachowuje na oznaczenie konca transmicji
  int ayi = map(int(ay*100), -200, 200, 0, 254);
  Serial.write(axi);
  Serial.write(ayi);
  Serial.write(255); //ustalam 255 jako koniec transmisji pakietu  
  delay(50);//wysylam 20razy/sek zeby nie przepelnic buforam bo processing czyta 30razy/sek
}


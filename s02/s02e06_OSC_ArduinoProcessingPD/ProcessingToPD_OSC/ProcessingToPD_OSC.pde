// OSC SENDER ->
import processing.serial.*;

Serial USB;  // Create object from Serial class

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup(){
  
  size( 500, 500 );
  
  // --- OSC ---
  
  oscP5 = new OscP5(this,12000); // uruchamia serwer OSC na porcie 12000
  myRemoteLocation = new NetAddress("127.0.0.1",12001); // tworzymy adres odbiorcy (ip,port)

  String[] portNames = Serial.list();
  printArray(portNames);
  USB = new Serial(this, portNames[9], 9600);
  USB.clear();
  frameRate(60);
}

int[] a = new int[3];
int ax = 0;
int ay = 0;
int ktory = 0;

void draw(){

  while(USB.available()>0) {
    a[ktory] = USB.read();
    if(a[ktory] == 255) {
      ktory = 0;
      ax = a[0];
      ay = a[1];
    }
      else {
        ktory++;
    }
  }
  
  printArray(a);

  background( #0AFFDC );
  
  line( width/2, height/2, width/2-(127-ax), height/2-(ay-127));
  
   
  // --- OSC ---
  
  OscMessage myMessage = new OscMessage("/accelerationXY"); // tworzymy message o nazwie "/accelerationXY"
  
  myMessage.add( abs((ax-128)/2.5) ); // dodajemy do komunikatu pozycje myszki X
  myMessage.add( abs((ay-128)/2.5) ); // dodajemy do komunikatu pozycje myszki Y
  
  oscP5.send(myMessage, myRemoteLocation); // wysyłamy komunikat pod adres zdefiniowany w objekcie myRemoteLocation 
  
}
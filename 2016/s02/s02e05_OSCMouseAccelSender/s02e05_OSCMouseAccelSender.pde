// OSC SENDER ->

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

float accX = 0;
float accY = 0;

void setup(){
  
  size( 500, 500 );
  
  // --- OSC ---
  
  oscP5 = new OscP5(this,12000); // uruchamia serwer OSC na porcie 12000
  myRemoteLocation = new NetAddress("127.0.0.1",12001); // tworzymy adres odbiorcy (ip,port)
  
}


void draw(){
 
  background( #0AFFDC );
  
  line( mouseX, mouseY, pmouseX, pmouseY );
  
  accX = abs( mouseX - pmouseX );
  accY = abs( mouseY - pmouseY );
  
  // --- OSC ---
  
  OscMessage myMessage = new OscMessage("/accelerationXY"); // tworzymy message o nazwie "/accelerationXY"
  
  myMessage.add( accX ); // dodajemy do komunikatu pozycje myszki X
  myMessage.add( accY ); // dodajemy do komunikatu pozycje myszki Y
  
  oscP5.send(myMessage, myRemoteLocation); // wysyłamy komunikat pod adres zdefiniowany w objekcie myRemoteLocation 
  
}
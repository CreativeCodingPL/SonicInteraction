import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

int osc1 = 0;
int osc2 = 0;

void setup() {
  size(600, 300); 
  noStroke();
  rectMode(CENTER);
  
  oscP5 = new OscP5(this,11000);
  myRemoteLocation = new NetAddress("127.0.0.1",11000);
}

void draw() {
  frameRate(30);
  background(0); 
  
 
  
  fill(255);
  ellipse(width/2-130, height/2, 107+osc1, 107+osc1);
 
  fill(255);
  rect(width/2+130, height/2, 107+osc2, 107+osc2);
  
 
  smooth();
  
}

void oscEvent(OscMessage theOscMessage){
        osc1 = theOscMessage.get(0).intValue();
        osc2 = theOscMessage.get(1).intValue();
          
}
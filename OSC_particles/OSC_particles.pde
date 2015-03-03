/* OpenProcessing Tweak of *@*http://www.openprocessing.org/sketch/13048*@* */
/* !do not delete the line above, required for linking your tweak if you upload again */

import oscP5.*;
import netP5.*;

OscP5 osc;
int myport = 12321;
ParticleSystem ps;
PFont font;
int maxnumparticles = 100;
int fc = 0;
int pfc = 0;

void setup() {
  size(300, 300, JAVA2D);
  background(0);
  ps = new ParticleSystem(1, new PVector(width/2, height/2, 0), 2, 5, 0.1, 255); //create new particle system ArrayList
  smooth();
  osc = new OscP5(this, myport);
  osc.plug(this, "mkparticle", "/mkparticle");

  font = loadFont("Monaco-12.vlw");
  textFont(font, 12);
}

void draw() {
  fill(0, 3);
  rect(0, 0, width, height); //show particle trails
  ps.run();
}

void mkparticle(float dur) {
  fc = frameCount;
  if (fc > pfc) {
    if (ps.parts.size()<maxnumparticles) {
      dur = constrain( map(dur, 0.0, 0.2, 50.0, 255.0), 0.0, 255.0);
      println(dur);
      ps.addParticle(random(0.0, width), random(0.0, height), 2, 5, 0.1, dur);
    }
  }
  pfc = fc;
}


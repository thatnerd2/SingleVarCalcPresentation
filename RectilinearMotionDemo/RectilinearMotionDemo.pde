

import controlP5.*;

import org.qscript.operator.*;
import org.qscript.*;
import org.qscript.editor.*;
import org.qscript.errors.*;
import org.qscript.eventsonfire.*;
import org.qscript.events.*;

PFont f;

String position;
String velocity;
String acceleration;
String s;
String v;
String a;

float t;
float step;
float savedStep;

int leftAlign;

ControlP5 gui;

void setup () {
  size(800, 600);
  
  leftAlign = width - 200;
  f = createFont("Arial", 16, true);
  
  position = "sin(x)";
  velocity = "cos(x)";
  acceleration = "-1*sin(x)";
  
  s = position.replace("x", "$x");
  v = velocity.replace("x", "$x");
  a = acceleration.replace("x", "$x");
  
  gui = new ControlP5(this);
  gui.addButton("Pause").setPosition(leftAlign, 270).setSize(80, 30).getCaptionLabel().setText("Pause/Unpause");
  gui.addButton("Reset").setPosition(leftAlign + 90, 270).setSize(50, 30);
  gui.addButton("incStep").setPosition(leftAlign, 300).setSize(80, 30).getCaptionLabel().setText("++Step");
  gui.addButton("decStep").setPosition(leftAlign + 90, 300).setSize(80, 30).getCaptionLabel().setText("--Step");
  
  GraphManager.init(this);
  
  t = 0;
  step = 0;
  savedStep = 0.1;
  
  textFont(f);
  fill(0);
}

void draw () {
  background(255);
  textFont(f, 16);
  fill(0);
  t = roundTo(t + step, 3);
  
  line(50, 30, 500, 30);
  int offset = (500 + 50) / 2;
  float st = getAnswer(t, s, 3);
  ellipse(-(st * 100 + offset), 30, 30, 30);
  GraphManager.display(t);
  
  writeStatus();
}

public void Pause (int v) {
  if (step == 0) step = savedStep;
  else step = 0;
}

public void Reset (int v) {
  step = savedStep;
  t = 0;
}

public void incStep (int v) {
  step += 0.1;
  savedStep = step;
}

public void decStep (int v) {
  if (step > 0) step -= 0.1;
  savedStep = step;
}

void writeStatus () {
  
  text("s(t) = " + position, leftAlign, 30);
  text("v(t) = " + velocity, leftAlign, 60);
  text("a(t) = " + acceleration, leftAlign, 90);
  
  text("s(" + t + ") = " + getAnswer(t, s, 3), leftAlign, 120);
  text("v(" + t + ") = " + getAnswer(t, v, 3), leftAlign, 150);
  text("a(" + t + ") = " + getAnswer(t, a, 3), leftAlign, 180);
  text("t = " + t, leftAlign, 210);
  text("step = " + step, leftAlign, 240);
}

float getAnswer (float t, String expr, int round) {
  Result ans = Solver.evaluate("$x=" + t + "; " + expr);
  String asString = ans.toString();
  float asFloat = Float.parseFloat(asString);
  return (round <= 0) ? asFloat : roundTo(asFloat, round);
}

float roundTo (float x, int places) {
  float exp = pow(10, places);
  x *= exp;
  x = floor(x);
  return (x / exp);
}

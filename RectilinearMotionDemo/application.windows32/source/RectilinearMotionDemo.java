import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import controlP5.*; 
import org.qscript.operator.*; 
import org.qscript.*; 
import org.qscript.editor.*; 
import org.qscript.errors.*; 
import org.qscript.eventsonfire.*; 
import org.qscript.events.*; 
import org.gwoptics.graphics.graph2D.effects.*; 
import org.gwoptics.gaussbeams.*; 
import org.gwoptics.graphics.graph3D.*; 
import org.gwoptics.graphics.colourmap.presets.*; 
import org.gwoptics.graphics.graph2D.traces.*; 
import org.gwoptics.graphics.graph2D.backgrounds.*; 
import org.gwoptics.*; 
import org.gwoptics.graphics.graph2D.*; 
import org.gwoptics.mathutils.*; 
import org.gwoptics.graphicsutils.*; 
import org.gwoptics.graphics.camera.*; 
import org.gwoptics.graphics.*; 
import org.gwoptics.graphics.colourmap.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class RectilinearMotionDemo extends PApplet {












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

public void setup () {
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
  
  GraphManager.init(this);
  
  t = 0;
  step = 0.1f;
  savedStep = 0.1f;
  
  textFont(f);
  fill(0);
}

public void draw () {
  background(255);
  textFont(f, 16);
  fill(0);
  t = roundTo(t + step, 3);
  
  line(50, 30, 500, 30);
  int offset = (500 + 50) / 2;
  float st = getAnswer(t, s, 3);
  ellipse(st * 100 + offset, 30, 30, 30);
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

public void writeStatus () {
  
  text("s(t) = " + position, leftAlign, 30);
  text("v(t) = " + velocity, leftAlign, 60);
  text("a(t) = " + acceleration, leftAlign, 90);
  
  text("s(" + t + ") = " + getAnswer(t, s, 3), leftAlign, 120);
  text("v(" + t + ") = " + getAnswer(t, v, 3), leftAlign, 150);
  text("a(" + t + ") = " + getAnswer(t, a, 3), leftAlign, 180);
  text("t = " + t, leftAlign, 210);
  text("step = " + step, leftAlign, 240);
}

public float getAnswer (float t, String expr, int round) {
  Result ans = Solver.evaluate("$x=" + t + "; " + expr);
  String asString = ans.toString();
  float asFloat = Float.parseFloat(asString);
  return (round <= 0) ? asFloat : roundTo(asFloat, round);
}

public float roundTo (float x, int places) {
  float exp = pow(10, places);
  x *= exp;
  x = floor(x);
  return (x / exp);
}













static class GraphManager {
  static Graph2D g;
  static RectilinearMotionDemo parent;
  static Line2DTrace trace;
  
  static class eq implements ILine2DEquation {
    public double computePoint (double x, int pos) {
      return parent.getAnswer((float) x, parent.s, 3);
    }
  }
  
  
  public static void init (RectilinearMotionDemo inst) {
    parent = inst;
    g = new Graph2D(parent, 400, 200, false);
    
    g.setXAxisLabel("t");
    g.setYAxisLabel("position");
    g.position.y = inst.height - 300;
    g.position.x = 100;
    g.setYAxisTickSpacing(1);
    g.setXAxisMax(5f);
    g.setXAxisMin(0f);
    g.setYAxisMax(1.1f);
    g.setYAxisMin(-1f);
    
    trace = new Line2DTrace(new eq());
    g.addTrace(trace);
  }
  
  public static void display (float maxX) {
    g.removeTrace(trace);
    g.setXAxisMax(maxX);
    g.setXAxisTickSpacing(maxX / 10);
    g.addTrace(trace);
    g.draw();
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "RectilinearMotionDemo" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

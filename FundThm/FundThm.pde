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


float t = 0;
String fx = "80*sin($x/40)";
String dydx = "80*cos($x/40)";

float start = 250;
float end = 550;  
int fxYOffset = 100;
int dydxYOffset = 300;
Graph2D[] graphs;

class SinTrace implements ILine2DEquation {
  public double computePoint (double x, int pos) {
    return Math.sin(x);
  }
}

class CosTrace implements ILine2DEquation {
  public double computePoint (double x, int pos) {
    return Math.cos(x);
  }
}
    

void setup () {
  size(800, 600);
  
  graphs = new Graph2D[2];
  
  for (int i = 0; i < graphs.length; i++) {
    
  
    graphs[i] = new Graph2D(this, 300, 300, true);
    graphs[i].setAxisColour(0, 0, 0);
    graphs[i].setFontColour(100, 100, 100);
    
    graphs[i].setYAxisTickSpacing(0.5f);
    graphs[i].setXAxisTickSpacing(0.5f);
    
    graphs[i].setYAxisMin(-1.5f);
    graphs[i].setXAxisMin(-2f);
    graphs[i].setYAxisMax(1.5f);
    graphs[i].setXAxisMax(2f);
  }
  
  graphs[0].position.y = 50;
  graphs[0].position.x = 50;
  graphs[1].position.y = 50;
  graphs[1].position.x = 430;
  
  Line2DTrace fx = new Line2DTrace(new SinTrace());
  Line2DTrace dydx = new Line2DTrace(new CosTrace());
  
  graphs[0].addTrace(fx);
  graphs[1].addTrace(dydx);
  
}





void draw () {
  background(255);
  
  if (mousePressed) {
    println(mouseX + " " + mouseY);
  }
  for (int i = 0; i < graphs.length; i++) graphs[i].draw();
  t += 1;
  ellipse(51 + t, 100*sin((t + 40)/60) + 243, 10, 10);
  if (start + t > end) {
    t = 0;
  }
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

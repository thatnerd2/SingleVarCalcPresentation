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
static class GraphManager {
  static Graph2D g;
  static RectilinearMotionDemo parent;
  static Line2DTrace trace;
  
  static class eq implements ILine2DEquation {
    public double computePoint (double x, int pos) {
      return parent.getAnswer((float) x, parent.s, 3);
    }
  }
  
  
  static void init (RectilinearMotionDemo inst) {
    parent = inst;
    g = new Graph2D(parent, 400, 200, false);
    
    g.setXAxisLabel("t");
    g.setYAxisLabel("position");
    g.position.y = inst.height - 300;
    g.position.x = 100;
    g.setYAxisTickSpacing(1);
    g.setXAxisMax(5f);
    g.setXAxisMin(0f);
    g.setYAxisMax(1.1);
    g.setYAxisMin(-1f);
    
    trace = new Line2DTrace(new eq());
    g.addTrace(trace);
  }
  
  static void display (float maxX) {
    g.removeTrace(trace);
    g.setXAxisMax(maxX);
    g.setXAxisTickSpacing(maxX / 10);
    g.addTrace(trace);
    g.draw();
  }
}

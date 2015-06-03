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
  static Line2DTrace sTrace;
  static Line2DTrace vTrace;
  static Line2DTrace aTrace;
  
  
  static class eq implements ILine2DEquation {
    static String expr;
    
    public eq (String e) {
      expr = e;
    }
    
    public double computePoint (double x, int pos) {
      float ans = parent.getAnswer((float) x, expr, 3);
      println(ans);
      return ans;
    }
  }
  
  
  static void init (RectilinearMotionDemo inst) {
    parent = inst;
    g = new Graph2D(parent, 400, 200, false);
    
    g.setXAxisLabel("t");
    g.position.y = inst.height - 300;
    g.position.x = 100;
    g.setYAxisTickSpacing(1);
    g.setXAxisMax(5f);
    g.setXAxisMin(0f);
    g.setYAxisMax(1.1);
    g.setYAxisMin(-1f);
    g.setYAxisLabel("Position");
    
    sTrace = new Line2DTrace(new eq(parent.s));
    vTrace = new Line2DTrace(new eq(parent.v));
    aTrace = new Line2DTrace(new eq(parent.a));
    
    sTrace.setTraceColour(255, 0, 0);
    vTrace.setTraceColour(0, 255, 0);
    aTrace.setTraceColour(0, 0, 255);
    
    g.addTrace(sTrace);
    //g.addTrace(vTrace);
    //g.addTrace(aTrace);
  }
  
  static void display (float maxX) {
    g.removeTrace(sTrace);
    //g.removeTrace(vTrace);
    //g.removeTrace(aTrace);
    
    g.setXAxisMax(maxX);
    g.setXAxisTickSpacing(maxX / 10);
    g.addTrace(sTrace);
    //g.addTrace(vTrace);
    //g.addTrace(aTrace);
    g.draw();
  }
}

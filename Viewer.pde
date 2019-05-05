public class Viewer {
  float x, y, z; 
  int sizex, sizey;

  public Viewer(float x, float y, float z, int sizex, int sizey) {
    this.x = x;
    this.y = y;
    this.z = z;

    this.sizex = sizex;
    this.sizey = sizey;
  }

  void show() {
    fill(255, 255, 0);
    noStroke();
    pushMatrix();
    translate(x, y, z);
    box(this.sizex, this.sizey, 5);
    popMatrix();
  }

  void splatter() {
    changing.set(cam.getPosition()[0], cam.getPosition()[2]); //x-z
    changingY.set(cam.getPosition()[1], cam.getPosition()[2]); //y-z

    //    xAxis.set(x, 0);
    //    yAxis.set(y, 0);

    horizAng = angle(xAxis, changing);
    vertAng = angle(yAxis, changingY);

    for (int i = -sizex; i < sizex; i+=incr) {
      for (int j = -sizey; j < sizey; j+=incr) {
        v.march(i + x, j + y, z, horizAng, vertAng);
      }
    }
    result = createShape();
    result.beginShape(TRIANGLE_FAN);
    result.stroke(0, 255, 0);
    result.fill(0, 255, 0);
    for (Point p : points) {
      result.vertex(p.x, p.y, p.z);
    }
    result.endShape(CLOSE);
    points.clear();
  }

  // returns the angle from v1 to v2 in clockwise direction
  // range: [0..TWO_PI]
  float angle(PVector v1, PVector v2) {
    float a = atan2(v2.y, v2.x) - atan2(v1.y, v1.x);
    if (a < 0) a += TWO_PI;
    return a;
  }

  void march(float bx, float by, float bz, float ang1, float ang2) {
    float w = minDistToScene(bx, by, bz, objs);

    //xAxis.set(w, 0);
    //ang = angle(xAxis, changing);
    //angle = ang;

    bx -= w * cos(ang1);
    by -= w * cos(ang2);
    bz -= w * sin(ang2);

    if (w <= 0.1) {
      points.add(new Point(bx, by, bz));
    } else if (bx >= -1000 && bx <= 1000 && by >= -1000 && by <= 1000 && bz >= -1000 && bz <= 1000) {
      march(bx, by, bz, ang1, ang2);
    }
  }
}

public class Point {
  float x, y, z; 

  public Point(float x, float y, float z) {
    this.x = x;
    this.y = y;
    this.z = z;
  }

  void show() {
    fill(0, 255, 0);
    noStroke();
    pushMatrix();
    translate(x, y, z);
    sphere(3);
    popMatrix();
  }
}

public class March extends Thread {
  float bx, by, bz, ang1, ang2;

  public March(float bx, float by, float bz, float ang1, float ang2) {
    this.bx = bx;
    this.by = by;
    this.bz = bz;
    this.ang1 = ang1;
    this.ang2 = ang2;
  }

  public void run() {
    println("running");
    march(this.bx, this.by, this.bz, this.ang1, this.ang2);
  }

  void march(float bx, float by, float bz, float ang1, float ang2) {
    float w = minDistToScene(bx, by, bz, objs);

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

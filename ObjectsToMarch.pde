public abstract class MarchingObjects {
  float x, y, z;
  int type; // 0 --> Sphere; 1 --> Box

  public MarchingObjects(float x, float y, float z, int type) {
    this. x = x;
    this.y = y;
    this.z = z;

    this.type = type;
  }

  abstract void show();
}

public class Sphere extends MarchingObjects {
  int size;

  public Sphere(float x, float y, float z, int size) {
    super(x, y, z, 0);
    this.size = size;
  }

  public void show() {
    stroke(0, 0, 255);
    noFill();
    pushMatrix();
    strokeWeight(1);

    translate(this.x, this.y, this.z);
    sphere(size);
    popMatrix();
  }
}

public class Box extends MarchingObjects {
  int size;

  public Box(float x, float y, float z, int size) {
    super(x, y, z, 1);

    this.size = size;
  }

  public void show() {
    stroke(0, 0, 255);
    noFill();
    pushMatrix();
    strokeWeight(1);

    translate(this.x, this.y, this.z);
    box(this.size);
    popMatrix();
  }
}

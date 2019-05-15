import peasy.*;

PeasyCam cam;

Viewer v;
//ArrayList<Sphere> objs = new ArrayList<Sphere>();

ArrayList<MarchingObjects> objs = new ArrayList<MarchingObjects>();

ArrayList<Point> points = new ArrayList<Point>();

Box b;

boolean axis = false;
boolean spheres = true;
boolean splatter = false;

//increment for splatter
//5 --> no lag but not very precise
//1 --> laggy but precise
int incr = 5;

PShape result;

PVector xAxis, yAxis;
PVector changing, changingY;

float horizAng = 0, vertAng = 0;

float postAngHoriz = horizAng;
float postAngVert = vertAng;
float tempVal = 0;

void setup() {
  fullScreen(P3D); 

  cam = new PeasyCam(this, 500);

  v = new Viewer(0, 0, 300, width/2, height/2);
  objs.add(new Sphere(50, 0, -300, 100));
  //objs.add(new Sphere(0, 50, -200, 115));
  //objs.add(new Sphere(0, 0, 0, 50));

  xAxis = new PVector(500, 0);
  yAxis = new PVector(500, 0);
  changing = new PVector(0, 500);
  changingY = new PVector(0, 500);

  //objs.add(new Plane(0, 0, 0, 100, 100));
  objs.add(new Box(0, 0, 0, 50));
  //objs.add(new Sphere(-750, 0, -300, 100));
}

void draw() {
  background(0);

  pushMatrix();
  translate(0, 0, 0);
  fill(255);
  stroke(255);
  sphere(5);
  popMatrix();

  cam.beginHUD();
  fill(255);
  String HUD = " Looking At --> X: " + Integer.toString((int)cam.getLookAt()[0]) + " Y: " + Integer.toString((int)cam.getLookAt()[1]) + " Z: " + Integer.toString((int)cam.getLookAt()[2]);
  HUD += '\n' + " Viewer Position --> X: " + Integer.toString((int)v.x) + " Y: " + Integer.toString((int)v.y) + " Z: " + Integer.toString((int)v.z);
  HUD += '\n' + " Splattering: "+ splatter;
  HUD += '\n' + " Increment: "+ incr;
  HUD += '\n' + " HorizAng X-Z: "+ horizAng;
  HUD += '\n' + " VertAng Y-Z: "+ vertAng;

  text(HUD, 0, 0, 400, 400);

  String fpsHud = "FPS: " + (int) frameRate;
  fpsHud += '\n' + "Temp Value: " + tempVal;
  text(fpsHud, width-200, 0, width, 200);
  cam.endHUD(); // always!

  if (axis) showAxis();

  float[] cameraPositions = cam.getPosition(); 
  v.x = cameraPositions[0];
  v.y = cameraPositions[1];
  v.z = cameraPositions[2];

  if (splatter) {
    v.splatter();
  }
  if (spheres) {
    //directionalLight(51, 102, 126, 0, 0, 1);
    lights();
    for (MarchingObjects m : objs) {
      m.show();
    }
  }

  for (Point p : points) p.show();

  if (result != null) {
    shape(result, 0, 0);
  }
}

void keyPressed() {
  if (key == 'a') axis = !axis;
  else if (key == 'm') {
    splatter = !splatter;
  } else if (key == 's') {
    spheres = !spheres;
  } else if (keyCode == DOWN) {
    if (incr >= 1 && !splatter) incr--;
  } else if (keyCode == UP) {
    if (!splatter) incr++;
  }
}

void showAxis() {
  stroke(255, 0, 0);
  line(-1000, 0, 0, 1000, 0, 0);
  stroke(0, 255, 0);
  line(0, -1000, 0, 0, 1000, 0);
  stroke(0, 0, 255);
  line(0, 0, -1000, 0, 0, 1000);

  stroke(255, 0, 150);
  noFill();
  sphere(1000);
}

//  _________      .__                          
// /   _____/_____ |  |__   ___________   ____  
// \_____  \\____ \|  |  \_/ __ \_  __ \_/ __ \ 
// /        \  |_> >   Y  \  ___/|  | \/\  ___/ 
///_______  /   __/|___|  /\___  >__|    \___  >
//        \/|__|        \/     \/            \/ 

float distSphere(float x, float y, float z, Sphere sph) {
  return dist(x, y, z, sph.x, sph.y, sph.z) - sph.size;
}

//__________              
//\______   \ _______  ___
// |    |  _//  _ \  \/  /
// |    |   (  <_> >    < 
// |______  /\____/__/\_ \
//        \/            \/

float distBox(float x, float y, float z, Box b) {
  PVector eye = new PVector(x, y, z);
  PVector center = new PVector(b.x, b.y, b.z);

  PVector o = new PVector(abs(eye.x - center.x), abs(eye.y - center.y), abs(eye.z - center.z));
  o.setMag(b.size);
  float ud = max(o.mag(), 0);

  float n = max(max(min(o.x, 0), min(o.y, 0)), min(o.z, 0));
  tempVal = ud+n;
  return ud+n;
}

float distPlane(float x, float y, float z, Plane m) {
  return 0;
}


float minDistToScene(float x, float y, float z, ArrayList<MarchingObjects> objs) {
  float shortest;

  switch (objs.get(0).type) {
  case 0:
    shortest = distSphere(x, y, z, (Sphere) objs.get(0));
    break;
  case 1:
    shortest = distBox(x, y, z, (Box) objs.get(0));
    break;
  case 2:
    shortest = distPlane(x, y, z, (Plane) objs.get(0));
    break;
  default:
    println("Something is wrong");
    return 1000;
  } 

  for (int i = 1; i < objs.size(); i++) {
    float temp;
    switch (objs.get(i).type) {
    case 0:
      temp = distSphere(x, y, z, (Sphere) objs.get(i));
      break;
    case 1:
      temp = distBox(x, y, z, (Box) objs.get(i));
      break;
    case 2:
      temp = distPlane(x, y, z, (Plane) objs.get(i));
      break;
    default:
      temp = 10000;
    }

    if (temp < shortest) shortest = temp;
  }

  return shortest;
}

float maxDistToScene(float x, float y, float z, ArrayList<MarchingObjects> objs) {
  float biggest;

  switch (objs.get(0).type) {
  case 0:
    biggest = distSphere(x, y, z, (Sphere) objs.get(0));
    break;
  case 1:
    biggest = distBox(x, y, z, (Box) objs.get(0));
    break;
  default:
    println("Something is wrong");
    return 1000;
  } 

  for (int i = 1; i < objs.size(); i++) {
    float temp;
    switch (objs.get(i).type) {
    case 0:
      temp = distSphere(x, y, z, (Sphere) objs.get(i));
      break;
    case 1:
      temp = distBox(x, y, z, (Box) objs.get(i));
      break;
    default:
      temp = 10000;
    }

    if (temp > biggest) biggest = temp;
  }


  return biggest;
}

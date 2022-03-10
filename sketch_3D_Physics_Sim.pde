import java.util.Collections;
Camera cam;
ArrayList<Particle> particles;
void setup(){
  fullScreen(P3D);
  particles = new ArrayList<Particle>();
  cam = new Camera(0,3000,0,0,1,0);
  for (int i=0;i<100;i++){
    particles.add(new Particle((float)(Math.random()*1000-500),(float)(Math.random()*1000-500),(float)(Math.random()*1000-500),(float)(Math.random()*100),(float)(Math.random()*500)));
  }
}

void mouseWheel(MouseEvent event) {
  cam.setZPos(cam.getZPos()+event.getCount()*10);
}

void draw(){
  clear();
  cam.draw();
  for (Particle P : particles){
    float xChange = 0;
    float yChange = 0;
    float zChange = 0;
    for (int i=0;i<particles.size();i++){
      if (!(P==particles.get(i))){
        xChange+=(particles.get(i).getXPos()-P.getXPos())/P.distanceTo(particles.get(i))*P.getMass()/10000;
        yChange+=(particles.get(i).getYPos()-P.getYPos())/P.distanceTo(particles.get(i))*P.getMass()/10000;
        zChange+=(particles.get(i).getZPos()-P.getZPos())/P.distanceTo(particles.get(i))*P.getMass()/10000;
      }
    }
    P.setXVel(P.getXVel()+xChange);
    P.setYVel(P.getYVel()+yChange);
    P.setZVel(P.getZVel()+zChange);
    P.update();
  }
  cam.update();
}

class Particle {
  float xPos, yPos, zPos, xVel, yVel, zVel;
  float diameter, mass;
  Particle (float X, float Y, float Z, float D, float M){
    xPos = X;
    yPos = Y;
    zPos = Z;
    xVel = 0;
    yVel = 0;
    zVel = 0;
    diameter = D;
    mass = M;
  }
  float getXPos(){
    return xPos;
  }
  float getYPos(){
    return yPos;
  }
  float getZPos(){
    return zPos;
  }
  float getXVel(){
    return xVel;
  }
  float getYVel(){
    return yVel;
  }
  float getZVel(){
    return zVel;
  }
  float getDiameter(){
    return diameter;
  }
  float getMass(){
    return mass;
  }
  void setXPos(float X){
    xPos = X;
  }
  void setYPos(float Y){
    yPos = Y;
  }
  void setZPos(float Z){
    zPos = Z;
  }
  void setXVel(float X){
    xVel = X;
  }
  void setYVel(float Y){
    yVel = Y;
  }
  void setZVel(float Z){
    zVel = Z;
  }
  float distanceTo(Particle P){
      return (float)Math.sqrt(Math.pow(P.getXPos()-getXPos(),2)+Math.pow(P.getYPos()-getYPos(),2)+Math.pow(P.getZPos()-getZPos(),2));
  }
  void update(){
    xPos+=xVel/frameRate;
    yPos+=yVel/frameRate;
    zPos+=zVel/frameRate;
  }
}

class Camera extends Particle {
  float xRot, yRot, zRot;
  int fov;
  Camera (float X, float Y, float Z, float XR, float YR, float ZR){
    super(X, Y, Z, 100, 100);
    xRot = XR;
    yRot = YR;
    zRot = ZR;
    fov = 90;
  }
  void setXRot(float X){
    xRot = X;
  }
  void setYRot(float Y){
    yRot = Y;
  }
  void setZRot(float Z){
    zRot = Z;
  }
  float getXRot(){
    return xRot;
  }
  float getYRot(){
    return yRot;
  }
  float getZRot(){
    return zRot;
  }
  void setFOV(int F){
    fov = F;
  }
  int getFOV(){
    return fov;
  }
  void draw(){
    camera(getXPos(), getYPos(), getZPos(), mouseX, mouseY, 0, xRot, 1, zRot);
    for (Particle P : particles){
      noStroke();
      lights();
      translate(P.getXPos(), P.getYPos(), P.getZPos());
      sphere(P.getDiameter());
      /*
      if (getZPos()<P.getZPos()){
        float renderedSize = (float)(P.getDiameter()/(Math.PI*2*distanceTo(P))*360/90*width);
        ellipse((P.getXPos()-getXPos())/(getZPos()-P.getZPos())*100+width/2,(P.getYPos()-getYPos())/(getZPos()-P.getZPos())*100+height/2,renderedSize,renderedSize);
      }
      */
    }
  }
}

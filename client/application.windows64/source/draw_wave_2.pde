// Forked from Lali Barriere (openprocessing user 1075). Not my original work.

float  xA, yA, xB, yB, x1,y1,x2,y2;

float sx, sy;

float angle;
float speed;
float radi;

float c,s;

void draw_wave_2() {
  
  // dues corbes de lissajus serveixen de punts de control
  c = cos(angle);
  s = sin(angle/sy);
  // c=0;s=0;

  x1 = 300/3+c*radi;
  y1 = 400/2+s*radi;

  x2 = 2*300/3 + cos(angle/sx)*radi;
  y2 = 400/2 + sin(angle)*radi;
  //  y2 = y1 + tan(angle*sy)*radi;

  // pintem la corba de bezier
  noFill();
  stroke(255,10);
  bezier(xA,yA,x1,y1,x2,y2,xB,yB);
  
  // fem un pas
  angle+=speed;
}

void neteja() {
//  background(0);
}

/*void keyPressed() {
  switch(key) {
    case('1'):
    neteja();
    sx=5.0;
    sy=random(1);
    break;
    case('2'):
    neteja();
    sx=random(1);
    sy=2.0;
    break;
    default:
    neteja();
    sx = random(5.0);
    sy=random(5.0);

  }
}*/

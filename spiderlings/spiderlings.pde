float sacX = 70.0;
float sacY = 70.0;
float dt = 1.0;
int num = 514;
float top = 120.0;
float left = 160.0;
int windowWidth;
int windowHeight;
float legAmplitude = 20;
float speedk = 15;
boolean goTime = false;
boolean showBeam = false;
int beamGo;
int beamTime = 40;
PImage logo;
float aspectRatio;
boolean picMode;
int fadeLength = 14;
int fadeTargetTime;

ArrayList<Spider> spiders = new ArrayList<Spider>(); //spiders

void setup () {
  fullScreen();
  frameRate(10);
  noCursor();
  logo = loadImage("0.jpg");
  windowWidth = width;
  windowHeight = height;
  
  for (int i = 0; i < num; i++) {
    spiders.add(new Spider());
  }
}

void draw () {
  if (!picMode) {
    background(0);
    fill(100);
    noStroke();
    if (showBeam) {
      drawBeams();
      if (frameCount-beamGo <= beamTime) {
        noStroke();
        fill(0,max(map(frameCount-beamGo,0,beamTime,255,0),0));
        rect(0,0,windowWidth,windowHeight);
      }
    }
    //ellipse(mouseX,mouseY,40,40);
    //println(mouseX,mouseY);
    frameRate(200);
    if (goTime) {
      for (int i = 0; i < num; i++) {
        if (spiders.get(i).birth +beamGo < frameCount && spiders.get(i).x > 0 && spiders.get(i).y > 0) {
          spiders.get(i).draw();
          //if (frameCount < infinity) {
            spiders.get(i).move();
          //}
        }
      }
    }
  }
  else { //pic
    background(0);
    // calc pic characteristics
    float w;
    float h;
    float alpha = 255;
    
      //float w = windowWidth * picInfo[picNum][0];
      //float h = windowHeight * picInfo[picNum][1];
      //println(windowWidth,windowHeight);
      //println(imgs[picNum].width,imgs[picNum].height);
    float picRatio = float(logo.width)/float(logo.height);
    if (picRatio >= aspectRatio) { //wide pics
      w = windowWidth;
      h = w / picRatio;
    //println(w,h,picRatio,aspectRatio);
    } else { //tall pics
      h = windowHeight;
      w = h * picRatio;
      //println(w,h,picRatio,aspectRatio);
    }
    float a = (windowWidth-w)/2;
    float b = (windowHeight-h)/2;
    noStroke();
    //String state = "";
    
    if (frameCount < fadeTargetTime){ //fading in
      //state = "fading in";
      //println("fading in new",str(pNum),str(fadeTargetTime),str(frameCount));
      alpha = map(fadeTargetTime-frameCount,0,fadeLength,255,0); //fade in
      //println(fadeTargetTime-frameCount,alpha);
    } else {
      //state = "other";
      alpha = 255;
      //println("reg display",str(pNum));
    }
    
    tint(255,alpha);
    image(logo,a,b,w,h);
    //println(frameCount,alpha,pNum,state);
  }
}

void drawBeams () {
  
  PShape s = createShape();
  s.beginShape();
  s.fill(41,29,20);
  s.stroke(20,12,9);
  s.vertex(.5*left, 0);
  s.vertex(windowWidth,0);
  s.vertex(windowWidth,top);
  for (int j = windowWidth; j >= .5*left; j--) {
    s.vertex(j,top + 1.5*sin(.04*j) - 3*cos(.0037*j) - 4*sin(.012*j) + 2*cos(.061*j));
  }
  s.endShape(CLOSE);
  PShape t = createShape();
  t.beginShape();
  t.fill(41,29,20);
  t.stroke(20,12,9);
  t.strokeWeight(4);
  for (int j = 0; j <= windowHeight; j++) {
    t.vertex(left + 1.5*sin(.04*j) - 3*cos(.0037*j) - 4*sin(.012*j) + 2*cos(.061*j),j);
  }
  t.vertex(0,windowHeight);
  t.vertex(0,0);
  t.endShape(CLOSE);
  
  shape(s, 0, 0);
  shape(t, 0, 0);
}


class Spider {
  float x;
  float y;
  float vx;
  float vy;
  float angle;
  float speed;
  float k;
  float pointing;
  color col;
  float size;
  float phase;
  float birth;
  float webTie;
  float legAngle;
  float abseilSpot;
  boolean abseil;
  boolean parachute;
  float paraLen;
  
  Spider () {
    this.angle = random(0,radians(90));
    this.legAngle = legAmplitude * sin(this.k*(frameCount)-phase);
    this.pointing = PI/2-this.angle;
    this.speed = random(0,3.5);
    this.size = random(10,20);
    this.birth = random(0,1600);
    this.phase = random(0,2*PI);
    this.x = sacX + random(-30,30);
    this.y = sacY + random(-30,30);
    this.k = this.speed/speedk;
    
    this.vx = speed*cos(this.angle);
    this.vy = speed*sin(this.angle);
    
    this.abseil = false;
    this.webTie = random(top-30,top);
    this.abseilSpot = random(top,windowWidth);
    
    this.parachute = false;
    this.paraLen = random(60,150);
    
    this.col = int(random(30,75));
  }
  
  void draw() {
    stroke(20);
    fill(this.col);
    pushMatrix();
    translate(this.x,this.y);
    rotate(this.pointing);
    ellipse(0,0,this.size,this.size);
    fill(180); // eyes, I guess
    ellipse(this.size/10,-this.size/8,this.size/10,this.size/10);
    ellipse(-this.size/10,-this.size/8,this.size/10,this.size/10);
    
    float first = this.size*2.0/8.0;
    
    float third = first*1.5;
    float off = 0;
    
    for (int  j = 0; j <= 3; j++) { //legs
      float angle = -120 + j * 80.0;
      float phi = this.legAngle - angle;
      float phi2 = this.legAngle - angle;
      fill(190);
      float power = pow(-1.0,float(j+1)); // is this leg forwards or backwards?
      float second = first*2 - 1.5*first*sin(radians(this.legAngle*power));
      
      float pos1x = first*cos(radians(angle)); //internal connection point
      float pos1y = first*sin(radians(angle));
      float pos1x2 = -first*cos(radians(angle)); 
      float pos1y2 = first*sin(radians(angle));
      float pos2x = pos1x+second*cos(radians(angle+this.legAngle*power)); // first seg/second seg point
      float pos2x2 = pos1x2-second*cos(radians(angle+this.legAngle*power));
      float pos2y = pos1y+second*sin(radians(angle+this.legAngle*power));
      float pos2y2 = pos1y+second*sin(radians(angle+this.legAngle*power));
      float pos3x = pos2x+third*cos(radians(phi));
      float pos3y = pos2y+third*sin(radians(phi));
      float pos3x2 = pos2x2-third*cos(radians(phi2));
      float pos3y2 = pos2y2+third*sin(radians(phi2));
      
     
      
      
      //ellipse(pos1x,pos1y,4,4);
      //stroke(0,0,120);
      //line(0,0,3*pos1x,3*pos1y); //debug line
      
      strokeWeight(2);
      stroke(this.col+15);//stroke(130+angle);
      
      // right and left sides: first leg segment
      line(pos1x,pos1y,pos2x,pos2y);
      line(pos1x2,pos1y2,pos2x2,pos2y2);
      // right and left: second segment
      line(pos2x,pos2y,pos3x,pos3y);
      line(pos2x2,pos2y2,pos3x2,pos3y2);
      
    }
    popMatrix();
    
    if (this.abseil && this.y < windowHeight*1.1) { // draw web; stop when it's too low
      stroke(random(80,130));
      line(this.x,this.webTie,this.x,this.y-this.size/2);
    }
    
    if (this.parachute && this.y < windowHeight*1.3) { // draw chute; stop when it's too low
      //for (int y = innt(this.y); y >= int(top*.8); y--) {
        
      //}
    }
  }
  
  void move() {
    
    if (!this.abseil && !this.parachute) {
      this.vx += random(-.1,.1);
      this.vy += random(-.1,.1);
      
      if (this.y >= .8*top && this.x >= .9*left ) { // going past the top beam or side - straighten out for a bit
        if (this.y > this.x) { // left beam
          this.vx = random(-.1,0);
        } else { //top beam
          this.vy = random(-.1,0);
          if (this.x >= this.abseilSpot && random(0,1)>.92 && this.x > left*1.3) { // start the lowering
            this.abseil = true;
            this.vx = 0;
            this.vy = random(1,5);
          }
        }
      } 
      
      this.speed = pow(this.vx*this.vx+this.vy*this.vy,.5);
      this.k = this.speed/speedk;
      this.x += this.vx*dt;
      this.y += this.vy*dt;
      
      //change direction it's facing
      if (this.vx != 0) {
        this.pointing = atan(this.vy/this.vx);
      } else {
        this.pointing = 0;
      }
      // move legs
      this.legAngle = legAmplitude * sin(this.k*(frameCount)-phase);
      
    } else if (this.abseil) { // lowering
      this.vy += random(-.1,.1);
      if (this.vy < 0) {
        this.vy = 0;
      }
      this.y += this.vy*dt;
    } else if (this.parachute) { // parachuting
      
      
    }
  }
  
}

void keyPressed() {
  if (key == ' ') {
    if (showBeam) {
      goTime = true;
    } else {
      showBeam = true;
      beamGo = frameCount;
    }
  } else if (int(key) ==48 ) { //0: logo
    //clear();
    println("picMode");
    picMode = true;
    fadeTargetTime = frameCount + fadeLength;
  }
}

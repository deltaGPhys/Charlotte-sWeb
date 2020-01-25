import org.openkinect.freenect.*;
import org.openkinect.processing.*;

ArrayList<Vertex> verts = new ArrayList<Vertex>(); //var verts = {}; //vertices
ArrayList<Connection> conns = new ArrayList<Connection>(); //connections
ArrayList<Web> web = new ArrayList<Web>(); //writing
ArrayList<Fly> flies = new ArrayList<Fly>(); //flies
int firstNode = -1;
float[][][] vertexSet = { //preset vertex sets
  {{609,331},{662,297},{708,332},{694,375},{634,378},{583,432},{507,512},{388,619},{536,640},{511,332},{373,367},{177,420},{100,600},{16,365},{340,243},{151,169},{25,73},{629,200},{461,126},{379,26},{637,25},{822,289},{918,107},{1024,13},{1058,251},{1400,111},{873,413},{1057,478},{1400,549},{744,469},{879,609},{1019,652},{1279,52}},
  {{711,241},{560,377},{739,532},{939,348},{699,19},{160,46},{48,550},{747,645},{1402,428},{1243,35}},
  {{400,400},{300,500}},
  {{20,230},{1400,230},{720,30},{720,650},{720,230}},
  {{1439.6590255854362,500.0080636955695},{1083.193818907999,672.8261064904522},{824.0867700811505,672.7587460484465},{643.5633035569492,672.9259672452016},{408.8134206613545,672.5459981007259},{0.673762004311873,559.1628916792455},{0.3409744146064905,172.9919363044305},{356.8061810920102,0.17389350955924954},{615.9132299188495,0.24125395154778184},{796.4366964430508,0.07403275479268112},{1031.1865793386542,0.45400189926420964},{1439.3262379957318,113.83710832076287},{727.7207690490263,327.80475438391034},{737.30428438666,339.7924675048515},{730.2744375577289,362.3147542746633},{714.9637760777339,369.7873798284449},{690.0106896128945,370.83978673925634},{664.6194964873838,374.915793737685},{648.9265447381749,327.2204669460339},{653.1365079252506,299.2501397064658},{667.6715397763461,261.1584700782142},{722.4924181766495,230.83523576260325},{781.0271136205693,222.80474622892112},{830.4060041109877,261.39390462851543},{856.8630153409047,330.91586647229053},{851.9527287029354,415.16981528265404},{803.6663467287227,474.19066558959685},{715.2900447606715,509.21029944078475},{618.0160720676353,495.6019090602876},{550.0381769378324,434.92724422363756},{499.6248541153898,334.29779540091073},{525.2978904457503,216.42303702217137},{605.6514483376956,120.0773991017946},{721.3011547136794,87.90699191418355},{852.771542675485,117.22685035191964},{949.6291843463204,197.27947659898356},{1015.8394545304459,341.4341987412722},{975.5590725916588,495.94324132176996},{871.1992594267971,612.9974463145955},{724.2415886421124,670.3867081251228},{559.1923790719519,619.8368407152548},{409.37425973133975,501.21723491963604},{353.6097073939442,346.4466032250467},{390.4431337138532,145.59211094467196},{522.9323329309988,-4.699848818010198},{713.0862290196187,-55.77432443715586},{924.7124734280108,-25.09250234549401},{1074.0578501709972,123.28179479646},{1160.0625906030825,340.6236905032574},{1097.9038845994942,564.2212140664485},{943.4141584835008,730.94570284343},{727.850533224125,794.6554552116269},{475.37512503112674,757.0959740057793},{296.46291290748974,590.6505631817874},{217.77732068153082,337.4876999430738},{274.0701670426839,76.0896464563347},{447.7759412458473,-124.33016824684194},{720.584324790043,-193.7557368783964},{997.5485403234621,-137.91082927596082},{1202.0410539474615,60.417000933412226},{1291.613976925438,330.7395728180811},{1225.9671300435896,624.9668009750653},{1029.6508232025183,854.078428456343},{714.4419343912157,955.781681193472},{400.62613662432466,867.981942585022},{164.9614667066081,654.1566325559019},{63.861551122938536,342.81067208185414},{147.62950171641006,14.993556465399006},{383.30547952868744,-251.93372639876995},{714.8813067824912,-350.0845045164711},{1074.6639180320649,-272.73411078549816},{1331.626550947842,-16.747962169969263},{1440.9376608127852,334.0555493946062},{1358.4139370354505,707.8026190795256},{1101.3482972431323,980.2732615961587},{710.4478395023708,1100.4518023270768},{333.3957955634896,997.8954089009198},{41.353146502425645,717.8178444979568},{-73.63853601517114,339.65769804326084},{33.21574452874957,-58.94905730941237}},  
  {{1380,500.0080636955695},{1083.193818907999,672.8261064904522},{824.0867700811505,672.7587460484465},{643.5633035569492,672.9259672452016},{408.8134206613545,672.5459981007259},{0.673762004311873,559.1628916792455},{0.3409744146064905,172.9919363044305},{356.8061810920102,0.17389350955924954},{615.9132299188495,0.24125395154778184},{796.4366964430508,0.07403275479268112},{1031.1865793386542,0.45400189926420964},{1380.3262379957318,113.83710832076287},{727.7207690490263,327.80475438391034},{737.30428438666,339.7924675048515},{730.2744375577289,362.3147542746633},{714.9637760777339,369.7873798284449},{690.0106896128945,370.83978673925634},{664.6194964873838,374.915793737685},{648.9265447381749,327.2204669460339},{653.1365079252506,299.2501397064658},{667.6715397763461,261.1584700782142},{722.4924181766495,230.83523576260325},{781.0271136205693,222.80474622892112},{830.4060041109877,261.39390462851543},{856.8630153409047,330.91586647229053},{851.9527287029354,415.16981528265404},{803.6663467287227,474.19066558959685},{715.2900447606715,509.21029944078475},{618.0160720676353,495.6019090602876},{550.0381769378324,434.92724422363756},{499.6248541153898,334.29779540091073},{525.2978904457503,216.42303702217137},{605.6514483376956,120.0773991017946},{721.3011547136794,87.90699191418355},{852.771542675485,117.22685035191964},{949.6291843463204,197.27947659898356},{1015.8394545304459,341.4341987412722},{975.5590725916588,495.94324132176996},{871.1992594267971,612.9974463145955},{724.2415886421124,670.3867081251228},{559.1923790719519,619.8368407152548},{409.37425973133975,501.21723491963604},{353.6097073939442,346.4466032250467},{390.4431337138532,145.59211094467196},{522.9323329309988,10.699848818010198},{713.0862290196187,15.77432443715586},{924.7124734280108,15.09250234549401},{1074.0578501709972,123.28179479646},{1160.0625906030825,340.6236905032574},{1097.9038845994942,564.2212140664485},{943.4141584835008,730.94570284343},{727.850533224125,794.6554552116269},{475.37512503112674,757.0959740057793},{296.46291290748974,590.6505631817874},{217.77732068153082,337.4876999430738},{274.0701670426839,76.0896464563347},{447.7759412458473,20},{720.584324790043,20.7557368783964},{997.5485403234621,20.91082927596082},{1202.0410539474615,60.417000933412226},{1291.613976925438,330.7395728180811},{1225.9671300435896,624.9668009750653},{1029.6508232025183,854.078428456343},{714.4419343912157,955.781681193472},{400.62613662432466,867.981942585022},{164.9614667066081,654.1566325559019},{63.861551122938536,342.81067208185414},{147.62950171641006,14.993556465399006},{383.30547952868744,20},{714.8813067824912,20.0845045164711},{1074.6639180320649,12.73411078549816},{1331.626550947842,16.747962169969263},{1380.9376608127852,334.0555493946062},{1358.4139370354505,707.8026190795256},{1101.3482972431323,980.2732615961587},{710.4478395023708,1000.4518023270768},{333.3957955634896,997.8954089009198},{41.353146502425645,717.8178444979568},{13.63853601517114,339.65769804326084},{33.21574452874957,18.94905730941237}},  
};  
int[][][] connSet = { //preset connection sets
  {{3,2},{2,1},{1,0},{0,4},{4,3},{29,26},{26,21},{21,17},{17,9},{9,5},{5,29},{14,10},{10,6},{6,30},{30,27},{27,24},{22,24},{22,20},{20,18},{14,18},{19,15},{15,11},{11,7},{8,7},{8,31},{31,28},{28,25},{25,23},{23,19},{13,13},{16,16},{16,16},{13,13},{12,0},{1,17},{17,20},{0,9},{9,10},{10,11},{13,11},{11,12},{14,15},{15,16},{14,9},{18,17},{18,19},{23,22},{22,21},{21,2},{3,26},{26,27},{27,28},{21,24},{24,25},{31,30},{30,29},{6,5},{5,4},{3,29},{6,8},{7,6}},
  {{1,0},{0,3},{3,2},{2,1},{1,6},{6,5},{5,1},{4,5},{0,4},{4,9},{9,3},{3,8},{8,9},{8,7},{7,2},{7,6}},
  {{0,1}},
  {{0,4},{1,4},{2,4},{3,4}},
  {{12,13},{13,14},{14,15},{15,16},{16,17},{17,18},{18,19},{19,20},{20,21},{21,22},{22,23},{23,24},{24,25},{25,26},{26,27},{27,28},{28,29},{29,30},{30,31},{31,32},{32,33},{33,34},{34,35},{35,36},{36,37},{37,38},{38,39},{39,40},{40,41},{41,42},{42,43},{43,44},{44,45},{47,48},{48,49},{49,50},{50,51},{51,52},{52,53},{53,54},{54,55},{55,56},{56,57},{57,58},{59,60},{60,61},{61,62},{62,63},{63,64},{64,65},{65,66},{66,67},{67,68},{68,69},{69,70},{72,73},{73,74},{74,75},{75,76},{76,77},{77,78},{78,79},{0,12},{1,13},{2,14},{3,15},{4,16},{5,17},{6,18},{7,19},{8,20},{9,21},{10,22},{11,23},{12,24},{13,25},{14,26},{15,27},{16,28},{17,29},{18,30},{19,31},{20,32},{21,33},{22,34},{23,35},{24,36},{25,37},{26,38},{27,39},{28,40},{29,41},{30,42},{31,43},{32,44},{33,45},{34,46},{35,47},{36,48},{37,49},{38,50},{39,51},{40,52},{41,53},{42,54},{43,55},{44,56},{45,57},{46,58},{47,59},{48,60},{49,61},{50,62},{51,63},{52,64},{53,65},{54,66},{55,67},{56,68},{57,69},{58,70},{59,71},{60,72},{61,73},{62,74},{63,75},{64,76},{65,77},{66,78},{67,79},{18,12},{21,12},{23,12},{20,12},{17,12}},
  {{12,13},{13,14},{14,15},{15,16},{16,17},{17,18},{18,19},{19,20},{20,21},{21,22},{22,23},{23,24},{24,25},{25,26},{26,27},{27,28},{28,29},{29,30},{30,31},{31,32},{32,33},{33,34},{34,35},{35,36},{36,37},{37,38},{38,39},{39,40},{40,41},{41,42},{42,43},{43,44},{44,45},{47,48},{48,49},{49,50},{50,51},{51,52},{52,53},{53,54},{54,55},{55,56},{56,57},{57,58},{59,60},{60,61},{61,62},{62,63},{63,64},{64,65},{65,66},{66,67},{67,68},{68,69},{69,70},{72,73},{73,74},{74,75},{75,76},{76,77},{77,78},{78,79},{0,12},{1,13},{2,14},{3,15},{4,16},{5,17},{6,18},{7,19},{8,20},{9,21},{10,22},{11,23},{12,24},{13,25},{14,26},{15,27},{16,28},{17,29},{18,30},{19,31},{20,32},{21,33},{22,34},{23,35},{24,36},{25,37},{26,38},{27,39},{28,40},{29,41},{30,42},{31,43},{32,44},{33,45},{34,46},{35,47},{36,48},{37,49},{38,50},{39,51},{40,52},{41,53},{42,54},{43,55},{44,56},{45,57},{46,58},{47,59},{48,60},{49,61},{50,62},{51,63},{52,64},{53,65},{54,66},{55,67},{56,68},{57,69},{58,70},{59,71},{60,72},{61,73},{62,74},{63,75},{64,76},{65,77},{66,78},{67,79},{18,12},{21,12},{23,12},{20,12},{17,12}},
};

int dt = 1; 
int preSet = 5; // -1: none, 0: normal, 1: small, 2: training wheels, 3: just in middle, 4: spiral 5: showtime, baby
int R = 20; //effective range for affecting web nodes
int rate = 200; //frame rate
int deb = rate*0; // gives 4 s to debug
int margin = 50;
boolean eraseNow = false; // erase writing?
int eraseSpeed = 800; // remove one connection every other frame
boolean react = true;
int windowWidth = 0;
int windowHeight = 0;
int CMthresh = 915;
int topThresh = 855;

int fadeLength = 14;
int fadeTargetTime;
int oldPic = -1;

boolean mouseDraw = false;
int lastX = -1;
int lastY = -1;

boolean aBox = false;
boolean debugImage = false;
boolean drawVerts = false;
boolean drawLerp = false;
boolean drawCursor = false;
boolean showMouse = false;
boolean drawMode = false;
boolean trackCM = true;
boolean help = false;
boolean kDisplay = true;
boolean eatFlies = false;
boolean picMode = false;
int picNum = -1;
float g = .5;
boolean trackTop = false; //top track or CM track
PVector v1;
PVector v2;
PVector toploc;

PImage[] imgs = new PImage[7];
float aspectRatio;

//float[][] picInfo = { // width, height to display as fractions of windowWidth and windowHeight
//  {.5,.5},
//  {.1,.1},
//  {.8,.8},
//  {.5,.1},
//  {.1,.5},
//  {.5,.5},
//  {.5,.5},
//};
// The kinect stuff is happening in another class
KinectTracker tracker;
Kinect kinect;


void setup() {
  noCursor();
  blendMode(LIGHTEST);
  //size(1400,1050);
  fullScreen();
  frameRate(rate);
  windowWidth = width;
  windowHeight = height;
  println(windowWidth,windowHeight);
  
  aspectRatio = float(windowWidth)/float(windowHeight);
  //println("aspect:",str(aspectRatio));
  for (int i = 0; i < 7; i++) {
    imgs[i] = loadImage(str(i)+".jpg");
    
  }
  

  if (preSet >= 0) {
    for (int i = 0; i < vertexSet[preSet].length; i++){
      verts.add(new Vertex(vertexSet[preSet][i][0],vertexSet[preSet][i][1]));
    }
    for (int i = 0; i < connSet[preSet].length; i++){
      conns.add(new Connection(connSet[preSet][i][0],connSet[preSet][i][1]));
    }
  }
  
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  tracker.setThreshold(CMthresh);
  
}

void draw() {
  if (!picMode) {
    if (frameCount > deb && deb != 0) {
      background(100);
    } else {
      background(0);
    }
    //anchorBox();
    noStroke();
    fill(100);
    if (drawCursor) {
      ellipse(mouseX, mouseY, 20, 20);
    }
    
    //draw stuff, calculate forces, move 
    for (int i = 0; i < conns.size(); i++) {
      conns.get(i).draw();
      conns.get(i).force();
    }
    if (frameCount%1 == 0) {
      // Run the tracking analysis
      tracker.track();
      // Show the image
      if (debugImage) { tracker.display(); }
    }
    
    if (trackTop || drawMode) {
      // Let's draw the raw location
      v1 = tracker.trackTop();
      //println(v1.x,v1.y);
      if (drawLerp || drawMode || eatFlies) {
        //fill(50, 100, 250, 200);
        fill(130,130);
        noStroke();
        if (mouseDraw) {
          ellipse(mouseX, mouseY, 20, 20);
        } else {
          ellipse(v1.x, v1.y, 20, 20);
        }
      }
    } 
    if (trackCM) {
      // Let's draw the "lerped" location USE THIS ONE
      v2 = tracker.getLerpedPos();
      if (drawLerp) {
        fill(100, 250, 50, 200);
        noStroke();
        ellipse(v2.x, v2.y, 5*R, 5*R);
      }
    }
    
    for (int j = 0; j < verts.size(); j++) {
      //if (dist(mouseX,mouseY,verts.get(j).x,verts.get(j).y) < R && !verts.get(j).outside && react){ // affecting the nodes
      //  verts.get(j).x = mouseX;
      //  verts.get(j).y = mouseY;
      //}
      float vertDist = dist(v2.x,v2.y,verts.get(j).x,verts.get(j).y);
      if (vertDist < 5*R && !verts.get(j).outside && react){ // affecting the nodes
    
        verts.get(j).weight = 12*(1-vertDist/(5*R));
      } else {
        verts.get(j).weight = 0;
      }
      //if (j == 14) {
      //  println(verts.get(j).weight,verts.get(j).x,verts.get(j).y);
      //}
      
      if (drawVerts) {verts.get(j).draw();}
      
      if (frameCount < deb || deb == 0) {
        //console.log('moving vertex',j);
        if (!verts.get(j).outside) {
          verts.get(j).move();
        }
      }
    }
    
    for (int k = 0; k < flies.size(); k++) {
      flies.get(k).move();
      flies.get(k).draw();
    }
    
    if (web.size() > 0) { //draw web writing
      strokeWeight(1);
      react = false;
      drawWeb();
    } else {
      //react = true;
    }
    
    if (eraseNow) { // erase web
      eraseWeb();
    }
    
    if (help) { // on-screen help
      showHelp();
    }
    
    if (aBox) {
      anchorBox();
    }
    //if (drawMode) {
    //  ellipse(v1.x, v1.y, 20, 20);
      
    //}
    
    if (mousePressed && drawMode && random(0,1)>.1) { // "d"
      //println("drawing");
      addWeb();
    }
  } else { //picMode
    //println("frame",str(frameCount));
    background(0);
    // calc pic characteristics
    float w;
    float h;
    int pNum;
    float alpha = 255;
    
    if (oldPic != -1) {
      pNum = oldPic;
    } else {
      pNum = picNum;
    }
      //float w = windowWidth * picInfo[picNum][0];
      //float h = windowHeight * picInfo[picNum][1];
      //println(windowWidth,windowHeight);
      //println(imgs[picNum].width,imgs[picNum].height);
    float picRatio = float(imgs[pNum].width)/float(imgs[pNum].height);
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
    
    if (oldPic == -1 && frameCount < fadeTargetTime){ //fading in
      //state = "fading in";
      //println("fading in new",str(pNum),str(fadeTargetTime),str(frameCount));
      alpha = map(fadeTargetTime-frameCount,0,fadeLength,255,0); //fade in
      //println(fadeTargetTime-frameCount,alpha);
      
    } else if (oldPic != -1) { // fading out
      //state = "fading out";
      //println("fading out old",str(pNum),str(fadeTargetTime),str(frameCount));
      if (frameCount < fadeTargetTime) {
        noStroke();
        alpha = map(fadeTargetTime-frameCount,0,fadeLength,0,255); //fade out
        //println(fadeTargetTime-frameCount,alpha);
        
      } else { // fade out complete - set up the fade in
        //state = "fade out complete";
        oldPic = -1;
        alpha = 0;
        fadeTargetTime = frameCount + fadeLength + 1;
      } 
    } else {
      //state = "other";
      alpha = 255;
      //println("reg display",str(pNum));
    }
    
    tint(255,alpha);
    image(imgs[pNum],a,b,w,h);
    //println(frameCount,alpha,pNum,state);
  }
  
    
}


class Vertex {
  float x;
  float y;
  float vx;
  float vy;
  float size;
  int id;
  boolean outside;
  float weight;
  
  Vertex(float xtemp, float ytemp) {
    this.x = xtemp;
    this.y = ytemp;
    this.vx = 0;
    this.vy = 0;
    this.size = 10;
    this.id = verts.size();
    this.weight = 0;
   
    if ((this.x < margin) || (windowWidth-this.x < margin) || (this.y < margin) || (windowHeight-this.y < margin)) {
      this.outside = true;
    } else {
      this.outside = false;
    }
  }
  
  
  void draw() {
    noStroke();
    if (this.outside) {
      fill(110);
    } else {
      fill(220);
    }
     
    ellipse(this.x,this.y,this.size,this.size);
    
  }
  //console.log('vertex created:',this.id);
  
  void move() {
    //console.log('checking for links:',this.id);
    int[] links1 = {};
    int[] links2 = {};
    
    for (int i = 0; i < conns.size(); i++) { // find connections with this node
      if (this.id == conns.get(i).first) {
        links1 = append(links1,i);
      } else if (this.id == conns.get(i).second) {
        links2 = append(links2,i);
      }
    }
    //console.log(links1,links2);
    // sum up the dv contributions
    float dvx = 0;
    float dvy = 0;
    float b = .001;
    for (int i = 0; i < links1.length; i++) {
      //console.log('f1:',i,conns[links1[i]].F[0],conns[links1[i]].F[1]);
      dvx += b*conns.get(links1[i]).F[0];
      dvy += b*conns.get(links1[i]).F[1];
    }
    for (int i = 0; i < links2.length; i++) {
      //console.log('f2:',i,conns[links2[i]].F[0],conns[links2[i]].F[1]);
      dvx -= b*conns.get(links2[i]).F[0];
      dvy -= b*conns.get(links2[i]).F[1];
    }
    // v and x updates, drag
    this.vx += dvx;
    this.vy += dvy + this.weight*g;
    this.vx = this.vx*.95;
    this.vy = this.vy*.95;
    this.x += this.vx;
    this.y += this.vy;
  }
}

class Connection {
  int first;
  int second; 
  float k;
  float weight;
  float L0;
  float[] F= {0,0};;
  
  Connection(int firsttemp, int secondtemp){
    this.first = firsttemp;
    this.second = secondtemp; 
    this.k = 100;
    this.weight = 3;
    this.L0 = dist(verts.get(this.first).x,verts.get(this.first).y,verts.get(this.second).x,verts.get(this.second).y);
    
  }
  
  void draw() {
    float distance = dist(verts.get(this.first).x,verts.get(this.first).y,verts.get(this.second).x,verts.get(this.second).y);
    strokeWeight(this.weight);
    stroke(200);
    noFill();
    beginShape();
    //console.log('draw',this.first,this.second,this.weight);
    //line(verts[this.first].x,verts[this.first].y,verts[this.second].x,verts[this.second].y);
    //console.log(verts[this.first].x,verts[this.first].y,verts[this.second].x,verts[this.second].y);
    curveVertex(verts.get(this.first).x,verts.get(this.first).y);
    curveVertex(verts.get(this.first).x,verts.get(this.first).y);
    
    curveVertex(.5*(verts.get(this.first).x+verts.get(this.second).x),
                .5*(verts.get(this.first).y+verts.get(this.second).y)+5*(1-(distance-this.L0)/this.L0));
    
    curveVertex(verts.get(this.second).x,verts.get(this.second).y);
    curveVertex(verts.get(this.second).x,verts.get(this.second).y);
    endShape();
  }
  
  void force() { // calculate force
    float distance = dist(verts.get(this.first).x,verts.get(this.first).y,verts.get(this.second).x,verts.get(this.second).y);
    float magnitude = this.k * (distance - this.L0);
    this.F[0] = magnitude*(verts.get(this.second).x-verts.get(this.first).x)/distance;
    this.F[1] = magnitude*(verts.get(this.second).y-verts.get(this.first).y)/distance;
    //println("force",this.F[0],this.F[1]);
  }
  
}

class Web {
  float x1;
  float x2;
  float y1;
  float y2;
  float colors;
  
  Web(float x1temp, float y1temp, float x2temp, float y2temp, float colortemp){
    this.x1 = x1temp;
    this.x2 = x2temp;
    this.y1 = y1temp;
    this.y2 = y2temp;
    this.colors = colortemp;
  }
  
  void show () {
    stroke(this.colors);
    line(x1,y1,x2,y2);
  }
}


class Fly {
  float x;
  float y;
  float vx;
  float vy;
  float angle;
  int birth;
  boolean cocoon;
  float twitch;
  float twitchLen;
  float twitch2;
  float twitchLen2;
  int silkCount;
  int stuck;
  boolean eaten;
  
  Fly() {
  if (random(0,1)>.5) {
    this.x = random(random(0,100),random(windowWidth-100,windowWidth));
    this.y = random(0,windowHeight);
  } else {
    this.x = random(0,windowWidth);
    this.y = random(random(0,20),random(windowHeight-20,windowHeight));
  }
  
  this.vx = map(windowWidth/2-this.x,0,windowWidth/2,-.03,.03);//random(-.01,.01);
  this.vy = map(windowHeight/2-this.y,0,windowHeight/2,-.03,.03);//random(-.01,.01);
  this.angle = 0;
  this.birth = frameCount;
  this.cocoon = false;
  this.twitch = random(0,100);
  this.twitchLen = random(10,30);
  this.twitch2 = random(100,200);
  this.twitchLen2 = random(10,50);
  this.silkCount = 0;
  this.stuck = -1;
  }
  
  void draw() {
    pushMatrix();
    
    fill(100);
    stroke(40);
    translate(this.x,this.y);
    rotate(this.angle);
    ellipse(0,0,10,23);
    fill(200);
    stroke(200);
    // wing flapping
    if ((this.stuck < 0) || (this.silkCount > this.twitch && this.silkCount < this.twitch+this.twitchLen) ||
        (this.silkCount > this.twitch2 && this.silkCount < this.twitch2+this.twitchLen2)) {
      ellipse(5,4,3+frameCount%7,4);
      ellipse(-5,4,3+frameCount%7,4);
    } else {
      ellipse(5,4,5,4);
      ellipse(-5,4,5,4);
    }
    
    popMatrix();
  }
  
  void move() {
    if (this.stuck < 0) { // still free
      this.angle = atan(this.vy/this.vx)*2/PI;
      this.vx += random(-.1,.1);
      this.vy += random(-.1,.1);
      this.x += this.vx;
      this.y += this.vy;
    
      if (frameCount - this.birth > 300 && random(0,1) > .9) { // check for catch
        for (int j = 0; j < verts.size(); j++) {
          if (dist(this.x,this.y,verts.get(j).x,verts.get(j).y) < 20 && !verts.get(j).outside) { //caught fly on normal vertex
            verts.get(j).x = (verts.get(j).x + this.x)/2;
            verts.get(j).y = (verts.get(j).y + this.y)/2;
            this.x = verts.get(j).x;
            this.y = verts.get(j).y;
            this.stuck = j;
            break;
          } else if (dist(this.x,this.y,verts.get(j).x,verts.get(j).y) < 20) { // caught on fixed point
            this.x = verts.get(j).x;
            this.y = verts.get(j).y;
            this.stuck = j;
            break;
          }
        }
      }
    } else {  // caught
      if (this.cocoon == false && !verts.get(this.stuck).outside) {
        this.silkCount++;
        if (this.silkCount > this.twitch && this.silkCount < this.twitch+this.twitchLen) {
          this.x += random(-2,2);
          this.y += random(-2,2);
          verts.get(this.stuck).x = this.x;
          verts.get(this.stuck).y = this.y;
        } else if (this.silkCount > this.twitch2 && this.silkCount < this.twitch2+this.twitchLen2) {
          this.x += random(-1.5,1.5);
          this.y += random(-1.5,1.5);
          verts.get(this.stuck).x = this.x;
          verts.get(this.stuck).y = this.y;
        } else {
          this.x = verts.get(this.stuck).x;
          this.y = verts.get(this.stuck).y;
        }
      }
    }
    
  }
  
  void wrap() {
    int r = 7;
    int d = 3;
    int numStrokes = 50;
    float angle = 0;
    
    for (int j = 0; j < numStrokes; j++) {
      angle = random(0,180);
      web.add(new Web(this.x+(r+random(0,d))*cos(angle),this.y+(r+random(0,d))*sin(angle),
                      this.x-(r+random(0,d))*cos(angle),this.y-(r+random(0,d))*sin(angle),
                      random(150,200)
                      ));
    } 
  }
}


void anchorBox() {
  noFill();
  stroke(255);
  strokeWeight(1);
  rect(margin,margin,windowWidth-2*margin,windowHeight-2*margin);
}

void mouseClicked() {
  int thisClick = -1;
  if (keyPressed && key == ' ') { // click/space adds connection
    for (int i = 0; i < verts.size(); i++) {
      if (dist(mouseX,mouseY,verts.get(i).x,verts.get(i).y) < verts.get(i).size/2) { //clicked a vertex
        //console.log('clicked vertex',i);
        thisClick = i;
        break;
      }  
    }
    
    if (thisClick == -1) { // if clicking in space, clear the queue
      //console.log('clicked in space');
      firstNode = -1;
      return;
    }
    
    if (firstNode >= 0) { // there was already a stored node
      int newConn = -1;
      for (int k = 0; k < conns.size(); k++) {
        if ((conns.get(k).first == thisClick && conns.get(k).second == firstNode) ||  // find out if conn exists
            (conns.get(k).second == thisClick && conns.get(k).first == firstNode)) {
          newConn = k;
          println("deleting connection",k);
          break;
        }
      }
      if (newConn < 0) {
        conns.add(new Connection(firstNode,thisClick));
      } else {
        conns.remove(newConn);
      }
        
        
      //console.log('create connection',firstNode,thisClick);
      thisClick = -1;
      firstNode = -1;
    } else { // this is the first node for a new connection
      firstNode = thisClick;
      //console.log('set firstNode',thisClick);
    }
      
  } else if (eatFlies) { // eat a fly
    PVector pos = tracker.trackTop();
    float minDist = 1000000;
    int which = 0;
    float thisDist = 1000000;
    for (int j = 0; j < flies.size(); j++){ // check all flies, find closest
      thisDist = dist(pos.x,pos.y,flies.get(j).x,flies.get(j).y);
      if (thisDist < minDist) {
        minDist = thisDist;
        which = j;
      }
    }
    if (minDist < 500 && flies.get(which).stuck >= 0) {
      flies.remove(which);
    }
  } else if (!keyPressed) { // don't add if keys (in particular, 'd') are down
    verts.add(new Vertex(mouseX,mouseY)); // clicks add new vertices
  }
}

//void mousePressed () {
//  println("here?");
//  if (drawMode && random(0,1)>.5) { // "d"
//    println("drawing");
//    addWeb();
//  }
//}

void mouseReleased() {
  lastX = -1;
  lastY = -1;
}

void drawWeb () {
  for (int i = 0; i < web.size(); i++) {
    web.get(i).show();
  }
}

void eraseWeb () {
  if (web.size() >= eraseSpeed) {
    for (int i = 0; i < eraseSpeed; i++) {
      web.remove(web.size()-1);
    }
  } else if (web.size() > 0){
    web.clear();
    eraseNow = false;
    trackCM = true;
    trackTop = false;
    drawMode = false;
    react = true;
  }
  
}

void addWeb () {
  //print("drawing");
  int w = 16;
  int h = 20; 
  int numStrokes = int(random(10,16));
  int X;
  int Y;
  
  if (mouseDraw) {
    
    X = mouseX;
    Y = mouseY;
    //println(X,Y,X+random(0,w),Y+random(-h,h));
  } else {
    
    PVector pos = tracker.trackTop();
  
    X = int(pos.x);
    Y = int(pos.y);
    
  }
 
  if (lastX >= 0 && X != 0) { // draw only if there's a second point to connect to and not at 0,0
    for (int j = 0; j < numStrokes; j++) {
  
      //web.add(new Web(X+random(0,w),Y+random(-h,h), //old one: random arounnd point
      //                X+random(w,0),Y+random(-h,h),
      //                random(150,200)
      //                ));
      web.add(new Web(lastX+random(-w,w),lastY+random(-h,h), //new one: random around connnection to last point
                      X+random(-w,w),Y+random(-h,h),
                      random(150,200)
                      ));
    }  
  }
  if (X != 0) {
    lastX = X;
    lastY = Y;
  }
    
}

void showHelp() {
  int start = 30;
  int dely = 20;
  textSize(20);
  textAlign(RIGHT);
  fill(10,70,220);
  String tracking = "none";
  if (trackTop) {
    tracking = "top";
  } else if (trackCM) {
    tracking = "CM";
  } else {
    tracking = "none";
  }
  int t = tracker.getThreshold();
    
  String strings[] = {
    "toggle CM/top/no track: t (" + tracking + ")",
    "threshold: up/down (" + str(t) + ")",
    "Kinect display: k (" + str(kDisplay) + ")",
    "Draw lerp: l (" + str(drawLerp) + ")",
    "Draw verts: v (" + str(drawVerts) + ")",
    "Draw cursor: c (" + str(drawCursor) + ")",
    "Draw mouse arrow: a (" + str(showMouse) + ")",
    "border box: b (" + str(aBox) + ")",
    "react: r (" + str(react) + ")",
    "draw mode: d (" + str(drawMode) + ")",
    "erase: e",
    "pics: # (" + str(picMode) + ")",
    "mouseDraw: z (" + str(mouseDraw) + ")",
    "add fly: f",
    "fly-eating mode: w (" + str(eatFlies) + ")",
    "add vert: click",
    "add conn: space+click",
    "print data: s",
    "make spiral: m",
  };
  
  for (int i = 0; i < strings.length; i++) {
    text(strings[i],windowWidth-20,start+dely*i);
  }
  
}

void keyPressed() {
  String connString = "{";
  String vertString = "{";
  int t = tracker.getThreshold();
  if (key == 's'){ //"s" display current vertices/connections in console
    for (int i = 0; i < verts.size(); i++) {
      vertString += "{"+verts.get(i).x+","+verts.get(i).y+"},";
    }
    vertString += "}";
    for (int i = 0; i < conns.size(); i++) {
      connString +="{"+conns.get(i).first+","+conns.get(i).second+"},";
    }
    connString += "}";
    println(vertString);
    println(connString);
  } else if (int(key) >=48 && int(key) <= 55) { //0-6: images
    //clear();
    picMode = true;
    if (picNum != -1) { // if we're coming from another pic
      //println("replace pic",str(picNum),"with",str(int(key)-48));
      oldPic = picNum; //if we're already on a pic, store last one, for fading
    }
    picNum = int(key)-48;
    //println("old:",str(oldPic),"new:",str(picNum));
    fadeTargetTime = frameCount + fadeLength;
  } else if (key == 'p') {
    picMode = false;
    picNum = -1;
  } else if (key == 'm') { //"m" make a spiral
    //spiralMake();
  } else if (key == 'b') { //"b" turn border box on or off
    aBox = !aBox;
  } else if (key == 'd') { //"d" draw mode
    drawMode = true;
    trackCM = false;
    trackTop = false;
    react = false;
    tracker.setThreshold(topThresh);
  } else if (key == 'z') {
    mouseDraw = !mouseDraw;
  } else if (key == 'r') { //"r" react to cursor
    react = !react;
  } else if (key == 'v') { //"v" draw verts 
    drawVerts = !drawVerts;
  } else if (key == 'c') { //"c" draw cursor 
    drawCursor = !drawCursor;
  } else if (key == 'a') { //"a" draw mouse arrow cursor 
    showMouse = !showMouse;
    if (showMouse) {
      cursor();
    } else {
       noCursor();
    }
  } else if (key == 'l') { //"l" draw lerp position
    drawLerp = !drawLerp;
  } else if (key == 'f') { //"f" new fly
    flies.add(new Fly());
  } else if (key == 'w') { //"w" fly-eating mode
    if (eatFlies) {
      trackCM = true;
      trackTop = false;
      eatFlies = false;
      tracker.setThreshold(CMthresh);
    } else {
      trackCM = false;
      trackTop = true;
      eatFlies = true;
      tracker.setThreshold(topThresh);
    }
  } else if (key == 'e') { //"e" erase web
    eraseNow = true;
    tracker.setThreshold(CMthresh);
  } else if (key == 'k') { //"k" display Kinect data toggle
    debugImage = !debugImage;
  } else if (key == 't') { //"t" toggle tracking of object (CM/top/none)
    if (trackCM) {
      trackTop = true;
      trackCM = false;
    } else if (trackTop) {
      trackTop = false;
      trackCM = false;
    } else {
      trackCM = true;
    }
  } else if (key == CODED) {
    if (keyCode == UP) {
      t+=5;
      tracker.setThreshold(t);
    } else if (keyCode == DOWN) {
      t-=5;
      tracker.setThreshold(t);
    }
  } else if (key == '?') {
    help = !help;
  }

}

class KinectTracker {

  // Depth threshold
  int threshold = 745;

  // Raw location
  PVector loc;

  // Interpolated location
  PVector lerpedLoc;

  // Depth data
  int[] depth;
  
  // What we'll show the user
  PImage display;
   
  KinectTracker() {
    // This is an awkard use of a global variable here
    // But doing it this way for simplicity
    kinect.initDepth();
    kinect.enableMirror(true);
    // Make a blank image
    display = createImage(kinect.width, kinect.height, RGB);
    // Set up the vectors
    loc = new PVector(0, 0);
    lerpedLoc = new PVector(0, 0);
  }

  void track() {
    // Get the raw depth as array of integers
    depth = kinect.getRawDepth();

    float wRatio = float(windowWidth)/float(kinect.width);
    float hRatio = float(windowHeight)/float(kinect.height);
    
    // Being overly cautious here
    if (depth == null) return;

    float sumX = 0;
    float sumY = 0;
    float count = 0;

    for (int x = 0; x < kinect.width; x++) {
      for (int y = 0; y < kinect.height; y++) {
        
        int offset =  x + y*kinect.width;
        // Grabbing the raw depth
        int rawDepth = depth[offset];

        // Testing against threshold
        if (rawDepth < threshold) {
          sumX += x;
          sumY += y;
          count++;
        }
      }
    }
    // As long as we found something
    if (count != 0) {
      loc = new PVector(sumX*wRatio/count, sumY*hRatio/count);
    }

    // Interpolating the location, doing it arbitrarily for now
    lerpedLoc.x = PApplet.lerp(lerpedLoc.x, loc.x, 0.3f);
    lerpedLoc.y = PApplet.lerp(lerpedLoc.y, loc.y, 0.3f);
  }

  PVector getLerpedPos() {
    return lerpedLoc;
  }

  PVector getPos() {
    return loc;
  }

  PVector trackTop() {
    // Get the raw depth as array of integers
    depth = kinect.getRawDepth();

    float wRatio = float(windowWidth)/float(kinect.width);
    float hRatio = float(windowHeight)/float(kinect.height);
    float widthReq = 10;
    
    float topX = -1;
    float topY = -1;
    int count = 0;
    for (int y = 0; y < kinect.height; y++) {
      if (count < widthReq) {
        for (int x = 0; x < kinect.width; x++) {
          
          int offset =  x + y*kinect.width;
          // Grabbing the raw depth
          int rawDepth = depth[offset];
  
          // Testing against threshold
          if (rawDepth < threshold && count == 0) {
            topX = (1/widthReq)*x;
            
            count++;
          } else if (rawDepth >= threshold) {
            topX = -1;
            topY = -1;
            count = 0;
          } else {
            topX += (1/widthReq)*x;
            count ++;
          }
          
         if (count == widthReq) {
           topY = y;
           break;
         }
        }
      }
    }
    // As long as we found something
    if (topX >= 0) {
      toploc = new PVector(topX*wRatio, topY*hRatio);
    } else {
      toploc = new PVector(0,0);
    }
    
    return toploc;
  }
  
  void display() {
    PImage img = kinect.getDepthImage();
    //problems at y=480, x a little < 1300
    //println("w/d",display.width,windowWidth,display.height,windowHeight);
    int hOff = int((windowHeight-kinect.height)/2);
    int wOff = int((windowWidth-kinect.width)/2);
    float wRatio = float(windowWidth)/float(kinect.width);
    float hRatio = float(windowHeight)/float(kinect.height);
    //println(kinect.width,kinect.height,windowWidth,windowHeight,wRatio,hRatio);
    
    // Being overly cautious here
    //if (depth == null || img == null) return;

    // Going to rewrite the depth image to show which pixels are in threshold
    // A lot of this is redundant, but this is just for demonstration purposes
    loadPixels();
    //println(pixels.length);
    for (int x = 0; x < windowWidth; x++) {
      for (int y = 0; y < windowHeight; y++) {

        int offset = min(int(x/wRatio) + int(y/hRatio) * kinect.width,depth.length-1); //coordinate from kinect image
        //if (offset >=307200) {
        //  println(x,y);
        //}
        // Raw depth
        int rawDepth = depth[offset];
        int pix = x + y * windowWidth; //screen coordinates
        if (rawDepth < threshold) {
          // A red color instead
          pixels[pix] += color(150, 50, 50, 200);
        } else {
          pixels[pix] += color(img.pixels[offset],img.pixels[offset],img.pixels[offset],200); //
        }
      }
    }
    updatePixels();

    // Draw the image
    //image(display, 0, 0);
  }

  int getThreshold() {
    return threshold;
  }

  void setThreshold(int t) {
    threshold =  t;
  }
}

Table windSpeed;

int index = 0; // Main array loop variable
int secondaryindex = 1; // Persistency loop variable
float spin = 0; // Spin factor

// Value arrays
String[] timeStamps;
float[] windSpeedArray;

// Date, time parameters for data retrieval
// Entering inappropriate time will lead to crash
// After reaching end time, code will loop from beginning
String fromDate = "2021-08-24";  // Format: YYYY-MM-DD
String toDate = "2021-08-25";  // Format: YYYY-MM-DD

String startHour = "13";  // Value: 00-23
String endHour = "13";  // Value: 00-23

void setup(){
  // Load Wind Speed data from EIF portal in CSV format
  windSpeed = loadTable("https://eif-research.feit.uts.edu.au/api/csv/?rFromDate=" + fromDate + "T" + startHour + "%3A00%3A00&rToDate=" + toDate + "T" + endHour + "%3A00%3A00&rFamily=weather&rSensor=IWS", "csv");

  // Extract data from CSV
  windSpeedArray = new float[windSpeed.getRowCount()];
  timeStamps = new String[windSpeed.getRowCount()];
  
  for (int i = 0; i < windSpeed.getRowCount(); i++){
    timeStamps[i] = windSpeed.getString(i,0);
    windSpeedArray[i] = windSpeed.getFloat(i,1);
  }
  
  size(1100,700); 
  smooth(2);
}

void draw() {
  
  // Set sky background
  background(130,210,245);
  
  // Data display on top right corner
  fill(5,75,100);
  textSize(36);
  text("Time", 800, 100);
  textSize(24);
  text(timeStamps[index], 800, 125); // Display timestamp of current windspeed
  
  textSize(36);
  text("Wind Speed", 800, 175);
  textSize(24);
  text(windSpeedArray[index], 800, 200); // Display current windspeed
 
  // Sun in top left corner
  fill(250,218,70);
  noStroke();
  ellipse(100,120,80,80);
 
  // Desert layer 1 using curve vertices
  fill(234,223,159);
  beginShape();
    curveVertex(1140,  500);
    curveVertex(1140,  500);
    curveVertex(1080,  510);
    curveVertex(1040,  520);
    curveVertex(960, 480);
    curveVertex(925, 470);
    curveVertex(840, 475);
    curveVertex(750, 460);
    curveVertex(700, 460);
    curveVertex(620, 455);
    curveVertex(500, 460);
    curveVertex(400, 450);
    curveVertex(370, 460);
    curveVertex(350, 480);
    curveVertex(300, 535);
    curveVertex(275, 560);
    curveVertex(0, 700);
    curveVertex(1140, 720);
    curveVertex(1140, 400);
    curveVertex(1140,  450);
    curveVertex(1140,  450);
  endShape();
 
   // Desert layer 2 using curve vertices
   fill(227,209,108);
   beginShape();
    curveVertex(1140,  370);
    curveVertex(1140,  370);
    curveVertex(1080,  360);
    curveVertex(1040,  340);
    curveVertex(1000,  375);
    curveVertex(960, 400);
    curveVertex(925, 450);
    curveVertex(840, 480);
    curveVertex(750, 525);
    curveVertex(700, 580);
    curveVertex(620, 640);
    curveVertex(500, 665);
    curveVertex(400, 700);
    curveVertex(1140, 720);
    curveVertex(1140, 400);
    curveVertex(1140,  450);
    curveVertex(1140,  450);
   endShape();
 
   // Desert layer 3 using curve vertices
  fill(216,203,129);
  beginShape();
    curveVertex(-40,  300);
    curveVertex(-40,  300);
    curveVertex(10,  310);
    curveVertex(50,  325);
    curveVertex(100,  305);
    curveVertex(150, 350);
    curveVertex(250, 400);
    curveVertex(350, 450);
    curveVertex(400, 475);
    curveVertex(425, 510);
    curveVertex(475, 580);
    curveVertex(510, 630);
    curveVertex(550, 670);
    curveVertex(600, 710);
    curveVertex(-40, 705);
    curveVertex(-40, 500);
    curveVertex(-40, 320);
    curveVertex(-40, 300);
    curveVertex(-40, 300);
  endShape();


   // Windmill Pole 1 shape using vertices
   fill(240);
   beginShape();
    vertex(325,500);
    vertex(340,310);
    vertex(360,310);
    vertex(375,500);
    vertex(325,500);
   endShape();
   
   // Windmill Pole 2 shape using vertices
   beginShape();
    vertex(825,565);
    vertex(840,375);
    vertex(860,375);
    vertex(875,565);
    vertex(825,565);
   endShape();
 
 // Windmill Pole 3 shape using vertices
   beginShape();
    vertex(588,495);
    vertex(595,400);
    vertex(605,400);
    vertex(612,495);
    vertex(588,495);
   endShape();
 
 // Map wind speed to spin factor to display appropriately
 float mappedSpeed = map(windSpeedArray[index], 0, 25, 0.02, 0.12);
 spin = spin + mappedSpeed; // Spin factor updating

 // Rotating wings for 1st Windmill
  pushMatrix();
   translate(350, 310);
   rotate(spin);
   wing1(); // Draw shape using secondary function
  popMatrix();
  
  // Rotating wings for 2nd Windmill
  pushMatrix();
   translate(850, 375);
   rotate(spin);
   wing1(); // Draw shape using secondary function
  popMatrix();
  
  // Rotating wings for 3rd Windmill
   pushMatrix();
     translate(600, 400);
     rotate(spin);
     wing2(); // Draw shape using secondary function
   popMatrix();
   
   // Center pieces for Windmill wings
   fill(240);
   ellipse(350, 310, 20, 20);
   ellipse(850, 375, 20, 20);
   ellipse(600, 400, 10, 10);
   
   // Persistency loop to display data in a more user friendly way
  if(secondaryindex % 100 == 0){
    if(index<windSpeedArray.length-1){
       index = index + 1;
    }
    else{
       index = 0;
    }
  }
  secondaryindex = secondaryindex + 1;
}

// Function to create wing shape using vertices
// Function is used to create 2 big wings
void wing1(){
  fill(255);
  beginShape();
  
    // Wing blade 1
    vertex(-10,-10);
    vertex(-10,-90);
    vertex(30,-90);
    vertex(10,-10);
    
    // Wing blade 2
    vertex(90,-10);
    vertex(90,30);
    vertex(10,10);
    
    // Wing blade 3
    vertex(10,90);
    vertex(-30,90);
    vertex(-10,10);
    
    // Wing blade 4
    vertex(-90,10);
    vertex(-90,-30);
    vertex(-10,-10);
    
    endShape();
}

// Function to create wing shape using vertices
// Function is use to create 1 small wing
void wing2(){
  fill(255);
  beginShape();
  
    // Wing blade 1
    vertex(-5,-5);
    vertex(-5,-45);
    vertex(15,-45);
    vertex(5,-5);
    
    // Wing blade 2
    vertex(45,-5);
    vertex(45,15);
    vertex(5,5);
    
    // Wing blade 3
    vertex(5,45);
    vertex(-15,45);
    vertex(-5,5);
    
    // Wing blade 3
    vertex(-45,5);
    vertex(-45,-15);
    vertex(-5,-5);
    
    endShape();
}

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.net.*; 
import ddf.minim.analysis.*; 
import ddf.minim.*; 
import java.text.DecimalFormat; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class client extends PApplet {


Client client;

// for music//


Minim minim;
AudioPlayer music;
///////////////////

float total_bad_raw_data_counter=0;
float total_good_raw_data_counter=0;

float Ruan_focus_value;
Float Blur_value=20.0f;
float Real_Bandpower_DELTA;
float Real_Bandpower_THETA;

float Real_Bandpower_ALPHA;
float Real_Bandpower_BETA;
float Real_Bandpower_GAMMA;
float []Ruan_EMG=new float[8];
float level;   //level is for focus game. suggest to set it as 1.7.  low value is difficult. 
float real_level;   // this is real level. for matching EEG.
float seting_level=0;
float level_top=37;
float level_bottom=2;
float sizer= 50;
float change= 10;
PImage myImg;
PFont myfont;
int test_time=0;



float Matched_left_right_delta_value=0;
boolean first_testing=false;
//boolean Start_testing=false;

float []Matched_Ruan_EMG={0,0,0,0,0,0,0,0};  

float Matched_DELTA_Power=0;
float Matched_THETA_Power=0;
float Matched_ALPHA_Power=0;
float Matched_BETA_Power=0;
float Matched_GAMMA_Power=0;

float Matched_Peak_ALPHA_FFT_value_uV=0;
float Matched_Avg_ALPHA_Power_FFT_value_uV=0;

float Matched_Peak_BETA_FFT_value_uV=0;
float Matched_Avg_BETA_Power_FFT_value_uV=0;

float Matched_Peak_GAMMA_FFT_value_uV=0;
float Matched_Avg_GAMMA_Power_FFT_value_uV=0;

float Matched_Peak_THETA_FFT_value_uV=0;
float Matched_Avg_THETA_Power_FFT_value_uV=0;

float Matched_Peak_DELTA_FFT_value_uV=0;
float Matched_Avg_DELTA_Power_FFT_value_uV=0;


int study_EEG_times=1000; 
float BAD_EMG_Power_uV=20;  // will drop all RAW data which EMG>12uV.
float BAD_Band_Power_uV=25;   // will drop all RAW data which Band power>12uV.

/*// indexs
DELTA// 1-4 Hz
THETA// 4-8 Hz
ALPHA// 8-13 Hz
BETA// 13-30 Hz
GAMMA// 30-55 Hz*/

float DELTA_EEG_match_rate_Trigger=0.9f;
float THETA_EEG_match_rate_Trigger=0.9f;
float ALPHA_EEG_match_rate_Trigger=0.95f;  // >n% will open the locker.
float BETA_EEG_match_rate_Trigger=0.9f; 
float GAMMA_EEG_match_rate_Trigger=0.8f; 

float TOTAL_EEG_match_rate_Trigger=0.75f;


float EMG_match_rate_Trigger=0.5f;
float focus_trigger=1; ////Set *1.x  for easy testing. Set 0.x to increase the difficult.

int Network_delay_time=1;

    
        float Peak_ALPHA_FFT_value_uV=0;
        float Avg_ALPHA_Power_FFT_value_uV=0;

        float Peak_BETA_FFT_value_uV=0;
        float Avg_BETA_Power_FFT_value_uV=0;

        float Peak_GAMMA_FFT_value_uV=0;
        float Avg_GAMMA_Power_FFT_value_uV=0;

        float Peak_THETA_FFT_value_uV=0;
        float Avg_THETA_Power_FFT_value_uV=0;

        float Peak_DELTA_FFT_value_uV=0;
        float Avg_DELTA_Power_FFT_value_uV=0;
    int try_to_match_time=0;
    
    
    int normal_counter=0;
    int fine_counter=0;
    int nice_counter=0;
    int great_counter=0;
    int not_ok_counter=0;
    int tired_counter=0;
    int very_bad_counter=0;
    
    float total_counter=  very_bad_counter+not_ok_counter+tired_counter+normal_counter+fine_counter+nice_counter+great_counter;
   


public void setup(){

  client=new Client(this,"localhost", 5204);
  frameRate(30);
  
  background(0xffE2F0CB);
  load_random_iamges();
  
  ///draw_wave//
  
    for ( N = 0 ; N <= Nmax ; N++ ){
    
    X[N] = random(-3000,+3000) ;
    Y[N] = random(-3000,+3000) ;
    Z[N] = random(-3000,+3000) ;
  }
  
  //////////draw_wave_end//
  
/*  ///draw_wave_2//  
//    size(300,300);
//  background(0);
  smooth();

  sx = random(1.0);
  sy = random(1.0);

  angle = 0;
  speed = 0.01;
  radi = 100.0;
  xA = 10;   //draw start at xA.
  yA = height/2;
  xB = width-20;
  yB = height/2;

//////////draw_wave_2_end//*/
  
  
}




/*void clientEvent(Client client){

}*/

public void draw(){
    //load_random_iamges();

  
  if( first_testing==false)
    Do_EEG_Analysis();
  
  if(key!='m' && key!='M' && key!='t'&& key!='T'&&key!='p'&& key!='P'&& first_testing==true) // Draw "done".
    {
      Draw_Done();
      EEG_Key_Match_time=0;
      Avg_Mind_Score=0.0f;
      Result_Avg_Mind_Score=0;
       No_Zero_Avg_Mind_Score=0.0f;
      no_Zero_Result_Avg_Mind_Score=0;
      No_Zero_EEG_Key_Match_time=0;
      
      
     normal_counter=0;
     fine_counter=0;
     nice_counter=0;
     great_counter=0;
     not_ok_counter=0;
     tired_counter=0;
     very_bad_counter=0;
     
     
    total_bad_raw_data_counter=0;
    total_good_raw_data_counter=0;
      
      
    }

    
  if(key=='t' || key=='T'&& first_testing==true )
    Do_EEG_Analysis();
    
  if(key=='m' || key=='M'&& first_testing==true ){
     EEG_Key_Match();
    // key='q';
  }     
   if(key=='p'||key=='P'&& first_testing==true)
      {

        Read_from_Sever();
        Draw_photos();
      }

}


public void Do_EEG_Analysis(){
  
  /*minim = new Minim(this);
  music= minim.loadFile("music.mp3", 1024);
  music.loop();*/
 // test_now=true;
  
       if (first_testing == false)  // Do first test.
        {
            myImg=loadImage("photo-analysis.jpg");
            image(myImg,0,0,width,height);
           
            fill(255);
            myfont=createFont("Arial",32);
            textFont(myfont);
            text("Welcome to EEG/Computer interface system!\nSTEP ONE: ",width/2-350,80);

            fill(255);
            myfont=createFont("Arial",16);
            textFont(myfont);
            text("First, let me learn your EEG data, it will take several seconds. \n\nRelax your brain, and keep opening your eyes.  Are you ready? Press mouse to start!",width/2-350,height/2-125);
            Draw_Bottom_Index();
            if (mousePressed == true) {
              Analysis_your_EEG();
              first_testing=true;
              }
        }
   
    if (key == 't' || key == 'T') // Redo the test.
        {
            myImg=loadImage("photo-analysis.jpg");
            image(myImg,0,0,width,height);

            fill(255);
            myfont=createFont("Arial",16);
            textFont(myfont);
            text(" Let's analysis your EEG data again, it will take several seconds. \n\n Relax your brain, and keep opening your eyes.  Are you ready?\n \n Just press your mouse button to start analysis. Or press anyother keys to quite.",width/2-300,height/2-200);
            Draw_Bottom_Index();
            if (mousePressed == true) {
              Analysis_your_EEG();
              first_testing=true;
              }
        }
        
  // test_now=false;     
        
}



public void Analysis_your_EEG(){


  Matched_left_right_delta_value=0;
  level=0;  
  real_level=0;
  
Matched_DELTA_Power=0;
Matched_THETA_Power=0;
Matched_ALPHA_Power=0;
Matched_BETA_Power=0;
Matched_GAMMA_Power=0;

 Matched_Peak_ALPHA_FFT_value_uV=0;
 Matched_Avg_ALPHA_Power_FFT_value_uV=0;

 Matched_Peak_BETA_FFT_value_uV=0;
 Matched_Avg_BETA_Power_FFT_value_uV=0;

 Matched_Peak_GAMMA_FFT_value_uV=0;
 Matched_Avg_GAMMA_Power_FFT_value_uV=0;

 Matched_Peak_THETA_FFT_value_uV=0;
 Matched_Avg_THETA_Power_FFT_value_uV=0;

 Matched_Peak_DELTA_FFT_value_uV=0;
 Matched_Avg_DELTA_Power_FFT_value_uV=0;
 
 

//   Matched_Ruan_EMG[]={0,0,0,0,0,0,0,0};  
   for(int j=0;j<8;j=j+1){
        Matched_Ruan_EMG[j]=0;
      }
 
  for(int i=0;i<study_EEG_times;i=i+1)
   {    

      Read_from_Sever();

      delay(Network_delay_time); //Have to delay here, otherwise will read lots of Zero data from the server.

 
    if(Real_Bandpower_DELTA<BAD_Band_Power_uV&&Real_Bandpower_THETA<BAD_Band_Power_uV&&Real_Bandpower_ALPHA<BAD_Band_Power_uV&&Real_Bandpower_BETA<BAD_Band_Power_uV&&Real_Bandpower_GAMMA<BAD_Band_Power_uV&&Ruan_EMG[0]<BAD_EMG_Power_uV && Ruan_EMG[1]<BAD_EMG_Power_uV  && Ruan_EMG[2]<BAD_EMG_Power_uV && Ruan_EMG[3]<BAD_EMG_Power_uV && Ruan_EMG[4]<BAD_EMG_Power_uV && Ruan_EMG[5]<BAD_EMG_Power_uV && Ruan_EMG[6]<BAD_EMG_Power_uV && Ruan_EMG[7]<BAD_EMG_Power_uV)
        
        {
              println("("+i+"/"+study_EEG_times+")"+":Testing................................");
              Matched_left_right_delta_value=Matched_left_right_delta_value+(Ruan_EMG[0]+Ruan_EMG[2]+Ruan_EMG[4]+Ruan_EMG[6]-Ruan_EMG[1]-Ruan_EMG[3]-Ruan_EMG[5]-Ruan_EMG[7]);
              level=level+Ruan_focus_value*focus_trigger; //Set *1.x  for easy testing. Set 0.x to increase the difficult.
              
              real_level=real_level+Ruan_focus_value;
              
              Matched_DELTA_Power=Matched_DELTA_Power+Real_Bandpower_DELTA;
              Matched_THETA_Power=Matched_THETA_Power+Real_Bandpower_THETA;
              Matched_ALPHA_Power=Matched_ALPHA_Power+Real_Bandpower_ALPHA;
              Matched_BETA_Power=Matched_BETA_Power+Real_Bandpower_BETA;
              Matched_GAMMA_Power=Matched_GAMMA_Power+Real_Bandpower_GAMMA;
         
               Matched_Peak_ALPHA_FFT_value_uV=Matched_Peak_ALPHA_FFT_value_uV+Peak_ALPHA_FFT_value_uV;
               
               Matched_Avg_ALPHA_Power_FFT_value_uV=Matched_Avg_ALPHA_Power_FFT_value_uV+Avg_ALPHA_Power_FFT_value_uV;
              
               Matched_Peak_BETA_FFT_value_uV=Matched_Peak_BETA_FFT_value_uV+Peak_BETA_FFT_value_uV;
               
               Matched_Avg_BETA_Power_FFT_value_uV=Matched_Avg_BETA_Power_FFT_value_uV+Avg_BETA_Power_FFT_value_uV;
              
               Matched_Peak_GAMMA_FFT_value_uV=Matched_Peak_GAMMA_FFT_value_uV+Peak_GAMMA_FFT_value_uV;
               Matched_Avg_GAMMA_Power_FFT_value_uV=Matched_Avg_GAMMA_Power_FFT_value_uV+Avg_GAMMA_Power_FFT_value_uV;
              
               Matched_Peak_THETA_FFT_value_uV=Matched_Peak_THETA_FFT_value_uV+Peak_THETA_FFT_value_uV;
               Matched_Avg_THETA_Power_FFT_value_uV=Matched_Avg_THETA_Power_FFT_value_uV+Avg_THETA_Power_FFT_value_uV;
              
               Matched_Peak_DELTA_FFT_value_uV=Matched_Peak_DELTA_FFT_value_uV+Peak_DELTA_FFT_value_uV;
               Matched_Avg_DELTA_Power_FFT_value_uV=Matched_Avg_DELTA_Power_FFT_value_uV+Avg_DELTA_Power_FFT_value_uV;
        
        
              for(int j=0;j<8;j=j+1){
                Matched_Ruan_EMG[j]=Matched_Ruan_EMG[j]+Ruan_EMG[j];       
              }
              
          }
          else {
                i=i-1;
               println("Found bad RAW data.");

            }
                
    }
    
  
      
              Matched_left_right_delta_value=Matched_left_right_delta_value/study_EEG_times;
              
              level=level/study_EEG_times;
              real_level=real_level/study_EEG_times;
              Matched_DELTA_Power=Matched_DELTA_Power/study_EEG_times;
              Matched_THETA_Power=Matched_THETA_Power/study_EEG_times;
              Matched_ALPHA_Power=Matched_ALPHA_Power/study_EEG_times;
              Matched_BETA_Power=Matched_BETA_Power/study_EEG_times;
              Matched_GAMMA_Power=Matched_GAMMA_Power/study_EEG_times;
         
               Matched_Peak_ALPHA_FFT_value_uV=Matched_Peak_ALPHA_FFT_value_uV/study_EEG_times;
               Matched_Avg_ALPHA_Power_FFT_value_uV=Matched_Avg_ALPHA_Power_FFT_value_uV/study_EEG_times;
              
               Matched_Peak_BETA_FFT_value_uV=Matched_Peak_BETA_FFT_value_uV/study_EEG_times;
               
               Matched_Avg_BETA_Power_FFT_value_uV=Matched_Avg_BETA_Power_FFT_value_uV/study_EEG_times;
              
               Matched_Peak_GAMMA_FFT_value_uV=Matched_Peak_GAMMA_FFT_value_uV/study_EEG_times;
               Matched_Avg_GAMMA_Power_FFT_value_uV=Matched_Avg_GAMMA_Power_FFT_value_uV/study_EEG_times;
              
               Matched_Peak_THETA_FFT_value_uV=Matched_Peak_THETA_FFT_value_uV/study_EEG_times;
               Matched_Avg_THETA_Power_FFT_value_uV=Matched_Avg_THETA_Power_FFT_value_uV/study_EEG_times;
              
               Matched_Peak_DELTA_FFT_value_uV=Matched_Peak_DELTA_FFT_value_uV/study_EEG_times;
               Matched_Avg_DELTA_Power_FFT_value_uV=Matched_Avg_DELTA_Power_FFT_value_uV/study_EEG_times;
    
    

    for(int j=0;j<8;j=j+1){
        Matched_Ruan_EMG[j]=Matched_Ruan_EMG[j]/study_EEG_times;
      }  
      
    key='q';

    load_random_iamges();
    
   }
public void Draw_photos(){

//////////change photos.///////////////

//if(key == 'c' || key == 'C' ) 

if(mousePressed==true)
   {
    load_random_iamges();
     Blur_value=20.00f;
     //level=seting_level;
//     key='q';
   }
   

//////////////////////////////////////////
     //level=seting_level;

  if (Blur_value>=20.0f)
    Blur_value=20.00f;
   if (Blur_value<=0.0f)
    Blur_value=0.00f;
  if (Ruan_focus_value<=level)
    Blur_value=Blur_value-1;
  if (Ruan_focus_value>level)
    Blur_value=Blur_value+1;
    
    //image(myImg,800,0,width,height);
    image(myImg,0,0,width,height);
    filter(BLUR,Blur_value);
    fill(0,Blur_value*10);
    rect(0,0, width, height);

    Draw_Top_Index();  
    Draw_Bottom_Index();
    
}


public void load_random_iamges()
  
  {
   int image_index=PApplet.parseInt(random(1,16));//image_index=total images number+1.
   String string_images_index=image_index+"";
   myImg=loadImage("photo-"+string_images_index+".jpg");
  
  }


public void draw_left_right(){
      //////////draw left and right//////////.//////////
    ////Draw left///////
    float allow_left_right_gap=0.1f*Matched_left_right_delta_value;  //set 0.X for the buffer of left/right gap.
    
    if(allow_left_right_gap<=1)
      allow_left_right_gap=1;
    
    
    if((Ruan_EMG[0]+Ruan_EMG[2]+Ruan_EMG[4]+Ruan_EMG[6]-Matched_left_right_delta_value)-Ruan_EMG[1]-Ruan_EMG[3]-Ruan_EMG[5]-Ruan_EMG[7]>=allow_left_right_gap){
      fill(0xffFFD500);
      ellipse(60,40,50,50);
      fill(0);
      text("Left",50,45);
  }
    
    ////Draw Right///////
    if((Ruan_EMG[0]+Ruan_EMG[2]+Ruan_EMG[4]+Ruan_EMG[6]-Matched_left_right_delta_value)-Ruan_EMG[1]-Ruan_EMG[3]-Ruan_EMG[5]-Ruan_EMG[7]<=-allow_left_right_gap){
       fill(0xffFF0009);
      ellipse(width-60,40,60,60);
      fill(0);
      text("Right",width-72,45);
  }
    
    if (Ruan_EMG[0]+Ruan_EMG[2]+Ruan_EMG[4]+Ruan_EMG[6]-Matched_left_right_delta_value-Ruan_EMG[1]-Ruan_EMG[3]-Ruan_EMG[5]-Ruan_EMG[7]>-allow_left_right_gap && Ruan_EMG[0]+Ruan_EMG[2]+Ruan_EMG[4]+Ruan_EMG[6]-Matched_left_right_delta_value-Ruan_EMG[1]-Ruan_EMG[3]-Ruan_EMG[5]-Ruan_EMG[7]<allow_left_right_gap){
        fill(0xffFFD500);
        ellipse(60,40,50,50);
        fill(0);
        text("Left",50,45);
         fill(0xffFF0009);
        ellipse(width-60,40,60,60);
        fill(0);
        text("Right",width-72,45);
    }
    
    /////////draw left and right End////////////////////
}


public void Draw_Top_Index(){

   fill(0,80);
    rect(0,0, width, 100);
    
    fill(255);
    myfont=createFont("Arial",12);
    textFont(myfont);
            
    text("Your current focus level(0 is the best):"+(Ruan_focus_value),100,20);
    text("Your focuse trigger level is:"+(level),100,40);
    text("Your Matched Braine Left/Right  Gap="+Matched_left_right_delta_value,100,60 );
    text("Real time Left power (8 channels)="+(Ruan_EMG[0]+Ruan_EMG[2]+Ruan_EMG[4]+Ruan_EMG[6]),100,80);
    text("Real time Right power (8 channels)="+(Ruan_EMG[1]+Ruan_EMG[3]+Ruan_EMG[5]+Ruan_EMG[7]),350,80);
    text("Real time Left-Right delta power (8 channels)="+(Ruan_EMG[0]+Ruan_EMG[2]+Ruan_EMG[4]+Ruan_EMG[6]-(Ruan_EMG[1]+Ruan_EMG[3]+Ruan_EMG[5]+Ruan_EMG[7])),100,100);
    //text("Press key 'C' to change the photo.      "+"Press key 'T' to Re-Analysis your EEG. " +"Press key 'M' to match your EEG. ",100,100);
    draw_left_right();
}

public void Draw_Bottom_Index(){

    fill(0,80);
    rect(0,height-50, width, height);
    
    fill(255);
    myfont=createFont("Arial",12);
    textFont(myfont);
            
    text("key 'T' to Re-Analysis your EEG."+"   key 'M' to do matching your EEG.\n"+"(Press any key to quit.).", 100,height-30);
//    text("key 'M' to do matching your EEG.", 100,height-40);
//    text("key 'P' to do focusing photos.", 100,height-20);
  
}
public void Draw_Done(){

      fill(0xffFFCD00);
      myfont=createFont("Arial",24);
      textFont(myfont);
      text("Done! ",width/2-300,480);
      noFill();
      stroke(0xffFFCD00);
      strokeWeight(3);
      ellipse(width/2-270,473,80,80);
      line(width/2-270,473+40,width/2-270,473+80);
      line(width/2-250,473+60,width/2-270,473+80);
      line(width/2-290,473+60,width/2-270,473+80);
      noStroke();
}

public void Draw_Bad_Raw_data(){
  
   //fill(#FFF305);
   fill(255);
      myfont=createFont("Arial",12);
      textFont(myfont);
      //text("Bad EEG Data rate: "+ total_bad_raw_data_counter/total_raw_data_counter*100+"%", width-350,100);
      text("Bad EEG Data filter: ",width-350,30);
      text("(EMG>"+BAD_EMG_Power_uV+"uV && Band Power>"+BAD_Band_Power_uV+"uV) ",width-350,50);
      text("Total Bad EEG Data coun:" + PApplet.parseInt(total_bad_raw_data_counter), width-350,70); 
      text("Total Good EEG Data counter: "+ PApplet.parseInt(total_good_raw_data_counter), width-350,90);
      text("Bad Data rate: "+ (total_bad_raw_data_counter/(total_good_raw_data_counter+total_bad_raw_data_counter))*100+"%", width-350,110);
      noFill();

}      
 

int matched_times=0;
Float Avg_Mind_Score=0.0f;
int Result_Avg_Mind_Score=0;
Float No_Zero_Avg_Mind_Score=0.0f;
int no_Zero_Result_Avg_Mind_Score=0;

float Band_power_Allow_Gap=0.9f;
    
            /*DELTA// 1-4 Hz
            THETA// 4-8 Hz
            ALPHA// 8-13 Hz
            BETA// 13-30 Hz
            GAMMA// 30-55 Hz*/
int EEG_Key_Match_time=0;
int No_Zero_EEG_Key_Match_time=0;

public void EEG_Key_Match(){   
    int checking_EEG_times=500; 
    fill(0);
    rect(0,0,width,height);

    float  Avg_DELTA_Band_Power=0;
    float  Avg_THETA_Band_Power=0;    
    float  Avg_ALPHA_Band_Power=0;
    float  Avg_BETA_Band_Power=0;
    float  Avg_GAMMA_Band_Power=0;


   /* Matched_DELTA_Power=0.02;

    Matched_THETA_Power=0.5;
    Matched_ALPHA_Power=1.5;

    Matched_BETA_Power=0.3;

    Matched_GAMMA_Power=0.01;*/



    for(int i=0; i<checking_EEG_times; i++){
      Read_from_Sever();

      delay(Network_delay_time*0); //Have to delay here, otherwise will read lots of Zero data from the server.

    if(Real_Bandpower_DELTA<BAD_Band_Power_uV&&Real_Bandpower_THETA<BAD_Band_Power_uV&&Real_Bandpower_ALPHA<BAD_Band_Power_uV&&Real_Bandpower_BETA<BAD_Band_Power_uV&&Real_Bandpower_GAMMA<BAD_Band_Power_uV&&Ruan_EMG[0]<BAD_EMG_Power_uV && Ruan_EMG[1]<BAD_EMG_Power_uV  && Ruan_EMG[2]<BAD_EMG_Power_uV && Ruan_EMG[3]<BAD_EMG_Power_uV && Ruan_EMG[4]<BAD_EMG_Power_uV && Ruan_EMG[5]<BAD_EMG_Power_uV && Ruan_EMG[6]<BAD_EMG_Power_uV && Ruan_EMG[7]<BAD_EMG_Power_uV)
      {
           Avg_DELTA_Band_Power=Avg_DELTA_Band_Power+Real_Bandpower_DELTA;
           Avg_THETA_Band_Power=Avg_THETA_Band_Power+Real_Bandpower_THETA;
           Avg_ALPHA_Band_Power=Avg_ALPHA_Band_Power+Real_Bandpower_ALPHA;
           Avg_BETA_Band_Power=Avg_BETA_Band_Power+Real_Bandpower_BETA;
           Avg_GAMMA_Band_Power=Avg_GAMMA_Band_Power+Real_Bandpower_GAMMA;
           total_good_raw_data_counter++;
          }
         else {
              i=i-1;
             println("Found bad RAW data."+total_bad_raw_data_counter);
                            
              total_bad_raw_data_counter++;

          }

}
    
     Avg_DELTA_Band_Power=Avg_DELTA_Band_Power/checking_EEG_times;
     Avg_THETA_Band_Power=Avg_THETA_Band_Power/checking_EEG_times;
     Avg_ALPHA_Band_Power=Avg_ALPHA_Band_Power/checking_EEG_times;
     Avg_BETA_Band_Power=Avg_BETA_Band_Power/checking_EEG_times;
     Avg_GAMMA_Band_Power=Avg_GAMMA_Band_Power/checking_EEG_times;

            /*DELTA// 1-4 Hz
            THETA// 4-8 Hz
            ALPHA// 8-13 Hz
            BETA// 13-30 Hz
            GAMMA// 30-55 Hz*/
    float Total_Avg_Band_power=Avg_DELTA_Band_Power+Avg_THETA_Band_Power+Avg_ALPHA_Band_Power+Avg_BETA_Band_Power+Avg_GAMMA_Band_Power;
    float Total_Matched_Band_Power=Matched_DELTA_Power+Matched_THETA_Power+Matched_ALPHA_Power+Matched_BETA_Power+Matched_GAMMA_Power;
    float DELTA_rate=(Avg_DELTA_Band_Power/Total_Avg_Band_power)/(Matched_DELTA_Power/Total_Matched_Band_Power);        
    float THETA_rate=(Avg_THETA_Band_Power/Total_Avg_Band_power)/(Matched_THETA_Power/Total_Matched_Band_Power);
    float ALPHA_rate=(Avg_ALPHA_Band_Power/Total_Avg_Band_power)/(Matched_ALPHA_Power/Total_Matched_Band_Power);
    float BETA_rate=(Avg_BETA_Band_Power/Total_Avg_Band_power)/(Matched_BETA_Power/Total_Matched_Band_Power);
    float GAMMA_rate=(Avg_GAMMA_Band_Power/Total_Avg_Band_power)/(Matched_GAMMA_Power/Total_Matched_Band_Power);
    
    if (DELTA_rate>2)
        DELTA_rate=2;
    if (THETA_rate>2)
        THETA_rate=2;    
    if (ALPHA_rate>2)
        ALPHA_rate=2;
    if (BETA_rate>2)
        BETA_rate=2;        
    if (GAMMA_rate>2)
        GAMMA_rate=2;        
        
    fill(255);             
    myfont=createFont("Arial",13);
    textFont(myfont);
    text("DELTA(1~4HZ) record:"+Matched_DELTA_Power+"uv",500,150);
    myfont=createFont("Arial",18);
    textFont(myfont);
    fill(255);        
    text(Avg_DELTA_Band_Power+"uV",500,170); 
    fill(0,100*DELTA_rate,100+100*DELTA_rate);  
    rect(500,180,DELTA_rate*100,10,7);
    
    

    fill(255);             
    myfont=createFont("Arial",13);
    textFont(myfont);
    text("THETA(4~8HZ) record:"+Matched_THETA_Power+"uv",500,210);
    myfont=createFont("Arial",18);
    textFont(myfont);
    fill(255);        
    text(Avg_THETA_Band_Power+"uV",500,230); 
    fill(0,100*THETA_rate,100+100*THETA_rate); 
    rect(500,240,THETA_rate*100,10,7);
    
    
    
    fill(255);             
    myfont=createFont("Arial",13);
    textFont(myfont);
    text("ALPHA(8~13HZ) record:"+Matched_ALPHA_Power+"uv",500,270);
    myfont=createFont("Arial",18);
    textFont(myfont);
    fill(255);        
    text(Avg_ALPHA_Band_Power+"uV",500,290); 
    fill(0xffFF9A03);  
    rect(500,300,ALPHA_rate*100,10,7);
    
    fill(255);             
    myfont=createFont("Arial",13);
    textFont(myfont);
    text("BETA(13~30HZ) record:"+Matched_BETA_Power+"uv",500,330);
    myfont=createFont("Arial",18);
    textFont(myfont);
    fill(255);        
    text(Avg_BETA_Band_Power+"uV",500,350); 
    fill(200+100*BETA_rate,50*BETA_rate,0);   
    rect(500,360,BETA_rate*100,10,7);
    
    
    fill(255);             
    myfont=createFont("Arial",13);
    textFont(myfont);
    text("GAMMA(30~55HZ) record:"+Matched_GAMMA_Power+"uv" ,500,390);
    myfont=createFont("Arial",18);
    textFont(myfont);
    fill(255);        
    text(Avg_GAMMA_Band_Power+"uV",500,410); 
    fill(200+100*GAMMA_rate,50*GAMMA_rate,0);
    rect(500,420,GAMMA_rate*100,10,7);    
    
    
    float Current_Mind_Score=(GAMMA_rate*30+BETA_rate*20+ALPHA_rate*10-DELTA_rate*5-THETA_rate*2);

    

    
    Draw_Top_Index();
    Draw_Bottom_Index();

    

    Draw_Top_Index();
    Draw_Bottom_Index();
    
    EEG_Key_Match_time=EEG_Key_Match_time+1;
    No_Zero_EEG_Key_Match_time=No_Zero_EEG_Key_Match_time+1;
    


    
    Avg_Mind_Score=Avg_Mind_Score+Current_Mind_Score;
    
    Result_Avg_Mind_Score=PApplet.parseInt(Avg_Mind_Score/EEG_Key_Match_time);
    
    No_Zero_Avg_Mind_Score=No_Zero_Avg_Mind_Score+Current_Mind_Score;

    no_Zero_Result_Avg_Mind_Score=PApplet.parseInt(No_Zero_Avg_Mind_Score/No_Zero_EEG_Key_Match_time);
    
    
    //println(EEG_Key_Match_time);
    
    
    fill(255);
    myfont=createFont("Arial",20);
    textFont(myfont);     
    text("Real Time Mind Score: "+PApplet.parseInt(Current_Mind_Score),500,480);    

    fill(0xffFF6F00);
      myfont=createFont("Arial",20);
      textFont(myfont);     
      text("Current Avg Mind Score: "+Result_Avg_Mind_Score,500,520); 
      
    fill(0xffFF0015);
      myfont=createFont("Arial",20);
      textFont(myfont);     
      text("Total Mind Score: ",500,560); 

    fill(0xffFF0015);
      myfont=createFont("Arial",35);
      textFont(myfont);     
      text(no_Zero_Result_Avg_Mind_Score,670,563);
     
 /*   fill(255);
    myfont=createFont("Arial",16);
    textFont(myfont);     
    text("(Press any key to quit.)",500,560);*/
    
    
    
       
 if(EEG_Key_Match_time==100)  //or put 30 here.
    {

      EEG_Key_Match_time=0;
      Avg_Mind_Score=0.0f;
      Result_Avg_Mind_Score=0;
      
    }
    
   if(Result_Avg_Mind_Score<10)
      very_bad_counter++; 
      

   if(Result_Avg_Mind_Score>=20&&Result_Avg_Mind_Score<30)
      not_ok_counter++;  
            
   if(Result_Avg_Mind_Score>=10&&Result_Avg_Mind_Score<20)
      tired_counter++;      
    
     if(Result_Avg_Mind_Score>=30&&Result_Avg_Mind_Score<40)
      normal_counter++;      
      
   if(Result_Avg_Mind_Score>=40&&Result_Avg_Mind_Score<50)
      fine_counter++;  
      
   if(Result_Avg_Mind_Score>=50&&Result_Avg_Mind_Score<60)
      nice_counter++;        

   if(Result_Avg_Mind_Score>=60)
      great_counter++;    
  
    total_counter=  very_bad_counter+not_ok_counter+tired_counter+normal_counter+fine_counter+nice_counter+great_counter;
    
  //  println("total_counter="+total_counter);
    float [] counter_data={very_bad_counter/total_counter*360, not_ok_counter/total_counter*360, tired_counter/total_counter*360, normal_counter/total_counter*360, fine_counter/total_counter*360,nice_counter/total_counter*360,great_counter/total_counter*360};
   // float [] counter_data={ 30, 10, 45, 35, 60, 38, 75, 67 };
   /*if(Result_Avg_Mind_Score>=30&&Result_Avg_Mind_Score<40)
      myImg=loadImage("normal.jpg");      
      
   if(Result_Avg_Mind_Score>=40&&Result_Avg_Mind_Score<50)
      myImg=loadImage("fine.jpg");  
      
   if(Result_Avg_Mind_Score>=50&&Result_Avg_Mind_Score<60)
      myImg=loadImage("nice.jpg");        

   if(Result_Avg_Mind_Score>=60)
      myImg=loadImage("great.jpg");    

   if(Result_Avg_Mind_Score>=20&&Result_Avg_Mind_Score<30)
      myImg=loadImage("not_ok.jpg");   
      
   if(Result_Avg_Mind_Score>=10&&Result_Avg_Mind_Score<20)
      myImg=loadImage("tired.jpg");    

   if(Result_Avg_Mind_Score<10)
      myImg=loadImage("very_bad.jpg");  
      
   image(myImg,100,130,300,300);*/
   
   stroke(3);
   draw_wave_1();
   pieChart(270,counter_data);
   Draw_Bad_Raw_data();
   //draw_wave_2();
   stroke(0);


}   


public void pieChart(float diameter, float[] data) {
  smooth();
  float lastAngle = 0;
  stroke(0);
  for (int i = 0; i < data.length; i++) {
    float gray = map(i, 0, data.length, 50, 255);
    
    if(i==0)
      fill(0xffF5170F);
    if(i==1)
      fill(0xffFAB247);
    if(i==2)
      fill(0xffECF773);
    if(i==3)
      fill(0xff72F05A);
    if(i==4)
      fill(0xff73F7A7);
    if(i==5)
      fill(0xff73A4F7);
    if(i==6)
      fill(0xffB573F7);      

    arc(950, 270, diameter, diameter, lastAngle, lastAngle+radians(data[i]));
    lastAngle += radians(data[i]);
  }
  

    myfont=createFont("Arial",20);
    textFont(myfont);    
    fill(0xffF5170F);
    text("Very Bad: "+PApplet.parseInt(very_bad_counter/total_counter*100)+"%",830,460);
  
    fill(0xffFAB247);
    text("Not OK: "+ PApplet.parseInt(not_ok_counter/total_counter*100)+"%",980,460);
    
    fill(0xffECF773);
    text("Tired: "+ PApplet.parseInt(tired_counter/total_counter*100)+"%",830,490);
    
    fill(0xff72F05A);
    text("Normal: "+ PApplet.parseInt(normal_counter/total_counter*100)+"%",980,490);
    
    
    fill(0xff73F7A7);
    text("Fine: "+ PApplet.parseInt(fine_counter/total_counter*100)+"%",830,520);
    
    fill(0xff73A4F7);
    text("Nice: "+ PApplet.parseInt(nice_counter/total_counter*100)+"%",980,520);
    
    fill(0xffB573F7);
    text("Great: "+ PApplet.parseInt(great_counter/total_counter*100)+"%",830,550);
  
}
public void Read_from_Sever(){
  String read;

  read=client.readStringUntil('A');
  if (read!=null)
    Ruan_focus_value=Float.parseFloat(deleteCharString(read,'A')); 

  read=client.readStringUntil('A');
  if (read!=null)
    Real_Bandpower_DELTA=Float.parseFloat(deleteCharString(read,'A')); 

   
   
  read=client.readStringUntil('A');
  if (read!=null)
    Real_Bandpower_THETA=Float.parseFloat(deleteCharString(read,'A')); 

   
  read=client.readStringUntil('A');
  if (read!=null)
    Real_Bandpower_ALPHA=Float.parseFloat(deleteCharString(read,'A')); 
   
   
   read=client.readStringUntil('A');
  if (read!=null)
    Real_Bandpower_BETA=Float.parseFloat(deleteCharString(read,'A')); 
   
   
  read=client.readStringUntil('A');
  if (read!=null)
    Real_Bandpower_GAMMA=Float.parseFloat(deleteCharString(read,'A')); 
   
  read=client.readStringUntil('A');
  if (read!=null)
    Ruan_EMG[0]=Float.parseFloat(deleteCharString(read,'A')); 
   
  read=client.readStringUntil('A');
  if (read!=null)
    Ruan_EMG[1]=Float.parseFloat(deleteCharString(read,'A')); 
   
   read=client.readStringUntil('A');
  if (read!=null)
    Ruan_EMG[2]=Float.parseFloat(deleteCharString(read,'A')); 
 
   
   read=client.readStringUntil('A');
  if (read!=null)
    Ruan_EMG[3]=Float.parseFloat(deleteCharString(read,'A')); 
 
   
   
   read=client.readStringUntil('A');
  if (read!=null)
    Ruan_EMG[4]=Float.parseFloat(deleteCharString(read,'A')); 

   
     read=client.readStringUntil('A');
  if (read!=null)
    Ruan_EMG[5]=Float.parseFloat(deleteCharString(read,'A')); 

   
     read=client.readStringUntil('A');
  if (read!=null)
    Ruan_EMG[6]=Float.parseFloat(deleteCharString(read,'A')); 


     read=client.readStringUntil('A');
    if (read!=null)
    Ruan_EMG[7]=Float.parseFloat(deleteCharString(read,'A')); 
////////////////////////////////////////////////////////////////////

/*// indexs
DELTA// 1-4 Hz
THETA// 4-8 Hz
ALPHA// 8-13 Hz
BETA// 13-30 Hz
GAMMA// 30-55 Hz*/
    

     read=client.readStringUntil('A');
    if (read!=null)
    Avg_DELTA_Power_FFT_value_uV=Float.parseFloat(deleteCharString(read,'A'));    
    
    read=client.readStringUntil('A');
    if (read!=null)
    Avg_THETA_Power_FFT_value_uV=Float.parseFloat(deleteCharString(read,'A'));    
        
     read=client.readStringUntil('A');
    if (read!=null)
    Avg_ALPHA_Power_FFT_value_uV=Float.parseFloat(deleteCharString(read,'A')); 

     read=client.readStringUntil('A');
    if (read!=null)
    Avg_BETA_Power_FFT_value_uV=Float.parseFloat(deleteCharString(read,'A')); 
    
     read=client.readStringUntil('A');
    if (read!=null)
    Avg_GAMMA_Power_FFT_value_uV=Float.parseFloat(deleteCharString(read,'A')); 
    
 
     read=client.readStringUntil('A');
    if (read!=null)
    Peak_DELTA_FFT_value_uV=Float.parseFloat(deleteCharString(read,'A'));     
    
     read=client.readStringUntil('A');
    if (read!=null)
    Peak_THETA_FFT_value_uV=Float.parseFloat(deleteCharString(read,'A')); 
    
    
     read=client.readStringUntil('A');
    if (read!=null)
    Peak_ALPHA_FFT_value_uV=Float.parseFloat(deleteCharString(read,'A'));     
    
     read=client.readStringUntil('A');
    if (read!=null)
    Peak_BETA_FFT_value_uV=Float.parseFloat(deleteCharString(read,'A'));     
    
     read=client.readStringUntil('A');
    if (read!=null)
    Peak_GAMMA_FFT_value_uV=Float.parseFloat(deleteCharString(read,'A'));     
//////////////////////////////////////////////////////////////////////////////   
         
  /* println("Ruan_focus_value="+Ruan_focus_value);
   println("Real_Bandpower_DELTA="+Real_Bandpower_DELTA);
   println("Real_Bandpower_THETA="+Real_Bandpower_THETA);   
   println("Real_Bandpower_ALPHA="+Real_Bandpower_ALPHA);
   println("Real_Bandpower_ALPHA="+Real_Bandpower_ALPHA);
   println("Real_Bandpower_ALPHA="+Real_Bandpower_ALPHA);
   println("Real_Bandpower_BETA="+Real_Bandpower_BETA);
   println("Real_Bandpower_GAMMA="+Real_Bandpower_GAMMA);
   println("Ruan_EMG[0]="+Ruan_EMG[0]);
   println("Ruan_EMG[1]="+Ruan_EMG[1]);
   println("Ruan_EMG[2]="+Ruan_EMG[2]);
   println("Ruan_EMG[3]="+Ruan_EMG[3]);
   println("Ruan_EMG[4]="+Ruan_EMG[4]);
   println("Ruan_EMG[5]="+Ruan_EMG[5]);
   println("Ruan_EMG[6]="+Ruan_EMG[6]);
   println("Ruan_EMG[7]="+Ruan_EMG[7]);*/
   
}
   
public String deleteCharString(String sourceString, char chElemData) {
        String deleteString = "";
      
       for (int i = 0; i < sourceString.length(); i++) {
           if (sourceString.charAt(i) != chElemData) {
                deleteString += sourceString.charAt(i);
            }
      }
      return deleteString;
   }
   
//*draw wave////
  int Nmax = 500 ; //这个是球体的面数


float M = 50 ;//

float H = 0.95f ; float HH = 0.01f ;

float X[] = new float[Nmax+1] ; float Y[] = new float[Nmax+1] ; float Z[] = new float[Nmax+1] ;
float V[] = new float[Nmax+1] ; float dV[] = new float[Nmax+1] ; 
float L ; float R = 2*sqrt((4*PI*(200*200)/Nmax)/(2*sqrt(3))) ;
float Lmin ; int N ; int NN ; 
float KX ; float KY ; float KZ ; 
float KV ; float KdV ; int K ;



/////draw wave end/////

public void draw_wave_1(){  
 // background(0) ;
  float diameter=0.8f;
  int score=(100-(Result_Avg_Mind_Score)) ;
// score=50;
if(score<0)
  score=0;
if(score>100)
  score=100;
    
  
  for ( N = 0 ; N <= Nmax ; N++ ){
     for ( NN = N+1 ; NN <= Nmax ; NN++ ){
        L = sqrt(((X[N]-X[NN])*(X[N]-X[NN]))+((Y[N]-Y[NN])*(Y[N]-Y[NN]))) ;
        L = sqrt(((Z[N]-Z[NN])*(Z[N]-Z[NN]))+(L*L)) ;
        if ( L < R ){
          X[N] = X[N] - ((X[NN]-X[N])*((R-L)/(2*L))) ;
          Y[N] = Y[N] - ((Y[NN]-Y[N])*((R-L)/(2*L))) ;
          Z[N] = Z[N] - ((Z[NN]-Z[N])*((R-L)/(2*L))) ;
          X[NN] = X[NN] + ((X[NN]-X[N])*((R-L)/(2*L))) ;
          Y[NN] = Y[NN] + ((Y[NN]-Y[N])*((R-L)/(2*L))) ;
          Z[NN] = Z[NN] + ((Z[NN]-Z[N])*((R-L)/(2*L))) ;
          dV[N] = dV[N] + ((V[NN]-V[N])/M) ;
          dV[NN] = dV[NN] - ((V[NN]-V[N])/M) ;
          //stroke(125+(Z[N]/2),125+(Z[N]/2),125+(Z[N]/2)) ; 
          stroke(255-Result_Avg_Mind_Score*2.55f,Result_Avg_Mind_Score*2.55f,0,125+(Z[N]/2));
          
         //  line(X[N]*1.2*(200+V[N])/200+300,Y[N]*1.2*(200+V[N])/200+300,X[NN]*1.2*(200+V[NN])/200+300,Y[NN]*1.2*(200+V[NN])/200+300);   
         
         line(X[N]*diameter*(200+V[N])/200+230,Y[N]*diameter*(200+V[N])/200+320,X[NN]*diameter*(200+V[NN])/200+230,Y[NN]*diameter*(200+V[NN])/200+320);   //(*diameter 这个控制球的直径 ，+300这是调整球体的位置。
        }
        if ( Z[N] > Z[NN] ){
          KX = X[N] ; KY = Y[N] ; KZ = Z[N] ; KV = V[N] ; KdV = dV[N] ; 
          X[N] = X[NN] ; Y[N] = Y[NN] ; Z[N] = Z[NN] ; V[N] = V[NN] ; dV[N] = dV[NN] ;  
          X[NN] = KX ; Y[NN] = KY ; Z[NN] = KZ ; V[NN] = KV ; dV[NN] = KdV ; 
        }
     }
     L = sqrt((X[N]*X[N])+(Y[N]*Y[N])) ;
     L = sqrt((Z[N]*Z[N])+(L*L)) ;
     X[N] = X[N] + (X[N]*(200-L)/(2*L)) ;
     Y[N] = Y[N] + (Y[N]*(200-L)/(2*L)) ;
     Z[N] = Z[N] + (Z[N]*(200-L)/(2*L)) ;
     KZ = Z[N] ; KX = X[N] ;
     
      Z[N] = (KZ*cos(PApplet.parseFloat(300-mouseX)/10000))-(KX*sin(PApplet.parseFloat(300-mouseX)/10000)) ;
     X[N] = (KZ*sin(PApplet.parseFloat(300-mouseX)/10000))+(KX*cos(PApplet.parseFloat(300-mouseX)/10000)) ;
     KZ = Z[N] ; KY = Y[N] ;
     Z[N] = (KZ*cos(PApplet.parseFloat(300-mouseY)/10000))-(KY*sin(PApplet.parseFloat(300-mouseY)/10000)) ;
     Y[N] = (KZ*sin(PApplet.parseFloat(300-mouseY)/10000))+(KY*cos(PApplet.parseFloat(300-mouseY)/10000)) ;
          
     dV[N] = dV[N] - (V[N]*HH) ;
//     println(dV[N]);
     V[N] = V[N] + dV[N] ; dV[N] = dV[N] * H ;
  }
  
    Lmin = 500 ; NN = 0 ;
  for ( N = 0 ; N <= Nmax ; N=N+1 ){
     L = 1*sqrt(((0-(100+X[N]))*(0-(100+X[N])))+((0-(100+Y[N]))*(0-(100+Y[N])))) ;  //100+ 这个也是调整突峰的强度.
 //    if(L>35)
 //      L=35;
     if ( Z[N] > 0 && L < Lmin ){ NN = N ; Lmin = L ; }
  }
  if ( K == 0 ){ dV[NN] = -score*1.3f ; K = 1 ; }  // dV[NN]=xxx，这是突峰的强度
           else{ dV[NN] = +score*1.3f ; K = 0 ; }  // dV[NN]=xxx，这是突峰的强度
}
// Forked from Lali Barriere (openprocessing user 1075). Not my original work.

float  xA, yA, xB, yB, x1,y1,x2,y2;

float sx, sy;

float angle;
float speed;
float radi;

float c,s;

public void draw_wave_2() {
  
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

public void neteja() {
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
  public void settings() {  size (1200,600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "client" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}

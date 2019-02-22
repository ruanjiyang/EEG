import processing.net.*;
Client client;

// for music//
import ddf.minim.analysis.*;
import ddf.minim.*;
Minim minim;
AudioPlayer music;
///////////////////

float total_bad_raw_data_counter=0;
float total_good_raw_data_counter=0;

float Ruan_focus_value;
Float Blur_value=20.0;
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

float DELTA_EEG_match_rate_Trigger=0.9;
float THETA_EEG_match_rate_Trigger=0.9;
float ALPHA_EEG_match_rate_Trigger=0.95;  // >n% will open the locker.
float BETA_EEG_match_rate_Trigger=0.9; 
float GAMMA_EEG_match_rate_Trigger=0.8; 

float TOTAL_EEG_match_rate_Trigger=0.75;


float EMG_match_rate_Trigger=0.5;
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
   


void setup(){

  client=new Client(this,"localhost", 5204);
  frameRate(30);
  size (1200,600);
  background(#E2F0CB);
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

void draw(){
    //load_random_iamges();

  
  if( first_testing==false)
    Do_EEG_Analysis();
  
  if(key!='m' && key!='M' && key!='t'&& key!='T'&&key!='p'&& key!='P'&& first_testing==true) // Draw "done".
    {
      Draw_Done();
      EEG_Key_Match_time=0;
      Avg_Mind_Score=0.0;
      Result_Avg_Mind_Score=0;
       No_Zero_Avg_Mind_Score=0.0;
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

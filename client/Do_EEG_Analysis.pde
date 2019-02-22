 //<>//

void Do_EEG_Analysis(){
  
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
         //<>//
}



void Analysis_your_EEG(){


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
 //<>//
      delay(Network_delay_time); //Have to delay here, otherwise will read lots of Zero data from the server.
 //<>//
 
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

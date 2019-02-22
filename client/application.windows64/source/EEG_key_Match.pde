import  java.text.DecimalFormat; 

int matched_times=0;
Float Avg_Mind_Score=0.0;
int Result_Avg_Mind_Score=0;
Float No_Zero_Avg_Mind_Score=0.0;
int no_Zero_Result_Avg_Mind_Score=0;

float Band_power_Allow_Gap=0.9;
    
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
    fill(#FF9A03);  
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
    
    Result_Avg_Mind_Score=int(Avg_Mind_Score/EEG_Key_Match_time);
    
    No_Zero_Avg_Mind_Score=No_Zero_Avg_Mind_Score+Current_Mind_Score;

    no_Zero_Result_Avg_Mind_Score=int(No_Zero_Avg_Mind_Score/No_Zero_EEG_Key_Match_time);
    
    
    //println(EEG_Key_Match_time);
    
    
    fill(255);
    myfont=createFont("Arial",20);
    textFont(myfont);     
    text("Real Time Mind Score: "+int(Current_Mind_Score),500,480);    

    fill(#FF6F00);
      myfont=createFont("Arial",20);
      textFont(myfont);     
      text("Current Avg Mind Score: "+Result_Avg_Mind_Score,500,520); 
      
    fill(#FF0015);
      myfont=createFont("Arial",20);
      textFont(myfont);     
      text("Total Mind Score: ",500,560); 

    fill(#FF0015);
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
      Avg_Mind_Score=0.0;
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


void pieChart(float diameter, float[] data) {
  smooth();
  float lastAngle = 0;
  stroke(0);
  for (int i = 0; i < data.length; i++) {
    float gray = map(i, 0, data.length, 50, 255);
    
    if(i==0)
      fill(#F5170F);
    if(i==1)
      fill(#FAB247);
    if(i==2)
      fill(#ECF773);
    if(i==3)
      fill(#72F05A);
    if(i==4)
      fill(#73F7A7);
    if(i==5)
      fill(#73A4F7);
    if(i==6)
      fill(#B573F7);      

    arc(950, 270, diameter, diameter, lastAngle, lastAngle+radians(data[i]));
    lastAngle += radians(data[i]);
  }
  

    myfont=createFont("Arial",20);
    textFont(myfont);    
    fill(#F5170F);
    text("Very Bad: "+int(very_bad_counter/total_counter*100)+"%",830,460);
  
    fill(#FAB247);
    text("Not OK: "+ int(not_ok_counter/total_counter*100)+"%",980,460);
    
    fill(#ECF773);
    text("Tired: "+ int(tired_counter/total_counter*100)+"%",830,490);
    
    fill(#72F05A);
    text("Normal: "+ int(normal_counter/total_counter*100)+"%",980,490);
    
    
    fill(#73F7A7);
    text("Fine: "+ int(fine_counter/total_counter*100)+"%",830,520);
    
    fill(#73A4F7);
    text("Nice: "+ int(nice_counter/total_counter*100)+"%",980,520);
    
    fill(#B573F7);
    text("Great: "+ int(great_counter/total_counter*100)+"%",830,550);
  
}

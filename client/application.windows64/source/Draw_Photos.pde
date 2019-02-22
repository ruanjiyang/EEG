void Draw_photos(){

//////////change photos.///////////////

//if(key == 'c' || key == 'C' ) 

if(mousePressed==true)
   {
    load_random_iamges();
     Blur_value=20.00;
     //level=seting_level;
//     key='q';
   }
   

//////////////////////////////////////////
     //level=seting_level;

  if (Blur_value>=20.0)
    Blur_value=20.00;
   if (Blur_value<=0.0)
    Blur_value=0.00;
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


void load_random_iamges()
  
  {
   int image_index=int(random(1,16));//image_index=total images number+1.
   String string_images_index=image_index+"";
   myImg=loadImage("photo-"+string_images_index+".jpg");
  
  }


void draw_left_right(){
      //////////draw left and right//////////.//////////
    ////Draw left///////
    float allow_left_right_gap=0.1*Matched_left_right_delta_value;  //set 0.X for the buffer of left/right gap.
    
    if(allow_left_right_gap<=1)
      allow_left_right_gap=1;
    
    
    if((Ruan_EMG[0]+Ruan_EMG[2]+Ruan_EMG[4]+Ruan_EMG[6]-Matched_left_right_delta_value)-Ruan_EMG[1]-Ruan_EMG[3]-Ruan_EMG[5]-Ruan_EMG[7]>=allow_left_right_gap){
      fill(#FFD500);
      ellipse(60,40,50,50);
      fill(0);
      text("Left",50,45);
  }
    
    ////Draw Right///////
    if((Ruan_EMG[0]+Ruan_EMG[2]+Ruan_EMG[4]+Ruan_EMG[6]-Matched_left_right_delta_value)-Ruan_EMG[1]-Ruan_EMG[3]-Ruan_EMG[5]-Ruan_EMG[7]<=-allow_left_right_gap){
       fill(#FF0009);
      ellipse(width-60,40,60,60);
      fill(0);
      text("Right",width-72,45);
  }
    
    if (Ruan_EMG[0]+Ruan_EMG[2]+Ruan_EMG[4]+Ruan_EMG[6]-Matched_left_right_delta_value-Ruan_EMG[1]-Ruan_EMG[3]-Ruan_EMG[5]-Ruan_EMG[7]>-allow_left_right_gap && Ruan_EMG[0]+Ruan_EMG[2]+Ruan_EMG[4]+Ruan_EMG[6]-Matched_left_right_delta_value-Ruan_EMG[1]-Ruan_EMG[3]-Ruan_EMG[5]-Ruan_EMG[7]<allow_left_right_gap){
        fill(#FFD500);
        ellipse(60,40,50,50);
        fill(0);
        text("Left",50,45);
         fill(#FF0009);
        ellipse(width-60,40,60,60);
        fill(0);
        text("Right",width-72,45);
    }
    
    /////////draw left and right End////////////////////
}


void Draw_Top_Index(){

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

void Draw_Bottom_Index(){

    fill(0,80);
    rect(0,height-50, width, height);
    
    fill(255);
    myfont=createFont("Arial",12);
    textFont(myfont);
            
    text("key 'T' to Re-Analysis your EEG."+"   key 'M' to do matching your EEG.\n"+"(Press any key to quit.).", 100,height-30);
//    text("key 'M' to do matching your EEG.", 100,height-40);
//    text("key 'P' to do focusing photos.", 100,height-20);
  
}
void Draw_Done(){

      fill(#FFCD00);
      myfont=createFont("Arial",24);
      textFont(myfont);
      text("Done! ",width/2-300,480);
      noFill();
      stroke(#FFCD00);
      strokeWeight(3);
      ellipse(width/2-270,473,80,80);
      line(width/2-270,473+40,width/2-270,473+80);
      line(width/2-250,473+60,width/2-270,473+80);
      line(width/2-290,473+60,width/2-270,473+80);
      noStroke();
}

void Draw_Bad_Raw_data(){
  
   //fill(#FFF305);
   fill(255);
      myfont=createFont("Arial",12);
      textFont(myfont);
      //text("Bad EEG Data rate: "+ total_bad_raw_data_counter/total_raw_data_counter*100+"%", width-350,100);
      text("Bad EEG Data filter: ",width-350,30);
      text("(EMG>"+BAD_EMG_Power_uV+"uV && Band Power>"+BAD_Band_Power_uV+"uV) ",width-350,50);
      text("Total Bad EEG Data coun:" + int(total_bad_raw_data_counter), width-350,70); 
      text("Total Good EEG Data counter: "+ int(total_good_raw_data_counter), width-350,90);
      text("Bad Data rate: "+ (total_bad_raw_data_counter/(total_good_raw_data_counter+total_bad_raw_data_counter))*100+"%", width-350,110);
      noFill();

}      



class W_template extends Widget {

  //to see all core variables/methods of the Widget class, refer to Widget.pde
  //put your custom variables here...
  Button widgetTemplateButton;

  W_template(PApplet _parent){
    super(_parent); //calls the parent CONSTRUCTOR method of Widget (DON'T REMOVE)

    //Ruan: This is the protocol for setting up dropdowns.
    //Note that these 3 dropdowns correspond to the 3 global functions below
    //You just need to make sure the "id" (the 1st String) has the same name as the corresponding function
    //addDropdown("Dropdown1", "Drop 1", Arrays.asList("A", "B"), 0);
    //addDropdown("Dropdown2", "Drop 2", Arrays.asList("C", "D", "E"), 1);
    //addDropdown("Dropdown3", "Drop 3", Arrays.asList("F", "G", "H", "I"), 3);

    //widgetTemplateButton = new Button (x + w/2*0, y + 50*0, 200, navHeight, "My value list", 12);
    widgetTemplateButton = new Button (x , y , 0, navHeight, "", 0); /// Ruan for hide button.
    //widgetTemplateButton.setFont(p4, 14);
    //widgetTemplateButton.setURL("http://docs.openbci.com/Tutorials/15-Custom_Widgets");
  }

  void update(){
    super.update(); //calls the parent update() method of Widget (DON'T REMOVE)

    //put your code here...

  }

  void draw(){
    super.draw(); //calls the parent draw() method of Widget (DON'T REMOVE)

    //put your code here... //remember to refer to x,y,w,h which are the positioning variables of the Widget class
    pushStyle();

//    widgetTemplateButton.draw(); // By Ruan

    popStyle();
    
    
/////////////////read FFT data by Ruan//////////////////////

/*// indexs
DELTA// 1-4 Hz
THETA// 4-8 Hz
ALPHA// 8-13 Hz
BETA// 13-30 Hz
GAMMA// 30-55 Hz*/
    
        float FFT_freq_Hz;
        float FFT_value_uV;

        float Peak_ALPHA_FFT_value_uV=0;
        float Avg_ALPHA_FFT_value_uV=0;
        int   ALPHA_FFT_counter=0;


        float Peak_BETA_FFT_value_uV=0;
        float Avg_BETA_FFT_value_uV=0;
        int   BETA_FFT_counter=0;

        float Peak_GAMMA_FFT_value_uV=0;
        float Avg_GAMMA_FFT_value_uV=0;
        int   GAMMA_FFT_counter=0;

        float Peak_THETA_FFT_value_uV=0;
        float Avg_THETA_FFT_value_uV=0;
        int   THETA_FFT_counter=0;

        float Peak_DELTA_FFT_value_uV=0;
        float Avg_DELTA_FFT_value_uV=0;
        int   DELTA_FFT_counter=0;

        
      for (int Ichan=0; Ichan < nchan; Ichan++){   // Ruan: Consider all 8 channels.
      
          for (int Ibin=0; Ibin < fftBuff[Ichan].specSize(); Ibin++) {
                FFT_freq_Hz = fftBuff[Ichan].indexToFreq(Ibin);
                FFT_value_uV = fftBuff[Ichan].getBand(Ibin);
                
                if(FFT_freq_Hz>8 && FFT_freq_Hz<=13)  // ALPHA
                {
                  Avg_ALPHA_FFT_value_uV=Avg_ALPHA_FFT_value_uV+FFT_value_uV;
                  ALPHA_FFT_counter++;
                  //println("!!!!!!!!!!!!!!!!!!!!!!!!!!!ALPHA_FFT_value_uV"+FFT_value_uV);
                 // println("ALPHA_FFT_counter"+ALPHA_FFT_counter);
                  if(Peak_ALPHA_FFT_value_uV<=FFT_value_uV)
                        Peak_ALPHA_FFT_value_uV=FFT_value_uV;                 
                }
                
                if(FFT_freq_Hz>13 && FFT_freq_Hz<=30)  // BETA
                {
                  Avg_BETA_FFT_value_uV=Avg_BETA_FFT_value_uV+FFT_value_uV;
                  BETA_FFT_counter++;
                  //println("Avg_BETA_FFT_value_uV"+Avg_BETA_FFT_value_uV);
                  //println("BETA_FFT_counter"+BETA_FFT_counter);
                  if(Peak_BETA_FFT_value_uV<=FFT_value_uV)
                        Peak_BETA_FFT_value_uV=FFT_value_uV;                 
                }
                
                if(FFT_freq_Hz>30 && FFT_freq_Hz<=55)  // GAMMA
                {
                  Avg_GAMMA_FFT_value_uV=Avg_GAMMA_FFT_value_uV+FFT_value_uV;
                  GAMMA_FFT_counter++;
                  //println("Avg_GAMMA_FFT_value_uV"+Avg_GAMMA_FFT_value_uV);
                 // println("GAMMA_FFT_counter"+GAMMA_FFT_counter);
                  if(Peak_GAMMA_FFT_value_uV<=FFT_value_uV)
                        Peak_GAMMA_FFT_value_uV=FFT_value_uV;                 
                }     
                
                if(FFT_freq_Hz>1 && FFT_freq_Hz<=4)  // DELTA
                {
                  Avg_DELTA_FFT_value_uV=Avg_DELTA_FFT_value_uV+FFT_value_uV;
                  DELTA_FFT_counter++;
                 // println("Avg_DELTA_FFT_value_uV"+Avg_DELTA_FFT_value_uV);
                 // println("DELTA_FFT_counter"+DELTA_FFT_counter);
                  if(Peak_DELTA_FFT_value_uV<=FFT_value_uV)
                        Peak_DELTA_FFT_value_uV=FFT_value_uV;                 
                }
                
                if(FFT_freq_Hz>4 && FFT_freq_Hz<=8)  // THETA
                {
                  Avg_THETA_FFT_value_uV=Avg_THETA_FFT_value_uV+FFT_value_uV;
                  THETA_FFT_counter++;
                 // println("Avg_THETA_FFT_value_uV"+Avg_THETA_FFT_value_uV);
                 // println("THETA_FFT_counter"+THETA_FFT_counter);
                  if(Peak_THETA_FFT_value_uV<=FFT_value_uV)
                        Peak_THETA_FFT_value_uV=FFT_value_uV;                 
                }  
          }
      }



      Avg_ALPHA_FFT_value_uV=Avg_ALPHA_FFT_value_uV/ALPHA_FFT_counter;
      Avg_BETA_FFT_value_uV=Avg_BETA_FFT_value_uV/BETA_FFT_counter;
      Avg_GAMMA_FFT_value_uV=Avg_GAMMA_FFT_value_uV/GAMMA_FFT_counter;
      Avg_DELTA_FFT_value_uV=Avg_DELTA_FFT_value_uV/DELTA_FFT_counter;
      Avg_THETA_FFT_value_uV=Avg_THETA_FFT_value_uV/THETA_FFT_counter;      
      
     // println("!!!!!!!!!!!!!!!!!!!!!!Peak_ALPHA_FFT_value_uV"+Peak_ALPHA_FFT_value_uV);

      
///////////////////read FFT data by Ruan End///////////////////////
      
      
/////////////////////////Ruan code///////////////////////
      int Width;int Height;
      stroke(5);
      fill(80);
      //ellipse(x,y,60*Ruan_focus_value,60*Ruan_focus_value);  //ruan
      text("You_is_focused: "+Ruan_is_focused, x+20, y + 20);
      text("Your_focus_value:" +Ruan_focus_value, x+w/2+20, y + 20);
      text("Your_Bandpower_DELTA:"+Ruan_Bandpower_DELTA,x+20,y+20*2);
      text("Your_Bandpower_THETA:"+Ruan_Bandpower_THETA,x+w/2+20,y+20*2);
      text("Your_Bandpower_ALPHA:"+Ruan_Bandpower_ALPHA,x+20,y+20*3);
      text("Your_Bandpower_BETA:"+Ruan_Bandpower_BETA,x+w/2+20,y+20*3);
      text("Your_Bandpower_GAMMA:"+Ruan_Bandpower_GAMMA,x+20,y+20*4);
      for(int i=0;i<=7;i++){
/*        if((i+1)%2==0){
          Width=w/2;Height=20*(4+i);}
          else{
            Width=0; Height=20*(4+i+1);}*/
       text("Your_EMG["+(i+1)+"]:"+Ruan_EMG[i],x+20,y+20*(4+1+i));   
       // text("Your_EMG["+(i+1)+"]:"+Ruan_EMG[i],x+20+Width,y+Height);
      }
      /*// indexs
      DELTA// 1-4 Hz
      THETA// 4-8 Hz
      ALPHA// 8-13 Hz
      BETA// 13-30 Hz
      GAMMA// 30-55 Hz*/
       text("FFT(uV):Avg_DELTA="+Avg_DELTA_FFT_value_uV+"  Peak_DELTA="+Peak_DELTA_FFT_value_uV,x+w/2-100,y+20*5);    
       text("FFT(uV):Avg_THETA="+Avg_THETA_FFT_value_uV+"  Peak_THETA="+Peak_THETA_FFT_value_uV,x+w/2-100,y+20*6);  
       text("FFT(uV):Avg_ALPHA="+Avg_ALPHA_FFT_value_uV+"  Peak_ALPHA="+Peak_ALPHA_FFT_value_uV,x+w/2-100,y+20*7);          //<>//
       text("FFT(uV):Avg_BETA="+Avg_BETA_FFT_value_uV+"  Peak_BETA="+Peak_BETA_FFT_value_uV,x+w/2-100,y+20*8);  
       text("FFT(uV):Avg_GAMMA="+Avg_GAMMA_FFT_value_uV+"  Peak_GAMMA="+Peak_GAMMA_FFT_value_uV,x+w/2-100,y+20*9);  
       
       
        // Ruan_server.write(Ruan_is_focused+"A"+Ruan_focus_value+"A"+Ruan_Bandpower_DELTA+"A"+Ruan_Bandpower_THETA+"A"+Ruan_Bandpower_ALPHA+"A"+Ruan_Bandpower_BETA+"A"+Ruan_Bandpower_GAMMA+"A"+Ruan_EMG[0]+"A"+Ruan_EMG[1]+"A"+Ruan_EMG[2]+"A"+Ruan_EMG[3]+"A"+Ruan_EMG[4]+"A"+Ruan_EMG[5]+"A"+Ruan_EMG[6]+"A"+Ruan_EMG[7]+"A");
        if(frameCount%1==0)//Set Time slot for sending data.
        {
           int EMG_Top_level=10;  //  set up cut level for EMG and Peak Band
           int Band_Peak_level=25; //  set up cut level for EMG and Peak Band
           if(Ruan_EMG[0]!=0&&Ruan_EMG[0]<EMG_Top_level&&Ruan_EMG[1]<EMG_Top_level&&Ruan_EMG[2]<EMG_Top_level&&Ruan_EMG[3]<EMG_Top_level&&Ruan_EMG[4]<EMG_Top_level&&Ruan_EMG[5]<EMG_Top_level&&Ruan_EMG[6]<EMG_Top_level&&Ruan_EMG[7]<EMG_Top_level&&Peak_DELTA_FFT_value_uV<Band_Peak_level&&Peak_THETA_FFT_value_uV<Band_Peak_level&&Peak_ALPHA_FFT_value_uV<Band_Peak_level&&Peak_BETA_FFT_value_uV<Band_Peak_level&&Peak_GAMMA_FFT_value_uV<Band_Peak_level)//set up level=15uv
           {
             Ruan_server.write(Ruan_focus_value+"A"+Ruan_Bandpower_DELTA+"A"+Ruan_Bandpower_THETA+"A"+Ruan_Bandpower_ALPHA+"A"+Ruan_Bandpower_BETA+"A"+Ruan_Bandpower_GAMMA+"A"+Ruan_EMG[0]+"A"+Ruan_EMG[1]+"A"+Ruan_EMG[2]+"A"+Ruan_EMG[3]+"A"+Ruan_EMG[4]+"A"+Ruan_EMG[5]+"A"+Ruan_EMG[6]+"A"+Ruan_EMG[7]+"A"+Avg_DELTA_FFT_value_uV+"A"+Avg_THETA_FFT_value_uV+"A"+Avg_ALPHA_FFT_value_uV+"A"+Avg_BETA_FFT_value_uV+"A"+Avg_GAMMA_FFT_value_uV+"A"+Peak_DELTA_FFT_value_uV+"A"+Peak_THETA_FFT_value_uV+"A"+Peak_ALPHA_FFT_value_uV+"A"+Peak_BETA_FFT_value_uV+"A"+Peak_GAMMA_FFT_value_uV+"A");
             Ruan_focus_value=0;
             Ruan_Bandpower_DELTA=0;
             Ruan_Bandpower_THETA=0;
             Ruan_Bandpower_ALPHA=0;
             Ruan_Bandpower_BETA=0;
             Ruan_Bandpower_GAMMA=0;
             Ruan_EMG[0]=0;
             Ruan_EMG[1]=0;
             Ruan_EMG[2]=0;
             Ruan_EMG[3]=0;
             Ruan_EMG[4]=0;
             Ruan_EMG[5]=0;
             Ruan_EMG[6]=0;
             Ruan_EMG[7]=0;
           }
         }
         
////////////////////Ruan Code End/////////////         

  }

  void screenResized(){
    super.screenResized(); //calls the parent screenResized() method of Widget (DON'T REMOVE)

    //put your code here...
    widgetTemplateButton.setPos(x + w/2 - widgetTemplateButton.but_dx/2, y + h/2 - widgetTemplateButton.but_dy/2);


  }

  void mousePressed(){
    super.mousePressed(); //calls the parent mousePressed() method of Widget (DON'T REMOVE)

    //put your code here...
    if(widgetTemplateButton.isMouseHere()){
      widgetTemplateButton.setIsActive(true);
    }

  }

  void mouseReleased(){
    super.mouseReleased(); //calls the parent mouseReleased() method of Widget (DON'T REMOVE)

    //put your code here...
    if(widgetTemplateButton.isActive && widgetTemplateButton.isMouseHere()){
      widgetTemplateButton.goToURL();
    }
    widgetTemplateButton.setIsActive(false);

  }

  //add custom functions here
  void customFunction(){
    //this is a fake function... replace it with something relevant to this widget

  }

};

//These functions need to be global! These functions are activated when an item from the corresponding dropdown is selected
void Dropdown1(int n){
  println("Item " + (n+1) + " selected from Dropdown 1");
  if(n==0){
    //do this
  } else if(n==1){
    //do this instead
  }

  closeAllDropdowns(); // do this at the end of all widget-activated functions to ensure proper widget interactivity ... we want to make sure a click makes the menu close
}

void Dropdown2(int n){
  println("Item " + (n+1) + " selected from Dropdown 2");
  closeAllDropdowns();
}

void Dropdown3(int n){
  println("Item " + (n+1) + " selected from Dropdown 3");
  closeAllDropdowns();
}

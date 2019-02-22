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
   

//*draw wave////
  int Nmax = 500 ; //这个是球体的面数


float M = 50 ;//

float H = 0.95 ; float HH = 0.01 ;

float X[] = new float[Nmax+1] ; float Y[] = new float[Nmax+1] ; float Z[] = new float[Nmax+1] ;
float V[] = new float[Nmax+1] ; float dV[] = new float[Nmax+1] ; 
float L ; float R = 2*sqrt((4*PI*(200*200)/Nmax)/(2*sqrt(3))) ;
float Lmin ; int N ; int NN ; 
float KX ; float KY ; float KZ ; 
float KV ; float KdV ; int K ;



/////draw wave end/////

void draw_wave_1(){  
 // background(0) ;
  float diameter=0.8;
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
          stroke(255-Result_Avg_Mind_Score*2.55,Result_Avg_Mind_Score*2.55,0,125+(Z[N]/2));
          
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
     
      Z[N] = (KZ*cos(float(300-mouseX)/10000))-(KX*sin(float(300-mouseX)/10000)) ;
     X[N] = (KZ*sin(float(300-mouseX)/10000))+(KX*cos(float(300-mouseX)/10000)) ;
     KZ = Z[N] ; KY = Y[N] ;
     Z[N] = (KZ*cos(float(300-mouseY)/10000))-(KY*sin(float(300-mouseY)/10000)) ;
     Y[N] = (KZ*sin(float(300-mouseY)/10000))+(KY*cos(float(300-mouseY)/10000)) ;
          
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
  if ( K == 0 ){ dV[NN] = -score*1.3 ; K = 1 ; }  // dV[NN]=xxx，这是突峰的强度
           else{ dV[NN] = +score*1.3 ; K = 0 ; }  // dV[NN]=xxx，这是突峰的强度
}

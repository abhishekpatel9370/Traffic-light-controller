module traffic_controller(clk,reset,highway_road,country_road,Redhigh,Greenhigh,Yellowhigh,Redcountry,Greencountry,Yellowcountry);
input clk,reset;
input highway_road,country_road;
output reg Redhigh,Greenhigh,Yellowhigh,Redcountry,Greencountry,Yellowcountry;
reg [3:0] p_state,n_state;
parameter s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6,s7=7,s8=8,s9=9,s10=10,s11=11,s12=12;
 
 always@(posedge clk or posedge reset )
if(reset)               // sequential logic for reset
begin p_state<=s0;end
else 
p_state<=n_state;


always@(*)
begin 
n_state=p_state;
case(p_state)
s0,s1,s2,s3,s4,s6,s7,s8,s9,s10: // in this state clock is shift just like timmer
n_state<=p_state +1; // for highway we give 60 sec ie 6 state each of 10 sec and for country give 50 sec ie
s5 : if(country_road)// 5 state each of 10 sec
    n_state<=s6;
    else
    n_state<=s5;
 s11: if (~highway_road & country_road) // if highway =0 and ccountry =1  then we give  an extra 10 sec for country state
            n_state<=s11;
       else if (highway_road | country_road)// if highway =1 and ccountry =0  then we give  an extra 10 sec for country state
                n_state<=12;
 s12 : n_state<=s0;
 default : n_state<=s0;
 endcase
 end
 
 always@(*)
 begin 
 Redhigh=0;
 Greenhigh=0;
 Yellowhigh=0;
 Redcountry=0;
 Greencountry=0;
 Yellowcountry=0;
 case(p_state)
 s0,s1,s2,s3,s4,s5:
 begin 
 Redcountry=1;
 Greenhigh=1;
 end
 s6 :begin Yellowhigh=1;
       Redcountry=1;end
   s7,s8,s9,s10,s11 :   
   begin 
   Redhigh=1;
   Greencountry=1; end
 s12 : begin    Redhigh=1;
                Yellowcountry=1;
                end
                endcase
                end
                endmodule    
 
    

   
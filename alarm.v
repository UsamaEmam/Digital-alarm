`timescale 1us / 1ps
//////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////
module alarm (
input reset , clk,
input [1:0] hourIn1,   
input [3:0] hourIn0,minIn0,minIn1,
/*	ldTime loads the acusl time with the input time ( hourIn0,hourIn1,minIn0 and minIn1 ).
	ldAlarm set the new alarm time from input time ( hourIn0,hourIn1,minIn0 and minIn1 ).*/
input ldTime ,ldAlarm,		

/*alarmOn enables the alarm to be on if alarm time equals the acual time.*/
input alarmOn,

/* alarm is on when acual time is eqial to setted alarm time*/
output reg alarm,
output reg [1:0] hourOut1,   
output reg [3:0] hourOut0,minOut0,minOut1
);


/*temporary reg to set the  acual time and the alarm time*/   
reg [1:0] hourAlarm1, hourTime1;   
reg [3:0] hourAlarm0,minAlarm0,minAlarm1,hourTime0,minTime0,minTime1;
reg [3:0] secTime1,secTime0;
always@(posedge clk or posedge reset) begin

/* resseting acual time , alarm time and output time when rest is 1 */
if(reset) begin
alarm<=0;
hourOut1<=2'b0;hourOut0<=4'b0;minOut0<=4'b0;minOut1<=4'b0;
hourAlarm1<=2'b0;hourAlarm0<=4'b0;minAlarm0<=4'b0;minAlarm1<=4'b0;
hourTime1<=2'b0;hourTime0<=4'b0;minTime0<=4'b0;minTime1<=4'b0;
secTime0<=0;secTime1<=0;
end
else begin 
/* loading the acual time with input time*/
if(ldTime) begin
hourTime1<=hourIn1;   
hourTime0<=hourIn0;
minTime0<=minIn0;
minTime1<=minIn1;
end
/* loading the alarm time with input time*/

if(ldAlarm) begin
hourAlarm1<=hourIn1;   
hourAlarm0<=hourIn0;
minAlarm1<=minIn1;
minAlarm0<=minIn0;
end
/* check if alarm time = acual time*/
 
 if({hourAlarm1,hourAlarm0,minAlarm1,minAlarm0}=={hourTime1,hourTime0,minTime1,minTime0}) begin
 if(alarmOn) begin
 alarm<=1'b1;
hourOut1<=hourTime1;   
hourOut0<=hourTime0;
minOut0<=minTime0;
minOut1<=minTime1;
end
else alarm<=0;
			end



/* acual time increment */
secTime0 <= secTime0 + 1 ;
if(secTime0==10) begin 
secTime1<=secTime1+1;
secTime0<=0;
end

if(secTime1==6) begin 
minTime0<=minTime0+1;
secTime1<=0;
end

if(minTime0==10) begin 
minTime1<=minTime1+1;
minTime0<=0;
end

if(minTime1==6) begin 
hourTime0<=hourTime0+1;
minTime1<=0;
end

if(hourTime0==10) begin 
hourTime1<=hourTime1+1;
hourTime0<=0;
end

if(hourTime1==3) begin 
hourTime1<=0;
end


end



end

endmodule
